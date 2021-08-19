/* This class was auto-generated by dspwrap from macro unoise. 
   It should not be edited. */

#import "UnoiseUGx.h"

@implementation UnoiseUGx : UnoiseUG

/* times in seconds/sample */
#define COMPUTETIME (116 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))
#define OFFCHIP_COMPUTETIME (160 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))

static MKLeafUGStruct _leafUGStruct = {
    {1/* xArg  */,  1/* yArg  */,  0/* lArg */,
     15/* pLoop */,  0/* pSubr */,
     0/* xData */,  0/* yData */} /* memory requirements */, COMPUTETIME};

+(MKLeafUGStruct *)classInfo  
{   if (_leafUGStruct.master == NULL)
      _leafUGStruct.master = [self masterUGPtr];
    return &_leafUGStruct; }

+initialize /* Sent once on factory start-up. */
{
enum args { aout, seed };
   static DSPMemorySpace _argSpaces[] = {DSP_MS_X,DSP_MS_N};
   static DSPDataRecord _dataRecP = {NULL, DSP_LC_P, 0, 1, 15}; 
   static int _dataP[] = {0x66d81b,0x51f400,0x2,0x4ce401,0x45f400,
                          0x5599d1,0x2000a2,0x200022,0x60f80,0x8c,
                          0x210401,0x445ea2,0x200022,0x505e00,0x585c00};
   static DSPFixup _fixupsP[] = {
   {DSP_LC_P, NULL, 1 /* decrement */, 9 /* refOffset */,  12 /* relAddress */}
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
