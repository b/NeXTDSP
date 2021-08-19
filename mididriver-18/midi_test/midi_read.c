/*
 * Get a bunch of data from MIDI in.
 */
#import <mach.h>
#import <stdio.h>
#import <stdlib.h>
#import <mach_error.h>
#import <servers/netname.h>

#import <midi/midi_server.h>
#import <midi/midi_reply_handler.h>
#import <midi/midi_timer.h>
#import <midi/midi_timer_reply_handler.h>
#import <midi/midi_error.h>
#import <midi/midi_timer_error.h>

/*
 * These routines should be prototyped someplace in /usr/include!
 */
int getopt(int argc, char **argv, char *optstring);
int write(int fd, char *data, int size);

void usage(void);

port_t dev_port;
port_t owner_port;
port_t timer_port;
port_t timer_reply_port;
port_t recv_port;
port_t recv_reply_port;
port_t xmit_port;
port_t neg_port;
port_set_name_t port_set;
int secs = 1;
int verbose;

kern_return_t my_timer_event (
	void *arg,
	timeval_t timeval,
	u_int quanta,
	u_int usec_per_quantum,
	u_int real_usec_per_quantum,
	boolean_t timer_expired,
	boolean_t timer_stopped,
	boolean_t timer_forward);

midi_timer_reply_t midi_timer_reply = {
	my_timer_event,
	0,
	0
};

kern_return_t my_ret_raw_data(
	void *		arg,
	midi_raw_t	midi_raw_data,
	u_int		midi_raw_dataCnt);
kern_return_t my_ret_cooked_data(
	void *		arg,
	midi_cooked_t	midi_cooked_data,
	u_int		midi_cooked_dataCnt);
kern_return_t my_ret_packed_data(
	void *		arg,
	u_int		quanta,
	midi_packed_t	midi_packed_data,
	u_int		midi_packed_dataCnt);
kern_return_t my_queue_notify(
	void *		arg,
	u_int		queue_size);

midi_reply_t midi_reply = {
	my_ret_raw_data,
	my_ret_cooked_data,
	my_ret_packed_data,
	my_queue_notify,
	0,
	0
};

main(int argc, char **argv)
{
	int i, data_format = MIDI_PROTO_RAW;
	kern_return_t r;
	boolean_t timer_too = FALSE;
	msg_header_t *in_msg, *out_msg;
	extern char *optarg;
	extern int optind;
	
	while ((i = getopt(argc, argv, "crpvt")) != EOF)
		switch (i) {
		case 'r':
			data_format = MIDI_PROTO_RAW;
			break;
		case 'c':
			data_format = MIDI_PROTO_COOKED;
			break;
		case 'p':
			data_format = MIDI_PROTO_PACKED;
			break;
		case 'v':
			verbose++;
			break;
		case 't':
			timer_too = TRUE;
			break;
		case '?':
		default:
			usage();
			exit(1);
		}

	/*
	 * Get a connection to the midi driver.
	 */
	r = netname_look_up(name_server_port, "", "midi1", &dev_port);
	if (r != KERN_SUCCESS) {
		mach_error("timer_track: netname_look_up error", r);
		exit(1);
	}

	/*
	 * Become owner of the device.
	 */
	r = port_allocate(task_self(), &owner_port);
	if (r != KERN_SUCCESS) {
		mach_error("allocate owner port", r);
		exit(1);
	}

	neg_port = PORT_NULL;
	r = midi_set_owner(dev_port, owner_port, &neg_port);
	if (r != KERN_SUCCESS) {
		midi_error("become owner", r);
		exit(1);
	}

	/*
	 * Get the timer port for the device.
	 */
	r = midi_get_out_timer_port(dev_port, &timer_port);
	if (r != KERN_SUCCESS) {
		midi_error("output timer port", r);
		exit(1);
	}

	/*
	 * Get the receive port for the device.
	 */
	r = midi_get_recv(dev_port, owner_port, &recv_port);
	if (r != KERN_SUCCESS) {
		midi_error("recv port", r);
		exit(1);
	}

	r = port_allocate(task_self(), &timer_reply_port);
	if (r != KERN_SUCCESS) {
		mach_error("allocate timer reply port", r);
		exit(1);
	}

	/*
	 * Find out what time it is (and other vital information).
	 */
	r = port_allocate(task_self(), &recv_reply_port);
	if (r != KERN_SUCCESS) {
		mach_error("allocate timer reply port", r);
		exit(1);
	}

	/*
	 * Tell it to ignore system messages we're not interested in.
	 */
	r = midi_set_sys_ignores(recv_port, (
		  MIDI_IGNORE_ACTIVE_SENS
		| MIDI_IGNORE_TIMING_CLCK
		| MIDI_IGNORE_START
		| MIDI_IGNORE_CONTINUE
		| MIDI_IGNORE_STOP
		| MIDI_IGNORE_SONG_POS_P));
	if (r != KERN_SUCCESS) {
		mach_error("midi_set_sys_ignores", r);
		exit(1);
	}

	/*
	 * Set the protocol to indicate our preferences.
	 */
	r = midi_set_proto(recv_port,
		data_format,		// raw, cooked, or packed
		FALSE,			// absolute time codes wanted
		MIDI_PROTO_SYNC_SYS,	// use system clock
		10,			// 10 clocks before data sent
		2,			// 2 clock timeout between input chars
		8192);			// maximum output queue size
	if (r != KERN_SUCCESS) {
		mach_error("midi_set_proto", r);
		exit(1);
	}

	/*
	 * Get it to send us received data.
	 */
	r = midi_get_data(recv_port, recv_reply_port);	// from now
	if (r != KERN_SUCCESS) {
		midi_timer_error("midi_get_data", r);
		exit(1);
	}

	/*
	 * Allocate port set.
	 */
	r = port_set_allocate(task_self(), &port_set);
	if (r != KERN_SUCCESS) {
		mach_error("allocate port set", r);
		exit(1);
	}

	/*
	 * Add timer receive port to port set.
	 */
	r = port_set_add(task_self(), port_set, timer_reply_port);
	if (r != KERN_SUCCESS) {
		mach_error("add timer_reply_port to set", r);
		exit(1);
	}

	/*
	 * Add data receive port to port set.
	 */
	r = port_set_add(task_self(), port_set, recv_reply_port);
	if (r != KERN_SUCCESS) {
		mach_error("add recv_reply_port to set", r);
		exit(1);
	}

	if (timer_too) {
		r = timer_quanta_req(timer_port, timer_reply_port,
			0,	// 0 quanta
			TRUE);	// from now
		if (r != KERN_SUCCESS) {
			midi_timer_error("request timer", r);
			exit(1);
		}
	}

	/*
	 * Start the timer up.
	 */
	r = timer_start(timer_port, owner_port);
	if (r != KERN_SUCCESS) {
		midi_error("timer start", r);
		exit(1);
	}

	/*
	 * Enter the timer loop.
	 */
	in_msg = (msg_header_t *)malloc(MSG_SIZE_MAX);
	out_msg = (msg_header_t *)malloc(MSG_SIZE_MAX);
	while (1) {
		in_msg->msg_size = MSG_SIZE_MAX;
		in_msg->msg_local_port = port_set;
		
		r = msg_receive(in_msg, MSG_OPTION_NONE, 0);
		if (r != KERN_SUCCESS) {
			mach_error("msg_receive", r);
			exit(1);
		}

		if (in_msg->msg_local_port == recv_reply_port)
			r = midi_reply_handler(in_msg,
				&midi_reply);
		else if (in_msg->msg_local_port == timer_reply_port)
			r = midi_timer_reply_handler(in_msg,
				&midi_timer_reply);
		else {
			fprintf(stderr, "unknown port\n");
			r = KERN_FAILURE;
		}
		if (r != KERN_SUCCESS)
			mach_error("midi_timer_reply_server", r);
	}
}

