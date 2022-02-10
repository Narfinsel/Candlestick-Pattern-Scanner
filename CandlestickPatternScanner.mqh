//+------------------------------------------------------------------+
//|                                    CandlestickPatternScanner.mqh |
//|                                               Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "SimonG"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <__SimonG\MS\CandlestickPatternScanner\Patterns\CandlestickPattern.mqh>
#include <__SimonG\MS\CandlestickPatternScanner\Patterns\ConsolidationPattern.mqh>
#include <__SimonG\MS\CandlestickPatternScanner\Patterns\EngulfingPattern.mqh>
#include <__SimonG\MS\CandlestickPatternScanner\Patterns\StarPattern.mqh>
#include <__SimonG\Helpers\GeneralHelper.mqh>

class CandlestickPatternScanner {
   private:
      string cpsSymbol;
      ENUM_TIMEFRAMES cpsTimeframe;
      bool cpsIs5DigitBroker;
      double cpsPointModeSize;
      CandlestickPattern * newPattern;
      bool cpsDoDrawCandleRects;
      long cpsChartId;
      int cpsSubwindowId;
      
      CandlestickPattern * cpArray[];
      int cpsMaxArraySize;
      
      double cpsEngdMinFractionShortVsLongLength;
      double cpsEngMinShortEngulfBarLength;
      double cpsStarMinPercOCofHL;
      double cpsStarMinHiLoLength;
      double cpsStarToleranceAreaPercForOC;
      
      color cpsColorBearish, cpsColorBullish;
      ENUM_LINE_STYLE cpsStyleBearish, cpsStyleBullish;
      int cpsThicknessBearish, cpsThicknessBullish;
      
      CandlestickPatternScanner();
      void setupCandlestickPatternScanner (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int anArraySize, bool aIs5DigitBroker);
      bool hasDetectedBearishReversal (CandlestickPattern * pattern);
      bool hasDetectedBullishReversal (CandlestickPattern * pattern);
      string generateNameForCp (string aSymbol, ENUM_TIMEFRAMES aTimeframe);
      bool find_CandlestickPattern_Object_byName (string aSymbol, ENUM_TIMEFRAMES aTimeframe);
      void checkTo_Delete_CandlestickPattern (string aSymbol, ENUM_TIMEFRAMES aTimeframe);
      bool appendPatternToBeginningOfArray (CandlestickPattern * aPattern, CandlestickPattern *& anArray[]);
      bool testToRemovePatternsFromArray (CandlestickPattern *& array[]);
      bool deleteCandlePatternAtPosition (int position, CandlestickPattern *& array[]);
      bool deleteAllOnDeconstructor ();
      
   public:
      ~CandlestickPatternScanner();
      CandlestickPatternScanner (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int anArraySize, bool aIs5DigitBroker);
      void adjust_Settings_Chart_Subwindow (long chart_id, int sub_window);
      void adjust_Settings_Graphic_BearishReversals (color aColorBear, ENUM_LINE_STYLE aStyleBear, int aWidthBear);
      void adjust_Settings_Graphic_BullishReversals (color aColorBull, ENUM_LINE_STYLE aStyleBull, int awWidthBull);
      void adjust_Settings_Engulfings (double aMinFractionShortToLong, int aMinShortEngBarLengthInPips);
      void adjust_Settings_Stars (double aMinPercOCofHL, int aMinHiLoLength, double aToleranceAreaPercForOC);
      CandlestickPattern * getPossible_Consolidation_atPosition_v2 (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar);
      CandlestickPattern * getPossible_Consolidation_atPosition (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar);
      CandlestickPattern * getPossible_Engulfing_atPosition (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar, double minFractionShortVsLong, double minShortBarLengthInPoints);
      CandlestickPattern * getPossible_Star_atPosition (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar, double minPercOCofHL, double minHiLoLengthInPoints);
      CandlestickPattern * extract_candlestick_pattern (CandlestickPattern *& anArray[], int bar);
      CandlestickPattern * updateAndReturn_Cps_onNewBar ();
      void update_Cps_onNewBar();
      void setDoDrawCandlePatternRect (bool toDraw);
      bool isThisPatternBearishReversal (CandlestickPattern * pattern);
      bool isThisPatternBullishReversal (CandlestickPattern * pattern);
      void displayCandlePatternsArray (CandlestickPattern *& array[]);
};




// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
// ---------------------------------------------------------------       ALGORITHM FUNCTIONS      ---------------------------------------------------------------------------------- //
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
static datetime lastTimeCps = 0;
void CandlestickPatternScanner :: update_Cps_onNewBar (){
   datetime lastBarTime = (datetime) SeriesInfoInteger (this.cpsSymbol, this.cpsTimeframe, SERIES_LASTBAR_DATE);  //--- current time
   if(lastTimeCps == 0){
      lastTimeCps = lastBarTime;
      this.extract_candlestick_pattern (cpArray, 1);
   }
   if(lastTimeCps != lastBarTime){
      lastTimeCps  = lastBarTime;
      testToRemovePatternsFromArray(cpArray);
      this.extract_candlestick_pattern (cpArray, 1);
   }
}

CandlestickPattern * CandlestickPatternScanner :: updateAndReturn_Cps_onNewBar (){
   datetime lastBarTime = (datetime) SeriesInfoInteger (this.cpsSymbol, this.cpsTimeframe, SERIES_LASTBAR_DATE);  //--- current time
   if(lastTimeCps == 0){
      lastTimeCps = lastBarTime;
      return this.extract_candlestick_pattern (cpArray, 1);
   }
   if(lastTimeCps != lastBarTime){
      lastTimeCps  = lastBarTime;
      testToRemovePatternsFromArray(cpArray);
      return this.extract_candlestick_pattern (cpArray, 1);
   }
   return NULL;
}


CandlestickPattern * CandlestickPatternScanner :: extract_candlestick_pattern (CandlestickPattern *& anArray[], int bar){
   CandlestickPattern * consolidation=NULL, * engulf, * star;
   consolidation = getPossible_Consolidation_atPosition (this.cpsSymbol, this.cpsTimeframe, 1);
   engulf = getPossible_Engulfing_atPosition (this.cpsSymbol, this.cpsTimeframe, 1, this.cpsEngdMinFractionShortVsLongLength, this.cpsEngMinShortEngulfBarLength);
   star = getPossible_Star_atPosition (this.cpsSymbol, this.cpsTimeframe, 1, this.cpsStarMinPercOCofHL, this.cpsStarMinHiLoLength);
   
   string str = "n/a";
   if(consolidation != NULL){
      newPattern = consolidation;
      engulf = NULL;
      star = NULL;
      str = "CONSOLIDATION";
   }
   if(consolidation == NULL  &&  engulf != NULL){
      newPattern = engulf;
      star = NULL;
      str = "ENGULF";
   }
   else if(consolidation == NULL  &&  engulf == NULL  &&  star != NULL){
      newPattern = star;
      str = "STAR";
   }
   else {
      newPattern = NULL;
      str = "n/a";
   }
   //newPattern = engulf;
   if( newPattern != NULL  &&  this.cpsDoDrawCandleRects == true){
      appendPatternToBeginningOfArray ( newPattern, anArray);
               
      if( hasDetectedBearishReversal (newPattern) == true )
         newPattern.drawRect (this.cpsChartId, this.cpsSubwindowId, this.cpsColorBearish, this.cpsStyleBearish, this.cpsThicknessBearish, false, false);
      else if( hasDetectedBullishReversal (newPattern) == true )
         newPattern.drawRect (this.cpsChartId, this.cpsSubwindowId, this.cpsColorBullish, this.cpsStyleBullish, this.cpsThicknessBullish, false, false);
   }
   return newPattern;
}


bool CandlestickPatternScanner :: appendPatternToBeginningOfArray (CandlestickPattern * aPattern, CandlestickPattern *& array[]){
   int currentArraySize = ArraySize(array);
   if (currentArraySize < this.cpsMaxArraySize){
      int newArraySize  = ArrayResize(array, (currentArraySize +1));
      if(newArraySize == currentArraySize)
         return false;
   }
   else if (currentArraySize == this.cpsMaxArraySize){
      delete array[currentArraySize-1];
      array[currentArraySize-1] = NULL;
   }
   for(int i= ArraySize(array)-1; i>=1; i--)
      array[i]= array[i-1];
   array[0]= aPattern;
   //displayCandlePatternsArray (array);
   return true;
}


