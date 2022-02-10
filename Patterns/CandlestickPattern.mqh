//+------------------------------------------------------------------+
//|                                           CandlestickPattern.mqh |
//|                                               Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "SimonG"
#property link      "https://www.mql5.com"
#property strict
#include <__SimonG\MS\CandlestickPatternScanner\Helpers\GeneralDrawer.mqh>

enum ENUM_CANDLE_PATTERN {
   BULLISH_CONSOLIDATION_FINISHER = 657, BULLISH_ENGULFING = 658, BULLISH_MORNING_STAR = 659,
   BEARISH_CONSOLIDATION_FINISHER = 663, BEARISH_ENGULFING = 662, BEARISH_EVENING_STAR = 661,
   NONE = 660};


class CandlestickPattern {
   private:
      string cpSymbol;
      ENUM_TIMEFRAMES cpTimeframe;
      ENUM_CANDLE_PATTERN cpType;
      string cpObjName;
      datetime cpStartDate;
      datetime cpEndDate;
      double cpContPrice;
      double cpBorderPrice;
      double cpOpeningPattPrice;
      double cpClosingPattPrice;
      double cpGrade;
      string cpRectName;
      
      void setupCandlestickPattern (string aSymbol, ENUM_TIMEFRAMES aTimeframe, ENUM_CANDLE_PATTERN aCandlePattern, datetime aTimestart);
      bool vizualizeRectForPattern (long chart_id, int sub_window, string rectName, color clr, ENUM_LINE_STYLE style, int width, bool fill, bool back);
      double computeConsolidationGrade();
      double computeEngulfingGrade();
      double computeStarGrade();
   
   protected:
      CandlestickPattern();
      
   public:
      ~CandlestickPattern ();
      CandlestickPattern (string aSymbol, ENUM_TIMEFRAMES aTimeframe, ENUM_CANDLE_PATTERN aCandlePattern, datetime timeStart, datetime timeEnd, double priceCont, double priceBorder, double openPattPrice, double closePattPrice);
      CandlestickPattern (string aSymbol, ENUM_TIMEFRAMES aTimeframe, ENUM_CANDLE_PATTERN aCandlePattern, datetime aTimestart);
      void setPriceAndDatetimes (datetime timeStart, datetime timeEnd, double priceCont, double priceBorder);
      void setOpeningClosingPrices (double openingPrice, double closingPrice);
      void setCpName (string aName);
      string getCpName ();
      string getCpSymbol ();
      ENUM_TIMEFRAMES getCpTimeframe ();
      datetime getStartDate ();
      datetime getEndDate ();
      double getContPrice ();
      double getBorderPrice ();
      double getOpeningPattPrice ();
      double getClosingPattPrice ();
      double gradePattern();
      ENUM_CANDLE_PATTERN getPatternType ();
      bool drawRect (long chart_id, int sub_window, color clr, ENUM_LINE_STYLE style, int width, bool fill, bool back);
      bool unDrawRect ();
};

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
// ----------------------------------------------------------------       GRADING FUNCTIONS      ----------------------------------------------------------------------------------- //
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
double CandlestickPattern :: gradePattern(){
   if (this.cpType == BEARISH_CONSOLIDATION_FINISHER  ||  
       this.cpType == BULLISH_CONSOLIDATION_FINISHER)
               return computeConsolidationGrade();
   else if (this.cpType == BEARISH_ENGULFING  ||  
            this.cpType == BULLISH_ENGULFING)
               return computeEngulfingGrade();
   else if (this.cpType == BEARISH_EVENING_STAR  ||  
            this.cpType == BULLISH_MORNING_STAR)
               return computeStarGrade();
   else return 0.0;
}

double CandlestickPattern :: computeConsolidationGrade(){
   int startingBar = iBarShift( this.cpSymbol, this.cpTimeframe, this.cpStartDate);
   int finisherBar = iBarShift( this.cpSymbol, this.cpTimeframe, this.cpEndDate);
   
   for (int i= startingBar+1; i < finisherBar; i++){
      //if(
   }
   return 0;
}

double CandlestickPattern :: computeEngulfingGrade(){
   return 0;
}

double CandlestickPattern :: computeStarGrade(){
   return 0;
}

// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
// ----------------------------------------------------------------       DRAWING FUNCTIONS      ----------------------------------------------------------------------------------- //
// --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- //
bool CandlestickPattern :: unDrawRect (){
   return ObjectDelete (this.cpRectName);
}

bool CandlestickPattern :: drawRect (long chart_id, int sub_window, color clr, ENUM_LINE_STYLE style, int width, bool fill, bool back){
   return vizualizeRectForPattern (chart_id, sub_window, this.cpRectName, clr, style, width, fill, back);
}