void usage(void)
{
	fprintf(stderr, "usage: midi_read [-d delay]\n");
}

kern_return_t my_timer_event (
	void *arg,
	timeval_t timeval,
	u_int quanta,
	u_int usec_per_quantum,
	u_int real_usec_per_quantum,
	boolean_t timer_expired,
	boolean_t timer_stopped,
	boolean_t timer_forward)
{
	kern_return_t r;
	static int nquanta;
	nquanta += secs * 1000000 / usec_per_quantum;
	fprintf(stderr,
		"time is %d usec/quantum %d\n", quanta, real_usec_per_quantum);

	if (!timer_expired) {
		printf("timer hasn't expired\n");
		return KERN_SUCCESS;
	}

	r = timer_quanta_req(timer_port, timer_reply_port,
		nquanta,		// secs seconds from
		FALSE);			// from timer base
	if (r != KERN_SUCCESS) {
		midi_timer_error("request timer", r);
		exit(1);
	}

	return KERN_SUCCESS;
}

kern_return_t my_ret_raw_data(
	void *		arg,
	midi_raw_t	midi_raw_data,
	u_int		midi_raw_dataCnt)
{
	if (verbose) {
		while (midi_raw_dataCnt--) {
			printf("0x%x@%d ", midi_raw_data->data,
				midi_raw_data->quanta);
			midi_raw_data++;
		}
		printf("\n");
	} else {
		write(1, (char *)midi_raw_data,
			midi_raw_dataCnt*sizeof(*midi_raw_data));
		fprintf(stderr, "<%d>", midi_raw_dataCnt);
	}

	midi_get_data(recv_port, recv_reply_port);
}

kern_return_t my_ret_cooked_data(
	void *		arg,
	midi_cooked_t	midi_cooked_data,
	u_int		midi_cooked_dataCnt)
{
	if (verbose) {
		while (midi_cooked_dataCnt--) {
			switch (midi_cooked_data->ndata) {
			case 1:
				printf("(0x%x)@%d ",
					midi_cooked_data->data[0],
					midi_cooked_data->quanta);
				break;
			case 2:
				printf("(0x%x:0x%x)@%d ",
					midi_cooked_data->data[0],
					midi_cooked_data->data[1],
					midi_cooked_data->quanta);
				break;
			case 3:
				printf("(0x%x:0x%x:0x%x)@%d ",
					midi_cooked_data->data[0],
					midi_cooked_data->data[1],
					midi_cooked_data->data[2],
					midi_cooked_data->quanta);
				break;
			}
			midi_cooked_data++;
		}
		printf("\n");
	} else
		write(1, (char *)midi_cooked_data,
			midi_cooked_dataCnt*sizeof(*midi_cooked_data));

	midi_get_data(recv_port, recv_reply_port);
}

kern_return_t my_ret_packed_data(
	void *		arg,
	u_int		quanta,
	midi_packed_t	midi_packed_data,
	u_int		midi_packed_dataCnt)
{
	if (verbose) {
		printf("(");
		while (midi_packed_dataCnt--)
			printf("0x%x:", *midi_packed_data++);
		printf(")@%d\n", quanta);
	} else
		write(1, (char *)midi_packed_data,
			midi_packed_dataCnt*sizeof(*midi_packed_data));

	midi_get_data(recv_port, recv_reply_port);
}

kern_return_t my_queue_notify(
	void *		arg,
	u_int		queue_size)
{
}

