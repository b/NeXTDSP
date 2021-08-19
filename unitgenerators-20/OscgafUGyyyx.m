/* This class was auto-generated by dspwrap from macro oscgaf. 
   It should not be edited. */

#import "OscgafUGyyyx.h"

@implementation OscgafUGyyyx : OscgafUG

/* times in seconds/sample */
#define COMPUTETIME (194 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))
#define OFFCHIP_COMPUTETIME (344 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))

static MKLeafUGStruct _leafUGStruct = {
    {3/* xArg  */,  3/* yArg  */,  1/* lArg */,
     20/* pLoop */,  0/* pSubr */,
     0/* xData */,  0/* yData */} /* memory requirements */, COMPUTETIME};

+(MKLeafUGStruct *)classInfo  
{   if (_leafUGStruct.master == NULL)
      _leafUGStruct.master = [self masterUGPtr];
    return &_leafUGStruct; }

+initialize /* Sent once on factory start-up. */
{
enum args { aina, atab, inc, ainf, aout, mtab, phs };
   static DSPMemorySpace _argSpaces[] = {DSP_MS_Y,DSP_MS_X,DSP_MS_N,DSP_MS_Y,DSP_MS_Y,DSP_MS_N,DSP_MS_N};
   static DSPDataRecord _dataRecP = {NULL, DSP_LC_P, 0, 1, 20}; 
   static int _dataP[] = {0x6edc00,0x6ddc00,0xf49800,0x44d800,0x61d81b,
                          0x41e200,0x606200,0x20b000,0x5efe5e,0x21b800,
                          0x61080,0x90,0x4dd900,0x4fdd00,0x5e5eca,
                          0x47e85e,0x21b8f1,0x5e5e00,0x60e200,0x415a00};
   static DSPFixup _fixupsP[] = {
   {DSP_LC_P, NULL, 1 /* decrement */, 11 /* refOffset */,  16 /* relAddress */}
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
