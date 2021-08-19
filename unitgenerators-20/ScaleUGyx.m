/* This class was auto-generated by dspwrap from macro scale. 
   It should not be edited. */

#import "ScaleUGyx.h"

@implementation ScaleUGyx : ScaleUG

/* times in seconds/sample */
#define COMPUTETIME (78 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))
#define OFFCHIP_COMPUTETIME (120 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))

static MKLeafUGStruct _leafUGStruct = {
    {1/* xArg  */,  2/* yArg  */,  0/* lArg */,
     9/* pLoop */,  0/* pSubr */,
     0/* xData */,  0/* yData */} /* memory requirements */, COMPUTETIME};

+(MKLeafUGStruct *)classInfo  
{   if (_leafUGStruct.master == NULL)
      _leafUGStruct.master = [self masterUGPtr];
    return &_leafUGStruct; }

+initialize /* Sent once on factory start-up. */
{
enum args { ainp, aout, ginp };
   static DSPMemorySpace _argSpaces[] = {DSP_MS_X,DSP_MS_Y,DSP_MS_N};
   static DSPDataRecord _dataRecP = {NULL, DSP_LC_P, 0, 1, 9}; 
   static int _dataP[] = {0x61d800,0x6edc00,0x4fdc00,0x44d900,0x44d9c1,
                          0x60f80,0x87,0xb2d9c1,0x5e5e00};
   static DSPFixup _fixupsP[] = {
   {DSP_LC_P, NULL, 1 /* decrement */, 6 /* refOffset */,  7 /* relAddress */}
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
