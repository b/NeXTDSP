/* This class was auto-generated by dspwrap from macro interp. 
   It should not be edited. */

#import "InterpUGxyxx.h"

@implementation InterpUGxyxx : InterpUG

/* times in seconds/sample */
#define COMPUTETIME (156 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))
#define OFFCHIP_COMPUTETIME (296 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))

static MKLeafUGStruct _leafUGStruct = {
    {2/* xArg  */,  2/* yArg  */,  0/* lArg */,
     17/* pLoop */,  0/* pSubr */,
     0/* xData */,  0/* yData */} /* memory requirements */, COMPUTETIME};

+(MKLeafUGStruct *)classInfo  
{   if (_leafUGStruct.master == NULL)
      _leafUGStruct.master = [self masterUGPtr];
    return &_leafUGStruct; }

+initialize /* Sent once on factory start-up. */
{
enum args { i1adr, i3adr, aout, i2adr };
   static DSPMemorySpace _argSpaces[] = {DSP_MS_Y,DSP_MS_X,DSP_MS_X,DSP_MS_X};
   static DSPDataRecord _dataRecP = {NULL, DSP_LC_P, 0, 1, 17}; 
   static int _dataP[] = {0x61d800,0x6ddc00,0x44d800,0x6edc00,0x4dd900,
                          0x57dd00,0x220700,0x20906c,0x0,0x61080,
                          0x8e,0x129861,0x4dd9d3,0x57dd00,0x565e6c,
                          0x20f000,0x0};
   static DSPFixup _fixupsP[] = {
   {DSP_LC_P, NULL, 1 /* decrement */, 10 /* refOffset */,  14 /* relAddress */}
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