bool CandlestickPattern :: vizualizeRectForPattern (long chart_id, int sub_window, string rectName, color clr, ENUM_LINE_STYLE style, int width, bool fill, bool back){
   datetime time1, time2;
   double price1, price2;
   time1= this.cpStartDate - this.cpTimeframe * 60;
   time2= this.cpEndDate + this.cpTimeframe * 60;
   price1= this.cpContPrice;
   price2= this.cpBorderPrice;
   //Print( " vizRect() ----   timeSt = ", time1, "   timeEn = ", time2, "   priceCont = ", price1, "   priceBorder = ", price2 );
   if( this.cpType == BEARISH_ENGULFING  ||  this.cpType == BEARISH_EVENING_STAR  ||  this.cpType == BEARISH_CONSOLIDATION_FINISHER){
      price1 -= 50* MarketInfo(this.cpSymbol, MODE_POINT);
      price2 += 50* MarketInfo(this.cpSymbol, MODE_POINT);
      createRectangle ( chart_id, sub_window, rectName, time1, price1, time2, price2, clr, style, width, fill, back, false, false, 0);
      return true;
   }
   else if( this.cpType == BULLISH_ENGULFING  ||  this.cpType == BULLISH_MORNING_STAR  ||  this.cpType == BULLISH_CONSOLIDATION_FINISHER){
      price1 += 50* MarketInfo(this.cpSymbol, MODE_POINT);
      price2 -= 50* MarketInfo(this.cpSymbol, MODE_POINT);
      createRectangle ( chart_id, sub_window, rectName, time1, price1, time2, price2, clr, style, width, fill, back, false, false, 0);
      return true;
   }
   return false;
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CandlestickPattern :: ~CandlestickPattern (){ unDrawRect(); }
CandlestickPattern :: CandlestickPattern () {}
CandlestickPattern :: CandlestickPattern (string aSymbol, ENUM_TIMEFRAMES aTimeframe, ENUM_CANDLE_PATTERN aCandlePattern, datetime aTimestart){
   setupCandlestickPattern (aSymbol, aTimeframe, aCandlePattern, aTimestart);
}

CandlestickPattern :: CandlestickPattern (string aSymbol, ENUM_TIMEFRAMES aTimeframe, ENUM_CANDLE_PATTERN aCandlePattern, datetime timeStart, datetime timeEnd, double priceCont, double priceBorder, double openPattPrice, double closePattPrice){
   setupCandlestickPattern (aSymbol, aTimeframe, aCandlePattern, timeStart);
   setPriceAndDatetimes (timeStart, timeEnd, priceCont, priceBorder);
   setOpeningClosingPrices (openPattPrice, closePattPrice);
}

void CandlestickPattern :: setupCandlestickPattern (string aSymbol, ENUM_TIMEFRAMES aTimeframe, ENUM_CANDLE_PATTERN aCandlePattern, datetime aTimestart){
   this.cpSymbol = aSymbol;
   this.cpTimeframe = aTimeframe;
   this.cpType = aCandlePattern;
   this.cpStartDate = aTimestart;
   this.cpRectName = StringConcatenate("Rect_", aSymbol, "_", aTimeframe, "_", aCandlePattern, "_", aTimestart);
}

void CandlestickPattern :: setCpName (string aName){
   this.cpObjName = aName;
}
string CandlestickPattern :: getCpName (){
   return this.cpObjName;
}
string CandlestickPattern :: getCpSymbol (){
   return this.cpSymbol;
}
ENUM_TIMEFRAMES CandlestickPattern :: getCpTimeframe (){
   return this.cpTimeframe;
}
ENUM_CANDLE_PATTERN CandlestickPattern :: getPatternType (){
   return this.cpType;
}
datetime CandlestickPattern :: getStartDate (){
   return this.cpStartDate;
}
datetime CandlestickPattern :: getEndDate (){
   return this.cpEndDate;
}
double CandlestickPattern :: getContPrice (){
   return this.cpContPrice;
}
double CandlestickPattern :: getBorderPrice (){
   return this.cpBorderPrice;
}
double CandlestickPattern :: getOpeningPattPrice (){
   return this.cpOpeningPattPrice;
}
double CandlestickPattern :: getClosingPattPrice (){
   return this.cpClosingPattPrice;
}

void CandlestickPattern :: setPriceAndDatetimes (datetime timeStart, datetime timeEnd, double priceCont, double priceBorder){
   this.cpStartDate = timeStart;
   this.cpEndDate = timeEnd;
   this.cpContPrice = priceCont;
   this.cpBorderPrice = priceBorder;
}

void CandlestickPattern :: setOpeningClosingPrices (double openingPrice, double closingPrice){
   this.cpOpeningPattPrice = openingPrice;
   this.cpClosingPattPrice = closingPrice;
}