/*
 * test jig for run-length encoding of silences for 8 khz codec data 
 */
#import "sound.h"

check_error(int err)
{
    if (err) {
	printf("Error : %s\n",SNDSoundError(err));
	exit(1);
    }
    return err;
}

main (int argc, char *argv[])
{
    int err;
    SNDSoundStruct *s1, *s2;
    SNDSoundStruct s3 = {
	SND_MAGIC, 0, 0, 
	SND_FORMAT_MULAW_SQUELCH, (int)SND_RATE_CODEC, 1, "" };

    check_error(argc != 3);
    
    printf("converting file %s\n",argv[1]);
    err = SNDReadSoundfile(argv[1],&s1);
    check_error(err);
    s2 = &s3;
    err = SNDConvertSound(s1,&s2);
    check_error(err);
    err = SNDWriteSoundfile(argv[2],s2);
    check_error(err);
    exit(0);
}