bool CandlestickPatternScanner :: testToRemovePatternsFromArray (CandlestickPattern *& array[]){
   int currentArraySize = ArraySize(array);
   if (currentArraySize <= 0)
      return false;   
   for (int i= 0; i < ArraySize(array); i++){
      if(array[i] != NULL){
         if (array[i].getPatternType() == BULLISH_MORNING_STAR ||
             array[i].getPatternType() == BULLISH_ENGULFING ||
             array[i].getPatternType() == BULLISH_CONSOLIDATION_FINISHER ){
               if( array[i].getBorderPrice() > Bid  || 
                   array[i].getBorderPrice() > iLow(this.cpsSymbol, this.cpsTimeframe, 1))
                     deleteCandlePatternAtPosition (i, array);
         }
         else if (array[i].getPatternType() == BEARISH_EVENING_STAR ||
                  array[i].getPatternType() == BEARISH_ENGULFING ||
                  array[i].getPatternType() == BEARISH_CONSOLIDATION_FINISHER ){
               if( array[i].getBorderPrice() < Bid  || 
                   array[i].getBorderPrice() < iHigh(this.cpsSymbol, this.cpsTimeframe, 1))
                     deleteCandlePatternAtPosition (i, array);
         }
      }
   }
   return true;
}

bool CandlestickPatternScanner :: deleteCandlePatternAtPosition (int position, CandlestickPattern *& array[]){
   int currentArraySize = ArraySize(array);
   if (0 <= position  &&  position < ArraySize(array) ){
      delete array[position];
      array[position] = NULL;      
      for (int i= position; i < ArraySize(array)-1; i++)
         array[i] = array[i+1];
   }
   int newArraySize = ArrayResize(array, (currentArraySize-1));
   if(newArraySize < currentArraySize){
      //displayCandlePatternsArray (array);
      return true;
   }
   return false;
}

bool CandlestickPatternScanner :: deleteAllOnDeconstructor (){
   for (int i= 0; i < ArraySize(cpArray); i++){
      delete cpArray[i];
      cpArray[i] = NULL;
   }
   delete newPattern;
   return true;
}


void CandlestickPatternScanner :: displayCandlePatternsArray (CandlestickPattern *& array[]){
   string textNames;
   for (int i=0; i < ArraySize(array); i++)
      textNames = StringConcatenate (textNames, "    ", "[", i, "]=", array[i].getPatternType(), "_", array[i].getOpeningPattPrice());
   Print("  ZoneCreator :: displayZoneNames() ---- Array[", ArraySize(array), "]   :  ", textNames);
}



bool CandlestickPatternScanner :: hasDetectedBearishReversal (CandlestickPattern * pattern){
   ENUM_CANDLE_PATTERN patternType;
   if(pattern != NULL){
      patternType = pattern.getPatternType();
      if (patternType == BEARISH_CONSOLIDATION_FINISHER  ||
          patternType == BEARISH_ENGULFING  ||
          patternType == BEARISH_EVENING_STAR)
            return true;
   }
   return false;
}

bool CandlestickPatternScanner :: hasDetectedBullishReversal (CandlestickPattern * pattern){
   ENUM_CANDLE_PATTERN patternType;
   if(pattern != NULL){
      patternType = pattern.getPatternType();
      if( patternType == BULLISH_CONSOLIDATION_FINISHER  ||
          patternType == BULLISH_ENGULFING  ||
          patternType == BULLISH_MORNING_STAR)
            return true;
   }
   return false;
}

bool CandlestickPatternScanner :: isThisPatternBearishReversal (CandlestickPattern * pattern){
   return hasDetectedBearishReversal (pattern);
}

bool CandlestickPatternScanner :: isThisPatternBullishReversal (CandlestickPattern * pattern){
   return hasDetectedBullishReversal (pattern);
}

void CandlestickPatternScanner :: checkTo_Delete_CandlestickPattern(string aSymbol, ENUM_TIMEFRAMES aTimeframe){
   for(int i=0; i < ObjectsTotal(); i++){
      string currentObjectName = ObjectName(i);
      if( StringFind(currentObjectName, aSymbol, 0) >= 0  &&
          StringFind(currentObjectName, StringConcatenate(aTimeframe), 0) >= 0){
            
      }      
   }
}

bool CandlestickPatternScanner :: find_CandlestickPattern_Object_byName (string aSymbol, ENUM_TIMEFRAMES aTimeframe){
   for(int i=0; i < ObjectsTotal(); i++){
      string currentObjectName = ObjectName(i);
      if( StringFind(currentObjectName, aSymbol, 0) >= 0  &&
          StringFind(currentObjectName, StringConcatenate(aTimeframe), 0) >= 0)
            return true;
   }
   return false;
}

