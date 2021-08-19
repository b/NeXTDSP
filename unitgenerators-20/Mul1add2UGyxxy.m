/* This class was auto-generated by dspwrap from macro mul1add2. 
   It should not be edited. */

#import "Mul1add2UGyxxy.h"

@implementation Mul1add2UGyxxy : Mul1add2UG

/* times in seconds/sample */
#define COMPUTETIME (154 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))
#define OFFCHIP_COMPUTETIME (264 * (DSP_CLOCK_PERIOD / DSPMK_I_NTICK))

static MKLeafUGStruct _leafUGStruct = {
    {2/* xArg  */,  2/* yArg  */,  0/* lArg */,
     15/* pLoop */,  0/* pSubr */,
     0/* xData */,  0/* yData */} /* memory requirements */, COMPUTETIME};

+(MKLeafUGStruct *)classInfo  
{   if (_leafUGStruct.master == NULL)
      _leafUGStruct.master = [self masterUGPtr];
    return &_leafUGStruct; }

+initialize /* Sent once on factory start-up. */
{
enum args { i1adr, i2adr, aout, i3adr };
   static DSPMemorySpace _argSpaces[] = {DSP_MS_X,DSP_MS_X,DSP_MS_Y,DSP_MS_Y};
   static DSPDataRecord _dataRecP = {NULL, DSP_LC_P, 0, 1, 15}; 
   static int _dataP[] = {0x61d800,0x65d800,0x220500,0x68dc00,0x6edc00,
                          0x56d900,0x46dd00,0x4cd800,0x61080,0x8c,
                          0x46ddd3,0x4cd800,0xbad900,0x20b000,0x0};
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
