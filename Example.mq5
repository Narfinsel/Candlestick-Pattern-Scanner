#include "CandlestickPatternScanner.mqh"


CandlestickPatternScanner * cps;
CandlestickPattern * patternDetected;

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

void OnTick(){
   patternDetected = cps.updateAndReturn_Cps_onNewBar();
}

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

void OnDeinit (const int reason){
   delete cps;
   delete patternDetected;
}