string CandlestickPatternScanner :: generateNameForCp (string aSymbol, ENUM_TIMEFRAMES aTimeframe){
   return StringConcatenate( "CP_", aSymbol, "_", aTimeframe, "__", MathRand() );
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CandlestickPatternScanner :: ~CandlestickPatternScanner (){ this.deleteAllOnDeconstructor(); }
CandlestickPatternScanner :: CandlestickPatternScanner () {}
CandlestickPatternScanner :: CandlestickPatternScanner (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int anArraySize, bool aIs5DigitBroker){
   setupCandlestickPatternScanner (aSymbol, aTimeframe, anArraySize, aIs5DigitBroker);
}

void CandlestickPatternScanner :: setupCandlestickPatternScanner (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int anArraySize, bool aIs5DigitBroker){
   this.cpsSymbol = aSymbol;
   this.cpsTimeframe = aTimeframe;
   this.cpsIs5DigitBroker = aIs5DigitBroker;
   this.cpsMaxArraySize = anArraySize;
   this.cpsDoDrawCandleRects = true;
   this.cpsPointModeSize = MarketInfo (this.cpsSymbol, MODE_POINT);
   ArrayResize (this.cpArray, 0);
   adjust_Settings_Graphic_BearishReversals (clrHotPink, STYLE_SOLID, 1);
   adjust_Settings_Graphic_BullishReversals (clrSpringGreen, STYLE_SOLID, 1);
   adjust_Settings_Chart_Subwindow (0, 0);
   adjust_Settings_Engulfings (0.75, 10);
   adjust_Settings_Stars (0.25, 10, 0.3);
}

void CandlestickPatternScanner :: adjust_Settings_Chart_Subwindow (long chart_id, int sub_window){
   this.cpsChartId = chart_id;
   this.cpsSubwindowId = sub_window;
}

void CandlestickPatternScanner :: adjust_Settings_Graphic_BearishReversals (color aColorBear, ENUM_LINE_STYLE aStyleBear, int aWidthBear){
   this.cpsColorBearish = aColorBear;
   this.cpsStyleBearish = aStyleBear;
   this.cpsThicknessBearish = aWidthBear;
}

void CandlestickPatternScanner :: adjust_Settings_Graphic_BullishReversals (color aColorBull, ENUM_LINE_STYLE aStyleBull, int awWidthBull){
   this.cpsColorBullish = aColorBull;
   this.cpsStyleBullish = aStyleBull;
   this.cpsThicknessBullish = awWidthBull;
}

void CandlestickPatternScanner :: adjust_Settings_Stars (double aMinPercOCofHL, int aMinHiLoLengthInPips, double aToleranceAreaPercForOC){
   if(aMinPercOCofHL <= 0.04)      aMinPercOCofHL= 0.04;
   if(aMinPercOCofHL >= 0.40)      aMinPercOCofHL= 0.40;
   if(aMinHiLoLengthInPips <= 5)   aMinHiLoLengthInPips= 5;
   if(aToleranceAreaPercForOC <= 0.10)      aToleranceAreaPercForOC= 0.10;
   if(aToleranceAreaPercForOC >= 0.40)      aToleranceAreaPercForOC= 0.40;
    
   this.cpsStarMinPercOCofHL = aMinPercOCofHL;
   this.cpsStarToleranceAreaPercForOC = aToleranceAreaPercForOC;
   if(this.cpsIs5DigitBroker == true)
         this.cpsStarMinHiLoLength = this.cpsPointModeSize * aMinHiLoLengthInPips *10;
   else  this.cpsStarMinHiLoLength = this.cpsPointModeSize * aMinHiLoLengthInPips;
}


void CandlestickPatternScanner :: adjust_Settings_Engulfings (double aMinFractionShortToLong, int aMinShortEngBarLengthInPips){
   if(aMinFractionShortToLong <= 0.15)      aMinFractionShortToLong= 0.15;
   if(aMinFractionShortToLong >= 0.90)      aMinFractionShortToLong= 0.90;
   if(aMinShortEngBarLengthInPips <= 5)      aMinShortEngBarLengthInPips= 5;
   
   this.cpsEngdMinFractionShortVsLongLength = aMinFractionShortToLong;
   if(this.cpsIs5DigitBroker == true)
        this.cpsEngMinShortEngulfBarLength = this.cpsPointModeSize * aMinShortEngBarLengthInPips *10;
   else this.cpsEngMinShortEngulfBarLength = this.cpsPointModeSize * aMinShortEngBarLengthInPips;
}


void CandlestickPatternScanner :: setDoDrawCandlePatternRect (bool toDraw){
   this.cpsDoDrawCandleRects = toDraw;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+


CandlestickPattern * CandlestickPatternScanner :: getPossible_Star_atPosition (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar, double minPercOCofHL, double minHiLoLengthInPoints){
   if(bar >=1){
      CandlestickPattern * candlePattern = NULL;
      double priceO= iOpen(aSymbol, aTimeframe, bar),  priceC= iClose(aSymbol, aTimeframe, bar);
      double priceH= iHigh(aSymbol, aTimeframe, bar),  priceL= iLow(aSymbol, aTimeframe, bar);
      double lengthStarBarOC = MathAbs (priceO - priceC);
      double lengthStarBarHL = MathAbs (priceH - priceL);
      datetime startTime  = iTime (aSymbol, aTimeframe, bar);
      
      if( lengthStarBarHL >= minHiLoLengthInPoints){      // bar1 is longer than bar2
         double percOCofHL = lengthStarBarOC /lengthStarBarHL;
         double priceMiddleOC = MathMin(priceO, priceC) + (MathMax(priceO, priceC) - MathMin(priceO, priceC))/2;
         double positionAlongHL = (priceMiddleOC-priceL) / (priceH-priceL);
         if( percOCofHL <= minPercOCofHL){
            if( positionAlongHL <= this.cpsStarToleranceAreaPercForOC ){            // BEARISH
               if( priceH > iHigh(aSymbol, aTimeframe, bar+1)  &&  priceH > iHigh(aSymbol, aTimeframe, bar+2)  &&  priceH > iHigh(aSymbol, aTimeframe, bar+3) ){
                  candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BEARISH_EVENING_STAR, startTime);
                  candlePattern.setPriceAndDatetimes (startTime, startTime, priceL, priceH );
                  candlePattern.setOpeningClosingPrices ( priceH, priceC );
                  candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
               }
            }
            else if( positionAlongHL >= (1-this.cpsStarToleranceAreaPercForOC) ){   // BULLISH
               if( priceL < iLow(aSymbol, aTimeframe, bar+1)  &&  priceL < iLow(aSymbol, aTimeframe, bar+2)  &&  priceL < iLow(aSymbol, aTimeframe, bar+3) ){
                  candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BULLISH_MORNING_STAR, startTime);
                  candlePattern.setPriceAndDatetimes (startTime, startTime, priceH, priceL );
                  candlePattern.setOpeningClosingPrices ( priceL, priceC );
                  candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
               }
            }
         }
         return candlePattern;
      }
   }
   return NULL;
}


