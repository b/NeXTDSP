/* This source file was auto-generated by dspwrap from dsp macro out1b.
   It is included by unit generator Out1bUG. It should not be edited.*/
#import <musickit/UnitGenerator.h>

static MKMasterUGStruct _masterUGStruct = {
   2 /* nArgs */,
   {0,1,0,0,1,0,0,0,0,0,0,0,0} /* globalSymCount */,
   {1,0,0} /* fixupCount */
};

+(MKMasterUGStruct *)masterUGPtr { return &_masterUGStruct; }

+initialize  /* Sent once on class start-up. */
{
#  define OFFSET(_x) _x.value.i
   static DSPSymbol _argSymbols[2];
   static DSPSymbol _symbolsX[] = {
      {DSP_LC_X,"orch_out1b_1_sclB","GRI"}
   };
   static DSPSymbol _symbolsY[] = {
      {DSP_LC_Y,"orch_out1b_1_iadr","GRI"}
   };
   _masterUGStruct.symbols[(int)DSP_LC_X] = _symbolsX;
   _masterUGStruct.symbols[(int)DSP_LC_Y] = _symbolsY;
   OFFSET(_symbolsX[0]) = 0;
   OFFSET(_symbolsY[0]) = 0;
   _argSymbols[(int)sclB] = _symbolsX[0];
   _argSymbols[(int)iadr] = _symbolsY[0];
   _masterUGStruct.argSymbols = _argSymbols;
   return self;
}
