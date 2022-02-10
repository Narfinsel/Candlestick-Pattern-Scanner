//+------------------------------------------------------------------+
//|                                                GeneralHelper.mqh |
//|                                               Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "SimonG"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

enum NUMBER_SIGN { NEGATIVE = 13221, ZERO = 13222, POSITIVE = 13223 };


class GeneralHelper{
   private:
      ~GeneralHelper();
      GeneralHelper();      
   public:
      static string displayDoubleArray(string textHeader, double & array[]);
      static void draw3(datetime timeDate, int lineColor);
      static void draw4(string symbol, ENUM_TIMEFRAMES timeframe, int timeBar, int lineColor);
      static void draw4ForBar (int timeBar, int lineColor, int lineThickness);
      static void draw4ForBar (string symbol, ENUM_TIMEFRAMES timeframe, int timeBar, int lineColor, int lineThickness);
      static void draw4ForBar (string objectName, string symbol, ENUM_TIMEFRAMES timeframe, int timeBar, int lineColor, int lineThickness);
      static void drawHorizontalLine1 (string symbol, ENUM_TIMEFRAMES timeframe, string objectName, double priceLevel, int lineColor);
      static void drawHorizontalLines_Min_Max (string symbol, ENUM_TIMEFRAMES timeframe, double minPriceLevel, double maxPriceLevel, int lineColorMin, int lineColorMax);
      static void drawHorizontalLines_Min_Max_Base (string symbol, ENUM_TIMEFRAMES timeframe, double minPriceLevel, double maxPriceLevel, double basePriceLeve, int lineColorMin, int lineColorMax, int lineColorBase);
      bool arrowSymbolCreate (long chart_ID=0, string name="ArrowUp", datetime time=0, double price=0, ENUM_OBJECT arrowType=OBJ_ARROW_UP, ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, color clr=clrWhite);
      bool arrowSymbolCreate (long chart_ID=0, string name="ArrowUp", int bar=1, double price=0, ENUM_OBJECT arrowType=OBJ_ARROW_UP, ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, color clr=clrWhite);
      bool createVerticalSegment (string nameSegment, int BarX, double P0, double P1, color clr, int thickness);
      bool createHorizontalSegment (string nameSegment, int Bar0, int Bar1, double Px, color clr, int thickness);
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
GeneralHelper :: ~GeneralHelper(){}
GeneralHelper :: GeneralHelper(){}
//+------------------------------------------------------------------+


// ------------------------------------------------------------------------------------------------------ +
// ------------------------------------------- VERTICAL LINE -------------------------------------------- +
void draw3DetailedForTime (datetime timeDate, int lineColor, int lineThickness, ENUM_LINE_STYLE lineStyle){
   string name = TimeToStr(timeDate, TIME_DATE|TIME_MINUTES);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectCreate(name, OBJ_VLINE, 0, timeDate, 0);
   ObjectSet(name, OBJPROP_WIDTH, lineThickness);
   ObjectSet(name, OBJPROP_COLOR, lineColor);
   ObjectSet(name, OBJPROP_BACK, true);
   ObjectSet(name, OBJPROP_STYLE, lineStyle);
}
void draw3DetailedForTimeWithDelete (string objectName, datetime timeDate, int lineColor, int lineThickness, ENUM_LINE_STYLE lineStyle){
   string name = TimeToStr(timeDate, TIME_DATE|TIME_MINUTES);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectDelete(objectName);
   ObjectCreate(objectName, OBJ_VLINE, 0, timeDate, 0);
   ObjectSet(objectName, OBJPROP_WIDTH, lineThickness);
   ObjectSet(objectName, OBJPROP_COLOR, lineColor);
   ObjectSet(objectName, OBJPROP_BACK, true);
   ObjectSet(name, OBJPROP_STYLE, lineStyle);
}

void draw3ForTime (datetime timeDate, int lineColor, int lineThickness){
   string name = TimeToStr(timeDate, TIME_DATE|TIME_MINUTES);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectCreate(name, OBJ_VLINE, 0, timeDate, 0);
   ObjectSet(name, OBJPROP_WIDTH, lineThickness);
   ObjectSet(name, OBJPROP_COLOR, lineColor);
   ObjectSet(name, OBJPROP_BACK, true);
}
void draw3ForTimeWithDelete (string objectName, datetime timeDate, int lineColor, int lineThickness){
   string name = TimeToStr(timeDate, TIME_DATE|TIME_MINUTES);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectDelete(objectName);
   ObjectCreate(objectName, OBJ_VLINE, 0, timeDate, 0);
   ObjectSet(objectName, OBJPROP_WIDTH, lineThickness);
   ObjectSet(objectName, OBJPROP_COLOR, lineColor);
   ObjectSet(objectName, OBJPROP_BACK, true);
}

void draw4ForBar (int timeBar, int lineColor, int lineThickness){
   datetime timestamp = iTime(Symbol(), Period(), timeBar);
   string name = TimeToStr(timestamp, TIME_DATE|TIME_MINUTES);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectCreate(name, OBJ_VLINE, 0, timestamp, 0);
   ObjectSet(name, OBJPROP_WIDTH, lineThickness);
   ObjectSet(name, OBJPROP_COLOR, lineColor);
   ObjectSet(name, OBJPROP_BACK, true);
}
void draw4ForBar (string symbol, ENUM_TIMEFRAMES timeframe, int timeBar, int lineColor, int lineThickness){
   datetime timestamp = iTime(symbol, timeframe, timeBar);
   string name = TimeToStr(timestamp, TIME_DATE|TIME_MINUTES);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectCreate(name, OBJ_VLINE, 0, timestamp, 0);
   ObjectSet(name, OBJPROP_WIDTH, lineThickness);
   ObjectSet(name, OBJPROP_COLOR, lineColor);
   ObjectSet(name, OBJPROP_BACK, true);
}
void draw4ForBarWithDelete (string symbol, ENUM_TIMEFRAMES timeframe, string objectName, int timeBar, int lineColor, int lineThickness){
   datetime timestamp = iTime(symbol, timeframe, timeBar);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectDelete(objectName);
   ObjectCreate(objectName, OBJ_VLINE, 0, timestamp, 0);
   ObjectSet(objectName, OBJPROP_WIDTH, lineThickness);
   ObjectSet(objectName, OBJPROP_COLOR, lineColor);
   ObjectSet(objectName, OBJPROP_BACK, true);
}
void draw4ForBar (string objectName, string symbol, ENUM_TIMEFRAMES timeframe, int timeBar, int lineColor, int lineThickness){
   datetime timestamp = iTime(symbol, timeframe, timeBar);
   ObjectDelete(objectName);
   if(lineThickness < 1)    lineThickness= 1;
   if(lineThickness > 5)    lineThickness= 5;
   ObjectCreate(objectName, OBJ_VLINE, 0, timestamp, 0);
   ObjectSet(objectName, OBJPROP_WIDTH, lineThickness);
   ObjectSet(objectName, OBJPROP_COLOR, lineColor);
   ObjectSet(objectName, OBJPROP_BACK, true);
}

// ------------------------------------------------------------------------------------------------------ +
// ------------------------------------------ HORIZONTAL LINE ------------------------------------------- +

void drawHorizontalLine1(string objectName, double priceLevel, int lineColor){                 // WORKS!!!   
   ObjectDelete(objectName);
   ObjectCreate(objectName, OBJ_HLINE, 0, 0, priceLevel);
   ObjectSet(objectName, OBJPROP_WIDTH, 1);
   ObjectSet(objectName, OBJPROP_COLOR, lineColor);
   ObjectSet(objectName, OBJPROP_BACK, true);
}

void drawHorizontalLines_Min_Max(double minPriceLevel, double maxPriceLevel, int lineColorMin, int lineColorMax){
   drawHorizontalLine1("minLine", minPriceLevel, lineColorMin);
   drawHorizontalLine1("maxLine", maxPriceLevel, lineColorMax);
}

void drawHorizontalLines_Min_Max_Base(double minPriceLevel, double maxPriceLevel, double basePriceLeve, int lineColorMin, int lineColorMax, int lineColorBase){
   drawHorizontalLine1("minLine", minPriceLevel, lineColorMin);
   drawHorizontalLine1("baseLine", basePriceLeve, lineColorBase);
   drawHorizontalLine1("maxLine", maxPriceLevel, lineColorMax);
}

void drawHorizontalLines_Min_Max_WithName(string objectName, double minPriceLevel, double maxPriceLevel, int lineColorMin, int lineColorMax){
   string objectName1 = StringConcatenate(objectName, "1");
   string objectName2 = StringConcatenate(objectName, "2");
   drawHorizontalLine1(objectName1, minPriceLevel, lineColorMin);
   drawHorizontalLine1(objectName2, maxPriceLevel, lineColorMax);
}

void drawHorizontalLines_Min_Max_Base_WithName(string objectName, double minPriceLevel, double maxPriceLevel, double basePriceLeve, int lineColorMin, int lineColorMax, int lineColorBase){
   string objectName1 = StringConcatenate(objectName, "1");
   string objectName2 = StringConcatenate(objectName, "2");
   string objectName3 = StringConcatenate(objectName, "3");
   drawHorizontalLine1(objectName1, minPriceLevel, lineColorMin);
   drawHorizontalLine1(objectName2, basePriceLeve, lineColorBase);
   drawHorizontalLine1(objectName3, maxPriceLevel, lineColorMax);
}


string convertSignToText(int value){
   string stringState;
   switch(value){
      case NEGATIVE:    stringState = "NEGATIVE"; break;
      case ZERO:        stringState = "ZERO"; break;
      case POSITIVE:    stringState = "POSITIVE"; break;
      default:          stringState = "N/A"; break;
   }
   return stringState;
}



// ------------------------------------------------------------------------------------------------------ +
// ------------------------------------------ VERTICAL SEGMENT ------------------------------------------ +
bool createVerticalSegment (string nameSegment, int BarX, double P0, double P1, color clr, int thickness){
   bool ray = false;
   datetime TimeX = iTime(Symbol(), PERIOD_CURRENT, BarX);
   if(ObjectFind(nameSegment) >= 0)
      ObjectDelete(nameSegment);
   if( !ObjectCreate (nameSegment, OBJ_TREND, 0, TimeX, P0, TimeX, P1))
      return(false);
   ObjectSet(nameSegment, OBJPROP_RAY, ray);
   ObjectSet(nameSegment, OBJPROP_WIDTH, thickness);
   ObjectSet(nameSegment, OBJPROP_COLOR, clr);
   return(true); 
}

// ------------------------------------------------------------------------------------------------------ +
// ----------------------------------------- HORIZONTAL SEGMENT ----------------------------------------- +
bool createHorizontalSegment (string nameSegment, int Bar0, int Bar1, double Px, color clr, int thickness){
   bool ray = false;
   datetime T0 = iTime(Symbol(), PERIOD_CURRENT, Bar0);
   datetime T1 = iTime(Symbol(), PERIOD_CURRENT, Bar1);
   if(ObjectFind(nameSegment) >= 0)
      ObjectDelete(nameSegment);
   if( !ObjectCreate(nameSegment, OBJ_TREND, 0, T0, Px, T1, Px)){
      return(false);
   }
   ObjectSet(nameSegment, OBJPROP_RAY, ray);
   ObjectSet(nameSegment, OBJPROP_WIDTH, thickness);
   ObjectSet(nameSegment, OBJPROP_COLOR, clr);
   return(true); 
}


// ------------------------------------------------------------------------------------------------------ +
// --------------------------------------------- ARROW SIGN --------------------------------------------- +
bool arrowSymbolCreate (long          chart_ID=0,           // chart's ID
                    string            name="ArrowUp",       // sign name                    
                    datetime          time=0,               // anchor point time
                    double            price=0,              // anchor point price
                    ENUM_OBJECT       arrowType=OBJ_ARROW_UP, // anchor type
                    ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // anchor type
                    color             clr=clrWhite){
   int sub_window =0;
   if(arrowType==OBJ_ARROW_THUMB_UP || arrowType==OBJ_ARROW_THUMB_DOWN || arrowType==OBJ_ARROW_UP || arrowType==OBJ_ARROW_DOWN || 
      arrowType==OBJ_ARROW_STOP || arrowType==OBJ_ARROW_CHECK || OBJ_ARROW_LEFT_PRICE || arrowType==OBJ_ARROW_RIGHT_PRICE ||
      arrowType==OBJ_ARROW_BUY || arrowType==OBJ_ARROW_SELL || arrowType==OBJ_ARROW){
         ResetLastError();
         if(!ObjectCreate(chart_ID, name, arrowType, sub_window, time, price)){
            Print(__FUNCTION__, ": failed to create \"Arrow Up\" sign! Error code = ", GetLastError());
            return(false);
         }
         ObjectSetInteger(chart_ID,name, OBJPROP_ANCHOR, anchor);
         ObjectSetInteger(chart_ID,name, OBJPROP_COLOR, clr);
         ObjectSetInteger(chart_ID,name, OBJPROP_WIDTH, 3);
         return(true);
   } else return(false);
}


bool arrowSymbolCreate (long          chart_ID=0,           // chart's ID
                    string            name="ArrowUp",       // sign name
                    int               bar=1,                // anchor point time
                    double            price=0,              // anchor point price
                    ENUM_OBJECT       arrowType=OBJ_ARROW_UP, // anchor type
                    ENUM_ARROW_ANCHOR anchor=ANCHOR_BOTTOM, // anchor type
                    color             clr=clrWhite){
   int sub_window =0;
   if(arrowType==OBJ_ARROW_THUMB_UP || arrowType==OBJ_ARROW_THUMB_DOWN || arrowType==OBJ_ARROW_UP || arrowType==OBJ_ARROW_DOWN || 
      arrowType==OBJ_ARROW_STOP || arrowType==OBJ_ARROW_CHECK || OBJ_ARROW_LEFT_PRICE || arrowType==OBJ_ARROW_RIGHT_PRICE ||
      arrowType==OBJ_ARROW_BUY || arrowType==OBJ_ARROW_SELL || arrowType==OBJ_ARROW){
         ResetLastError();
         datetime time = iTime(Symbol(), PERIOD_CURRENT, bar);
         if(!ObjectCreate(chart_ID, name, arrowType, sub_window, time, price)){
            Print(__FUNCTION__, ": failed to create \"Arrow\" sign! Error code = ", GetLastError(),"     with name:  ", name);
            return(false);
         }
         ObjectSetInteger(chart_ID,name, OBJPROP_ANCHOR, anchor);
         ObjectSetInteger(chart_ID,name, OBJPROP_COLOR, clr);
         ObjectSetInteger(chart_ID,name, OBJPROP_WIDTH, 3);
         return(true);
   } else return(false);
}

// -------------------------------- DISPLAY --------------------------------
string displayDoubleArray(string textHeader, double & array[]){
   string textArray, textFinal;
   for(int i=0; i< ArraySize(array); i++)      
      textArray += string( NormalizeDouble(array[i], 5)) + "   ";
   
   textFinal = StringConcatenate(textHeader, textArray);
   return textFinal;
}

// 
void alertBLANKlineForNewBarOrTick(){   
   Alert(" -------------------------------------------- NEW -------------------------------------------- ");
   Alert("                                                                                               ");
}
           