CandlestickPattern * CandlestickPatternScanner :: getPossible_Engulfing_atPosition (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar, double minFractionShortVsLong, double minShortBarLengthInPoints){
   if(bar >=1){
      CandlestickPattern * candlePattern = NULL;
      double lengthLongBar  = MathAbs (iClose(aSymbol, aTimeframe, bar)   -iOpen(aSymbol, aTimeframe, bar));
      double lengthShortBar = MathAbs (iClose(aSymbol, aTimeframe, bar+1) -iOpen(aSymbol, aTimeframe, bar+1));
      double colorLongBar  = iClose(aSymbol, aTimeframe, bar)   -iOpen(aSymbol, aTimeframe, bar);
      double colorShortBar = iClose(aSymbol, aTimeframe, bar+1) -iOpen(aSymbol, aTimeframe, bar+1);
      
      if( lengthShortBar <= lengthLongBar * minFractionShortVsLong  &&
          lengthShortBar >= minShortBarLengthInPoints){         // bar1 is longer than bar2
          if( colorShortBar > 0  &&  colorLongBar < 0){         // bar1 Green, bar2 Red - Bearish Engulfing
             datetime startTime = iTime (aSymbol, aTimeframe, bar+1);
             datetime endTime   = iTime (aSymbol, aTimeframe, bar);
             if( true ){
               candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BEARISH_ENGULFING, startTime);
               double priceCont = iClose (aSymbol, aTimeframe, bar);
               double priceBord = MathMax ( iHigh(aSymbol, aTimeframe, bar+1), iHigh(aSymbol, aTimeframe, bar)) ;
               candlePattern.setPriceAndDatetimes (startTime, endTime, priceCont, priceBord );
               candlePattern.setOpeningClosingPrices ( iOpen(aSymbol, aTimeframe, bar), iClose(aSymbol, aTimeframe, bar) );
               candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
             }
         }
         else if( colorShortBar < 0  &&  colorLongBar > 0){       // bar1 Red, bar2 Green - Bullish Engulfing
             datetime startTime = iTime (aSymbol, aTimeframe, bar+1);
             datetime endTime   = iTime (aSymbol, aTimeframe, bar);
             if( true ){
               candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BULLISH_ENGULFING, startTime);
               double priceCont = iClose (aSymbol, aTimeframe, bar);
               double priceBord = MathMin ( iLow(aSymbol, aTimeframe, bar+1), iLow(aSymbol, aTimeframe, bar)) ;
               candlePattern.setPriceAndDatetimes (startTime, endTime, priceCont, priceBord );
               candlePattern.setOpeningClosingPrices ( iOpen(aSymbol, aTimeframe, bar), iClose(aSymbol, aTimeframe, bar) );
               candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
             }
         }
         return candlePattern;
      }
   }
   return NULL;
}


