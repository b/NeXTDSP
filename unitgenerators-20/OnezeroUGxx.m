/* This class was auto-generated by dspwrap from macro onezero. 
   It should not be edited. */

#import "OnezeroUGxx.h"

@implementation OnezeroUGxx : OnezeroUG

/* times in seconds/sample */
#define COMPUTETIME (116 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))
#define OFFCHIP_COMPUTETIME (224 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))

static MKLeafUGStruct _leafUGStruct = {
    {3/* xArg  */,  2/* yArg  */,  0/* lArg */,
     14/* pLoop */,  0/* pSubr */,
     0/* xData */,  0/* yData */} /* memory requirements */, COMPUTETIME};

+(MKLeafUGStruct *)classInfo  
{   if (_leafUGStruct.master == NULL)
      _leafUGStruct.master = [self masterUGPtr];
    return &_leafUGStruct; }

+initialize /* Sent once on factory start-up. */
{
enum args { ainp, aout, s, bb0, bb1 };
   static DSPMemorySpace _argSpaces[] = {DSP_MS_X,DSP_MS_X,DSP_MS_N,DSP_MS_N,DSP_MS_N};
   static DSPDataRecord _dataRecP = {NULL, DSP_LC_P, 0, 1, 14}; 
   static int _dataP[] = {0x66d800,0x61d800,0xf48000,0x4fdc00,0x44e100,
                          0x45d9f0,0x44e1d3,0x60f80,0x8b,0x565e00,
                          0x45d9f0,0x44e1d3,0x565e00,0x455800};
   static DSPFixup _fixupsP[] = {
   {DSP_LC_P, NULL, 1 /* decrement */, 8 /* refOffset */,  11 /* relAddress */}
   };
   _leafUGStruct.master = NULL;
   _leafUGStruct.argSpaces = _argSpaces;
   _leafUGStruct.data[(int)DSP_LC_P] = &_dataRecP;
   _dataRecP.data = _dataP;
   _leafUGStruct.fixups[(int)DSP_LC_P - (int)DSP_LC_P_BASE] = _fixupsP;
   MKInitUnitGeneratorClass(&_leafUGStruct);
   _leafUGStruct.reserved1 = MK_2COMPUTETIMES;
   _leafUGStruct.offChipComputeTime = OFFCHIP_COMPUTETIME;
   return self;
}
@end
