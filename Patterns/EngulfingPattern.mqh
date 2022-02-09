//+------------------------------------------------------------------+
//|                                             EngulfingPattern.mqh |
//|                                                           SimonG |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "SimonG"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#include <__SimonG\MS\CandlestickPatternScanner\Patterns\CandlestickPattern.mqh>


class EngulfingPattern : public CandlestickPattern{
   private:
      
   public:
      EngulfingPattern();
      ~EngulfingPattern();
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
EngulfingPattern :: EngulfingPattern(){}
EngulfingPattern :: ~EngulfingPattern(){}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
