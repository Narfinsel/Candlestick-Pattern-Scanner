# Candlestick-Pattern-Scanner
The Candlestick Pattern Scanner is a utility class that helps Expert Advisors and trading bots to efficiently detect reversal candle patterns. These special patterns can be used as potential indications of trend-reversals, especially in conjunction with other events, indicators and signals.

<p align="left" dir="auto">
  <a target="_blank" rel="noopener noreferrer" href="/cps-1-31-deeppink-aqua-gif.gif">
    <img src="/img/cps-1-31-deeppink-aqua-gif.gif" alt="Detecting Reversal Candles">
  </a>
</p>

<details><summary>CLICK ME</summary>
<p>

#### We can hide anything, even code!

    ```ruby
      puts "Hello World"
    ```

</p>
</details>


##### Table of Contents  
[Headers](#headers)  
[Emphasis](#emphasis)  
...snip...    
<a name="headers"/>
## Headers


<h2>1. Intro</h2>
<strong>Motivation</strong> <p>Many online traders preffer to automate their trading strategies, but they don't have good, reliable scripts, to help confidently detect candle-stick pattern like stars, engulfings and consolidation. I struggled with this alot and decided to make things easier for myself and other traders, by programming in and sharing this MQL5 Metatrader script.</p>
<strong>Problem</strong> <p>One of the biggest problems in trading with EAs (Expert Advisors/ trading bots) is finding reliable signals that can actually be used in code. There are many scripts in the marketplace that do visually idendify patterns on the chart, by drawing visual aids. But very few (if any) convert these candle-patterns into usable, code-ready objects, that can easily be incorporated as part of the internal making of an algorithm. Too many scripts only show patterns on the graphs, but that is useless for the trading bots, since they need objects from which to read data, to base decisions on.</p>
<strong>Solution</strong> <p>My script identifies reversal patterns, it converts them into objects stored in an array. There is an option to customize how rigid the pattern-detection should be, to mark out only the strongest reversal signals. Visual square markings can be customized as well (color, style and thickness), for bullish and bearish patterns. I even optimized memory usage, by making sure to delete older patterns, or broken ones. Reversal patterns have many attributes and my code can read, change, and distinguish reversals based on their properties - to decide which trading actions to undertake.</p>


<h2>2. Project Description</h2>
  <p align="center" dir="auto">
    <a target="_blank" rel="noopener noreferrer" href="/img/candle-patterns-red-green-v1.PNG">
      <img src="/img/candle-patterns-red-green-v1.PNG" alt="Green Red Bullish Bearish Reversals">
    </a>
  </p>

<h3>Definition & Terminology</h3>
  <p>What are <strong><em>bearish reversal patterns</em></strong>? [RED] Bearish consolidations & engulfings, along with evening stars are price bar signals, indicating that the price will be going downwards. It will continue dropping or reverse & fall, after an uptrend.</p>
  <p>What are <strong><em>bullish reversal patterns</em></strong>? [GREEN] Bullish patterns (consolidations, engulfings and morning stars) are a signal of rising prices. The price will be moving upwards, or reverse from downtrend to uptrend.</p>  


| Reversal  | STARS & HAMMERS                                                               | ENGULFINGS                                                                    | CONSOLIDATIONS 																	   |
| :---      | :---                                                                      | :---                                                                          	| :---																				   |															
| BEARISH         | <img src="/img/patterns/bearish-evening-star.PNG"><br> <i>Evening Star</i>   	| <img src="/img/patterns/bearish-engulfing.PNG"><br> <i>Bearish Engulfing</i>  | <img src="/img/patterns/bearish-consolidation.PNG"><br> <i>Bearish Consolidation</i> |
| BULLISH         | <img src="/img/patterns/bullish-morning-star.PNG"><br> <i>Morning Star</i>   	| <img src="/img/patterns/bullish-engulfing.PNG"><br> <i>Bullish Engulfing</i>  | <img src="/img/patterns/bullish-consolidation.PNG"><br> <i>Bullish Consolidation</i> |



Based on priority, my scripts detects the following candle-patterns:
<ul>
  <li><em>Consolidations</em> are the strongest reversal signals since they hold the highest amount of trading information, spaning across 3 to 6 bars.</li>
  <li><em>Engulfings</em> represent highly trustworthy reversal patterns, particularly if their position & timing are right. They appear more frequently in mid-to-higher timeframes.</li>
  <li><em>Stars & Hammers</em>, are pretty reliable signals in high timeframes, if used togheter with other measurements and trading signals.</li>
</ul>

| Priority | BULLISH Candle Patterns | BEARISH Candle Patterns |
| :---         |     :---       |          :--- |
| 1   | Bullish Consolidation     | Bearish Consolidation    |
| 2     | Bullish Engulfing       | Bearish Engulfing      |
| 3     | Morning Star / Hammer       | Evening Star      |



<table cellspacing="5" border="0">
  <tr>
    <td>
      <p align="center" dir="auto">
        <a target="_blank" rel="noopener noreferrer" href="/img/candle-patterns-magenta-gold-v1.PNG">
          <img src="/img/candle-patterns-magenta-gold-v1.PNG" alt="Candlestick Patterns Magenta and Gold">
        </a>
      </p>
      <p><i> <b>Bearish</b> patterns are encircled in a magenta color, and they indicate a downward move in price. As shown in the graph above, this is actually true. </i></p>
      <p><i> <b>Bullish</b> patterns appear in gold-yellow; bullish means that price will move upwards, and this appears to be the case here as well. </i></p>
    </td>
  </tr>
</table>

<table cellspacing="5" border="0">
  <tr>
    <td>
      <p align="center" dir="auto">
        <a target="_blank" rel="noopener noreferrer" href="/img/candle-patterns-deeppink-aqua-v1.PNG">
          <img src="/img/candle-patterns-deeppink-aqua-v1.PNG" alt="Candlestick Patterns Deep Pink and Aqua">
        </a>
      </p>
      <p><i> Similar example, but since color is a completely customizable feature, I chose an alternative color scheme this time. </i></p>
      <p><i> <b>Deep pink means bearish signal</b>. The price will drop, or reverse from uptrend to downtrend. </i></p>
      <p><i> <b>Aqua blue indicates a bullish reversal</b>. Rising prices are expected, as the two bullish engulfings prove in this graphic. </i></p>
    </td>
  </tr>
</table>
  


<p align="left" dir="auto">
  <a target="_blank" rel="noopener noreferrer" href="/cps-2-62-magenta-gold-gif.gif">
    <img src="/img/cps-2-62-magenta-gold-gif.gif" alt="Detecting Reversal Candles">
  </a>
</p>

<p align="left" dir="auto">
  <a target="_blank" rel="noopener noreferrer" href="/cps-1-deeppink-aqua-gif.gif">
    <img src="/img/cps-1-deeppink-aqua-gif.gif" alt="Detecting Reversal Candles">
  </a>
</p>


<h2>4. How to Install and Run the Project</h2>
<p><strong>Step 1.</strong> Include the class file in your trading robot. The file-path (inside the "#include" preprocessor directive) might change depending on your folder structure or where you place the file:</p>

```MQL5
#include <__SimonG\MS\CandlestickPatternScanner\CandlestickPatternScanner.mqh>
```
<p><strong>Step 2.</strong> Declare two global or local variables of type <em>"CandlestickPatternScanner"</em> and <em>"CandlestickPattern"</em>. 
Note that <em>"CandlestickPatternScanner"</em> detects, stores and retrieves objects of type <em>"CandlestickPattern"</em>, which are captured and saved at pointer location, as defined below:</p>

```MQL5
CandlestickPatternScanner * cps;
CandlestickPattern * patternDetected;
```

<p><strong>Step 3.</strong> Initialize the CandlestickPatternScanner object. The best place for this is inside the OnInit() function.

```MQL5
int OnInit(){
   cps = new CandlestickPatternScanner (Symbol(), PERIOD_CURRENT, 15, true);
   cps.adjust_Settings_Graphic_BearishReversals (clrDeepPink, STYLE_SOLID, 4);
   cps.adjust_Settings_Graphic_BullishReversals (clrAqua, STYLE_SOLID, 4);
   cps.adjust_Settings_Chart_Subwindow (0, 0);
   cps.adjust_Settings_Engulfings (0.75, 5);
   cps.adjust_Settings_Stars (0.25, 40, 0.35);
   cps.setDoDrawCandlePatternRect (true);
}
```
  
<p><strong>Step 4.</strong> Activate the CandlestickPatternScanner (cps), and set it up so that it extracts the most recent price reversal pattern (captured at pointer variable CandlestickPattern (patternDetected)).</p>
<p>This function detects the most recent reversal and stores it inside an array of predefined-size (see previous step). Even though we write this piece of code inside <strong>OnTick()</strong>, because of the internal structure of CandlestickPatternScanner class, the function is only called every PERIOD_CURRENT minutes. (5min, 15min, ... 1 Day).</p>
<p>This periodicity can either be your current timeframe (PERIOD_CURRENT) or any other desired chart timeframe: PERIOD_M15, PERIOD_H4, PERIOD_D (check MQL5 specs).</p>

```MQL5
void OnTick(){
   patternDetected = cps.updateAndReturn_Cps_onNewBar();
}
```

<p><strong>Step 5.</strong> Everything is set up. Use both objects and the most recently detected reversal pattern (bullish / bearish) in your code logic for the algorithm, to determine trading outcome.</p>

```MQL5
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
```

<p><strong>Step 6.</strong> Memory clean-up, optimization, object deletion. Clean-up is by default automatically performed by the CandlestickPatternScanner in two ways:</p>
<p>Patterns in the internal storage-array are deleted once broken. Secondly, since the array has a LIFO structure (Last-In-First-Out), whenever a new object is detected and stored, the last one (oldest one) is popped out and deleted. Closing/stopping the EA-bot eliminates the CandlestickPatternScanner objects, which removes the array and the CandlestickPattern objects inside of it: </p>

```MQL5
void OnDeinit (const int reason){
   delete cps;
   delete patternDetected;
}
```

<h2>5. How to Use the Project</h2>
<p>Now that we know how to install and run the project, let's see how we can use it. I shall provide a bunch of ideas for trading robots:</p>

| Pattern            | Moving Average    | Trading Outcome   |
| :---               |     :---          |          ---:     |
| Bullish Pattern    | Price above MA50  | Open BUY trade.   |
| Bearish Pattern    | Price below MA50  | Open SELL trade.  |


| Pattern            | RSI                  | Trading Outcome   |
| :---               |     :---             |          ---:     |
| Bullish Pattern    | Overbought (RSI<30)  | Open BUY trade.   |
| Bearish Pattern    | Oversold (RSI>30)    | Open SELL trade.  |


| Pattern            | Bollinger Bands         | Trading Outcome   |
| :---               |     :---                |          ---:     |
| Bullish Pattern    | Price above Upper Band  | Open BUY trade.   |
| Bearish Pattern    | Price below Lower Band  | Open SELL trade.  |


| Pattern            | Ichimoku Cloud           | Trading Outcome   |
| :---               |     :---                 |          ---:     |
| Bullish Pattern    | Green Cloud (Leading A)  | Open BUY trade.   |
| Bearish Pattern    | Red Cloud (Leading B)    | Open SELL trade.  |


| Pattern                         | Price                            | MACD                          | Trading Outcome   |
| :---                            |     :---                         |     :---                      |          ---:     |
| Bullish Engulfing on D/W/Mo     | Reach engulf. conterminous line  | Value above Signal on H1/H4.  | Open BUY trade.   |
| Bearish Engulfing on D/W/Mo     | Reach engulf. conterminous line  | Signal above Value on H1/H4.  | Open SELL trade.  |


| Pattern                         | Price                            | MACD                                      | Trading Outcome   |
| :---                            |     :---                         |     :---                                  |          ---:     |
| Bullish Engulfing on D/W/Mo     | Reach engulf. conterminous line  | Value is negative and below a threshold.  | Open BUY trade.   |
| Bearish Engulfing on D/W/Mo     | Reach engulf. conterminous line  | Value is posative and above a threshold.  | Open SELL trade.  |


<h2>6. Credits</h2>
<p>I can't credit anyone directly, but this section seems appropriate because I owe special thanks to so many course & content creators, chanels, youtubers.</p>
<p>1. MQL4 Programming. Visit https://www.youtube.com/channel/UCIuhfiM34b2P8qv_HX_uwug/featured </p>
<p>2. ForexBoat Team. Check out https://www.udemy.com/course/learn-mql4/ </p> 
<p>These guys create amazing content and I have learned so much from them!</p>

<h2>7. License</h2>
<p>Feel free to use this project for yourself. Or to edit it, use bits of it. Do not commercialize it!
My Candlestick-Pattern-Scanner project is licensed under the GNU AGPLv3 license. Check out the licence link to better understand what you can and cannot do with this code. </p>