CandlestickPattern * CandlestickPatternScanner :: getPossible_Consolidation_atPosition (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar){
   if(bar >=1){
      CandlestickPattern * candlePattern = NULL;
      bool formationIsOnPeak= false, formationIsOnDip= false;
      double priceFinisherC = iClose(aSymbol, aTimeframe, bar);
      
      double tolerancePercConsoRange = 0.20;
      double finisherPercConsoRange = 0.75;
      int minBarCountInConsoRange = 1;
      double percOfBarsNeededToSatisfyConsoConditions = 0.5;
      
      for (int i= bar+3; i<bar+8; i++){
         double boundryO = iOpen (aSymbol, aTimeframe, i);
         double boundryC = iClose (aSymbol, aTimeframe, i);
         double differenceBcBo = boundryC -boundryO;
         double borderExtSupp = MathMax(boundryO, boundryC) + tolerancePercConsoRange * MathAbs(differenceBcBo);
         double borderExtInf  = MathMin(boundryO, boundryC) - tolerancePercConsoRange * MathAbs(differenceBcBo);
         double borderBreakage;
         
         int j= i-1, countBarInRange= 0;
         int countBarInUpperFirstRange= 0, countBarInLowerFirstRange= 0, countBarsSimilarInLengthToFirst= 0;
         double differenceOC2ndBar       = MathAbs(iOpen(aSymbol, aTimeframe, j) - iClose(aSymbol, aTimeframe, j));
         double midPriceFirstBar         = MathMin(boundryC, boundryO) + MathAbs(differenceBcBo)* 0.5;
         double aboveUpperPriceFirstBar  = MathMax(boundryC, boundryO) - MathAbs(differenceBcBo)* 0.5;
         double bellowLowerPriceFirstBar = MathMin(boundryC, boundryO) + MathAbs(differenceBcBo)* 0.5;
         
         while (j > bar){
            double currentClose = iClose(aSymbol, aTimeframe, j);
            double currentOpen  = iOpen(aSymbol, aTimeframe, j);
            double differenceCurr = currentClose - currentOpen;
            double differenceOCcurrBar = MathAbs( differenceCurr);
                        
            if( borderExtSupp >= currentClose  &&  currentClose >= borderExtInf  &&
                borderExtSupp >= currentOpen   &&  currentOpen  >= borderExtInf){
                  countBarInRange ++;
                  // in Upper part of first candle
                  if( iClose(aSymbol, aTimeframe, j) > aboveUpperPriceFirstBar   &&  iOpen(aSymbol, aTimeframe, j) > aboveUpperPriceFirstBar )
                     if(differenceOCcurrBar <= MathAbs(differenceBcBo) *0.3)
                        countBarInUpperFirstRange++;
                  // in Lower part of first candle
                  if( iClose(aSymbol, aTimeframe, j) < bellowLowerPriceFirstBar  &&  iOpen(aSymbol, aTimeframe, j) < bellowLowerPriceFirstBar )
                     if(differenceOCcurrBar <= MathAbs(differenceBcBo) *0.3)
                        countBarInLowerFirstRange++;
                  // bars are of similar lengths
                  if( differenceOC2ndBar*0.8 <= differenceOCcurrBar  &&  differenceOCcurrBar <= differenceOC2ndBar*1.2 )
                     countBarsSimilarInLengthToFirst++;
            }else break;
            j--;
         }
         
         if( countBarInRange == i-bar-1 ){
            datetime startTime = iTime(aSymbol, aTimeframe, i);
            datetime endTime   = iTime(aSymbol, aTimeframe, bar);
            borderBreakage = borderExtInf - MathAbs(differenceBcBo) *0.2;
            
            if( iClose(aSymbol, aTimeframe, bar) < borderBreakage ){   // BEARISH_CONSOLIDATION
               if(countBarInUpperFirstRange >= countBarInRange *percOfBarsNeededToSatisfyConsoConditions  ||
                  countBarsSimilarInLengthToFirst >= countBarInRange *percOfBarsNeededToSatisfyConsoConditions){
                     candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BEARISH_CONSOLIDATION_FINISHER, startTime);
                     candlePattern.setPriceAndDatetimes (startTime, endTime, borderExtInf, borderExtSupp );
                     candlePattern.setOpeningClosingPrices ( MathMin(boundryO, boundryC), priceFinisherC);
                     candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
                     return candlePattern;
               }
            }
            borderBreakage = borderExtSupp + MathAbs(differenceBcBo) *0.2;
            if( iClose(aSymbol, aTimeframe, bar) > borderBreakage ){  // BULLISH_CONSOLIDATION
               if(countBarInLowerFirstRange >= countBarInRange *percOfBarsNeededToSatisfyConsoConditions  ||
                  countBarsSimilarInLengthToFirst >= countBarInRange *percOfBarsNeededToSatisfyConsoConditions){
                     candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BULLISH_CONSOLIDATION_FINISHER, startTime);
                     candlePattern.setPriceAndDatetimes (startTime, endTime, borderExtSupp, borderExtInf );
                     candlePattern.setOpeningClosingPrices ( MathMin(boundryO, boundryC), priceFinisherC);
                     candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
                     return candlePattern;
               }
            }
         }
      }
   }
   return NULL;
}


