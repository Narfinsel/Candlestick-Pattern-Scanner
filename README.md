# Candlestick-Pattern-Scanner
CandlestickPatternScanner is a utility class that helps Expert Advisors and trading bots to efficiently detect reversal candle pattern. These special patterns can be used as possible indications of trend-reversal, especially in conjunction with other indicators and signals.

<p align="left" dir="auto">
  <a target="_blank" rel="noopener noreferrer" href="/cps-1-31-deeppink-aqua-gif.gif">
    <img src="/img/cps-1-31-deeppink-aqua-gif.gif" alt="Detecting Reversal Candles">
  </a>
</p>

<h2>1. Intro</h2>
<strong>Motivation</strong> <p>Many online traders preffer to automate their trades, but they don't have good, reliable scripts, to help confidently detect candle-stick pattern like stars, engulfings and consolidation. I struggled with this alot and decided to make things easier for myself and other traders, by programming in and sharing this MQL5 Metatrader script.</p>
<strong>Problem</strong> <p>One of the biggest problems in trading with EAs (Expert Advisors/ trading bots) is finding reliable signals that can be actually used in code. There are many scripts in the marketplace that do visually idendify patterns on the chart. But very few (if any) convert these candle-patterns into usable, code-ready objects, that can easily be incorporated as part of the internal making of an algorithm.</p>
<strong>Solution</strong> <p>My script identifies reversal patterns, it converts them into objects stored in an array. There is an option to customize how rigid the detection should be, to mark out only the strongest reversal patterns. Visual square markings can be customized as well (color and thickness), on bullish and bearish patterns. I even optimized memory usage, by making sure to delete older pattern, or as soon as they are broken.</p>


<h2>2. Project Description</h2>
  <p align="center" dir="auto">
    <a target="_blank" rel="noopener noreferrer" href="/img/candle-patterns-red-green-v1.PNG">
      <img src="/img/candle-patterns-red-green-v1.PNG" alt="Goal Getter Add New Goal">
    </a>
  </p>

Based on priority, here are the candle-patterns that my scripts detects:
<ul>
  <li><em>Consolidations</em> are the strongest reversal signals since, they hold the most amount of information, often spaning across 3 to 6 bars.</li>
  <li><em>Engulfings</em> represent highly reliable reversal patterns, particularly if their position & timing are right. They appear more frequently, especially in mid-to-higher timeframes.</li>
  <li><em>Stars/Hammers</em>, are pretty reliable signals in high timeframes, if used togheter with other measurements and trading signals.</li>
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
              <img src="/img/candle-patterns-magenta-gold-v1.PNG" alt="Goal Getter Add New Goal">
            </a>
          </p>
          

            <i>
              <b>Bearish</b> patterns are displayed in magenta color and they indicate a downward move in price. As shown in the graph above, this is true actually.
              <b>Bullish</b> patterns appear in gold-yellow in this graph; bullish means that price will move upwards, and this appears to be the case here.
            </i>
        </td>
      </tr>
</table>
<table cellspacing="5" border="0">
      <tr>
        <td>
          <p align="center" dir="auto">
            <a target="_blank" rel="noopener noreferrer" href="/img/candle-patterns-deeppink-aqua-v1.PNG">
              <img src="/img/candle-patterns-deeppink-aqua-v1.PNG" alt="Goal Getter Add New Goal">
            </a>
          </p>
          
          <p>
            <i>            
              Similar example, but since color is a completely customizable feature, I chose alternative colors this time.
              <b>Deep pink means bearish signal</b>. The price will go down, or reverse from uptrend to downtrend.
              <b>Aqua blue is a bullish indicator</b>. Rising prices are expected, as the two bullish engulfings prove in this graphic.
            </i>
          </p>
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
