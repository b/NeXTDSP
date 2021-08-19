/* This class was auto-generated by dspwrap from macro onepole. 
   It should not be edited. */

#import "OnepoleUGyx.h"

@implementation OnepoleUGyx : OnepoleUG

/* times in seconds/sample */
#define COMPUTETIME (84 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))
#define OFFCHIP_COMPUTETIME (158 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))

static MKLeafUGStruct _leafUGStruct = {
    {3/* xArg  */,  2/* yArg  */,  0/* lArg */,
     11/* pLoop */,  0/* pSubr */,
     0/* xData */,  0/* yData */} /* memory requirements */, COMPUTETIME};

+(MKLeafUGStruct *)classInfo  
{   if (_leafUGStruct.master == NULL)
      _leafUGStruct.master = [self masterUGPtr];
    return &_leafUGStruct; }

+initialize /* Sent once on factory start-up. */
{
enum args { ainp, aout, s, aa1, bb0 };
   static DSPMemorySpace _argSpaces[] = {DSP_MS_X,DSP_MS_Y,DSP_MS_N,DSP_MS_N,DSP_MS_N};
   static DSPDataRecord _dataRecP = {NULL, DSP_LC_P, 0, 1, 11}; 
   static int _dataP[] = {0x66d800,0x61d800,0xf48000,0x44d900,0x4fdcd0,
                          0x44d9f7,0x60f80,0x89,0x165ed0,0x44d9f7,
                          0xba5800};
   static DSPFixup _fixupsP[] = {
   {DSP_LC_P, NULL, 1 /* decrement */, 7 /* refOffset */,  9 /* relAddress */}
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