CandlestickPattern * CandlestickPatternScanner :: getPossible_Consolidation_atPosition_v2 (string aSymbol, ENUM_TIMEFRAMES aTimeframe, int bar){
   if(bar >=1){
      CandlestickPattern * candlePattern = NULL;
      bool formationIsOnPeak= false, formationIsOnDip= false;
      double priceFinisherC = iClose(aSymbol, aTimeframe, bar);
      
      double tolerancePercConsoRange = 0.20;
      double finisherPercConsoRange = 0.75;
      int minBarCountInConsoRange = 1;
      double percOfBarsNeededToSatisfyConsoConditions = 0.5;
      
      for (int i= bar+6; i>=bar+3; i--){
         double boundryO1 = iOpen (aSymbol, aTimeframe, i);
         double boundryC1 = iClose(aSymbol, aTimeframe, i);
         double boundryO2 = iOpen (aSymbol, aTimeframe, i-1);
         double boundryC2 = iClose(aSymbol, aTimeframe, i-1);
         double boundryO3 = iOpen (aSymbol, aTimeframe, i-2);
         double boundryC3 = iClose(aSymbol, aTimeframe, i-2);
         double differenceBcBo1 = MathAbs(boundryC1 -boundryO1);
         double differenceBcBo2 = MathAbs(boundryC2 -boundryO2);
         double differenceBcBo3 = MathAbs(boundryC3 -boundryO3);
         double borderExtSupp = MathMax(boundryO1, boundryC1) + tolerancePercConsoRange * MathAbs(differenceBcBo1);
         double borderExtInf  = MathMin(boundryO1, boundryC1) - tolerancePercConsoRange * MathAbs(differenceBcBo1);
         double borderBreakage;
         
         int next= i-1, countBarInRange= 0;
         double marginCont= 0, marginBord= 0;
         
         if(boundryO1 > boundryC1){    // candidate for BULLISH
            if(boundryC2 > boundryO2){
               if( differenceBcBo2/differenceBcBo1 <= 0.25 ){
                  if( boundryC3 > boundryO3  &&  differenceBcBo3/differenceBcBo1 <= 0.25 )
                     marginCont = boundryC3 + differenceBcBo3 * 0.25;
                  else marginCont = boundryC2 + differenceBcBo2 + differenceBcBo2 * 0.25;      
               }
               else marginCont = boundryC2 + differenceBcBo2 * 0.25;
               marginBord = MathMin(boundryC1, boundryO2) - differenceBcBo2 *0.15;
               formationIsOnPeak= false;  formationIsOnDip= true;
            }
            else if(boundryO2 > boundryC2  &&  differenceBcBo2/differenceBcBo1 <= 0.1  &&
                    boundryC3 > boundryO3 ){
                    if(differenceBcBo2/differenceBcBo1 <= 0.25)
                       marginCont = boundryC3 + differenceBcBo3 * 0.25 * 1.75;
                    else if(0.60 >= differenceBcBo2/differenceBcBo1  &&  differenceBcBo2/differenceBcBo1 >= 0.25)
                       marginCont = boundryC3 + differenceBcBo3 * 0.25;
                  marginBord = MathMin(boundryC2, boundryO3) - differenceBcBo2 *0.15;
                  formationIsOnPeak= false;  formationIsOnDip= true;
            }
         }
         if(boundryC1 > boundryO1){    // candidate for BEARISH
            if(boundryO2 > boundryC2){
               if( differenceBcBo2/differenceBcBo1 <= 0.25 ){
                  if( boundryO3 > boundryC3  &&  differenceBcBo3/differenceBcBo1 <= 0.25 )
                     marginCont = boundryC3 - differenceBcBo3 * 0.25;
                  else marginCont = boundryC2 - differenceBcBo2 - differenceBcBo2 * 0.25;      
               }
               else marginCont = boundryC2 - differenceBcBo2 * 0.25;
               marginBord = MathMax(boundryC1, boundryO2) + differenceBcBo2 *0.15;
               formationIsOnPeak= true;  formationIsOnDip= false;
            }
            else if(boundryC2 > boundryO2  &&  differenceBcBo2/differenceBcBo1 <= 0.1  &&
                    boundryO3 > boundryC3 ){
                    if(differenceBcBo2/differenceBcBo1 <= 0.25)
                       marginCont = boundryC3 - differenceBcBo3 * 0.25 * 1.75;
                    else if(0.60 >= differenceBcBo2/differenceBcBo1  &&  differenceBcBo2/differenceBcBo1 >= 0.25)
                       marginCont = boundryC3 - differenceBcBo3 * 0.25;
                  marginBord = MathMax(boundryC2, boundryO3) + differenceBcBo2 *0.15;
                  formationIsOnPeak= true;  formationIsOnDip= false;
            }
         }
         double marginAbove= MathMax(marginBord, marginCont),  marginBelow= MathMin(marginBord, marginCont);
         if(formationIsOnPeak){
            marginAbove = marginBord;
            marginBelow = marginCont;
         }else if(formationIsOnDip){
            marginAbove = marginCont;
            marginBelow = marginBord;
         }         
         if(marginAbove >0 && marginBord>0){
            int j= i-2;
            while (j > bar){
               double currentClose = iClose(aSymbol, aTimeframe, j);
               double currentOpen  = iOpen(aSymbol, aTimeframe, j);
               double differenceCurr = currentClose - currentOpen;
               double differenceOCcurrBar = MathAbs(differenceCurr);
               
               if( marginAbove >= currentClose  &&  currentClose >= marginBelow  &&
                   marginAbove >= currentOpen   &&  currentOpen  >= marginBelow){
                     countBarInRange ++;
               }else break;
               j--;
            }            
            int nbrBarsBetweenConsoBounds = i-bar-1;
            switch(nbrBarsBetweenConsoBounds){
               case 1: nbrBarsBetweenConsoBounds=1; break;
               case 2: nbrBarsBetweenConsoBounds=2; break;
               case 3: nbrBarsBetweenConsoBounds=2; break;
               case 4: nbrBarsBetweenConsoBounds=3; break;
               case 5: nbrBarsBetweenConsoBounds=3; break;
               case 6: nbrBarsBetweenConsoBounds=4; break;
               default: nbrBarsBetweenConsoBounds=4; break;
            }
                        
            if( countBarInRange >= nbrBarsBetweenConsoBounds ){
               datetime startTime = iTime(aSymbol, aTimeframe, i);
               datetime endTime   = iTime(aSymbol, aTimeframe, bar);
   
               if(formationIsOnPeak == true){      // BEARISH
                  borderBreakage = marginBelow - MathAbs(boundryC2 -boundryO2) * 0.75;
                  if( iClose(aSymbol, aTimeframe, bar) < borderBreakage){   // BEARISH_CONSOLIDATION
                     candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BEARISH_CONSOLIDATION_FINISHER, startTime);
                     candlePattern.setPriceAndDatetimes (startTime, endTime, borderExtInf, borderExtSupp );
                     candlePattern.setOpeningClosingPrices ( MathMin(boundryO1, boundryC1), priceFinisherC);
                     candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
                     return candlePattern;
                  }
               }
               else if(formationIsOnDip == true){  // BULLISH
                  borderBreakage = marginAbove + MathAbs(boundryC2 -boundryO2) * 0.75;
                  if( iClose(aSymbol, aTimeframe, bar) > borderBreakage ){  // BULLISH_CONSOLIDATION
                     candlePattern = new CandlestickPattern (aSymbol, aTimeframe, BULLISH_CONSOLIDATION_FINISHER, startTime);
                     candlePattern.setPriceAndDatetimes (startTime, endTime, borderExtSupp, borderExtInf );
                     candlePattern.setOpeningClosingPrices ( MathMin(boundryO1, boundryC1), priceFinisherC);
                     candlePattern.setCpName ( generateNameForCp (aSymbol, aTimeframe));
                     return candlePattern;
                  }
               }
            }
         }
      }
   }
   return NULL;
}