//Step 1. Include the class file in your trading robot. 
//The file-path (inside the "#include" preprocessor directive) might change depending on your folder structure or where you place the file:

#include "CandlestickPatternScanner.mqh"

//Step 2. Declare two global or local variables of type "CandlestickPatternScanner" and "CandlestickPattern". Note that "CandlestickPatternScanner" detects, stores and retrieves objects of type "CandlestickPattern", which are captured and saved at pointer location, as defined below:
CandlestickPatternScanner * cps;
CandlestickPattern * patternDetected;
//Step 3. Initialize the CandlestickPatternScanner object. The best place for this is inside the OnInit() function.
int OnInit(){
   cps = new CandlestickPatternScanner (Symbol(), PERIOD_CURRENT, 15, true);
   cps.adjust_Settings_Graphic_BearishReversals (clrDeepPink, STYLE_SOLID, 4);
   cps.adjust_Settings_Graphic_BullishReversals (clrAqua, STYLE_SOLID, 4);
   cps.adjust_Settings_Chart_Subwindow (0, 0);
   cps.adjust_Settings_Engulfings (0.75, 5);
   cps.adjust_Settings_Stars (0.25, 40, 0.35);
   cps.setDoDrawCandlePatternRect (true);

   return(INIT_SUCCEEDED);
}
// Step 4. Activate the CandlestickPatternScanner (cps), and set it up so that it extracts the most recent price reversal pattern (captured at pointer variable CandlestickPattern (patternDetected)).

void OnTick(){
   patternDetected = cps.updateAndReturn_Cps_onNewBar();
}

// Step 5. Everything is set up. Use both objects and the most recently detected reversal pattern (bullish / bearish) in your code logic for the algorithm, to determine trading outcome.

bool validateOpenBuy (){
   if(patternDetected != NULL){
         if(patternDetected.getPatternType() == BULLISH_ENGULFING)
            return true;
      else if(patternDetected.getPatternType() == BULLISH_MORNING_STAR)
            return true;
   }
   return false;
}

bool validateOpenSell (){
   if(patternDetected != NULL){
         if(patternDetected.getPatternType() == BEARISH_ENGULFING)
            return true;
      else if(patternDetected.getPatternType() == BEARISH_EVENING_STAR)
            return true;
   }
   return false;
}
//Step 6. Memory clean-up, optimization, object deletion. Clean-up is by default automatically performed by the CandlestickPatternScanner in two ways:
void OnDeinit (const int reason){
   delete cps;
   delete patternDetected;
}