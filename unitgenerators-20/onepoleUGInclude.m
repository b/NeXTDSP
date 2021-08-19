/* This source file was auto-generated by dspwrap from dsp macro onepole.
   It is included by unit generator OnepoleUG. It should not be edited.*/
#import <musickit/UnitGenerator.h>

static MKMasterUGStruct _masterUGStruct = {
   5 /* nArgs */,
   {0,3,0,0,2,0,0,0,0,0,0,0,0} /* globalSymCount */,
   {1,0,0} /* fixupCount */
};

+(MKMasterUGStruct *)masterUGPtr { return &_masterUGStruct; }

+initialize  /* Sent once on class start-up. */
{
#  define OFFSET(_x) _x.value.i
   static DSPSymbol _argSymbols[5];
   static DSPSymbol _symbolsX[] = {
      {DSP_LC_X,"orch_onepole_1_ainp","GRI"},
      {DSP_LC_X,"orch_onepole_1_aout","GRI"},
      {DSP_LC_X,"orch_onepole_1_s","GRI"}
   };
   static DSPSymbol _symbolsY[] = {
      {DSP_LC_Y,"orch_onepole_1_aa1","GRI"},
      {DSP_LC_Y,"orch_onepole_1_bb0","GRI"}
   };
   _masterUGStruct.symbols[(int)DSP_LC_X] = _symbolsX;
   _masterUGStruct.symbols[(int)DSP_LC_Y] = _symbolsY;
   OFFSET(_symbolsX[0]) = 1;
   OFFSET(_symbolsX[1]) = 0;
   OFFSET(_symbolsX[2]) = 2;
   OFFSET(_symbolsY[0]) = 1;
   OFFSET(_symbolsY[1]) = 0;
   _argSymbols[(int)ainp] = _symbolsX[0];
   _argSymbols[(int)aout] = _symbolsX[1];
   _argSymbols[(int)s] = _symbolsX[2];
   _argSymbols[(int)aa1] = _symbolsY[0];
   _argSymbols[(int)bb0] = _symbolsY[1];
   _masterUGStruct.argSymbols = _argSymbols;
   return self;
}
