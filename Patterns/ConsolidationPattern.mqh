//+------------------------------------------------------------------+
//|                                         ConsolidationPattern.mqh |
//|                                               Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "SimonG"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <__SimonG\MS\CandlestickPatternScanner\Patterns\CandlestickPattern.mqh>


class ConsolidationPattern : public CandlestickPattern {
   private:
      
   public:
      ConsolidationPattern();
      ~ConsolidationPattern();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ConsolidationPattern :: ConsolidationPattern(){}
ConsolidationPattern :: ~ConsolidationPattern(){}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
