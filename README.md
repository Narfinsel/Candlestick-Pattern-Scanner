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

| Priority | BULLISH Candle Patterns | BEARISH Candle Patterns |
| :---         |     :---:      |          ---: |
| 1   | Bullish Consolidation     | Bearish Consolidation    |
| 2     | Bullish Engulfing       | Bearish Engulfing      |
| 3     | Morning Star / Hammer       | Evening Star      |


<table cellspacing="5" border="0">
      <tr>
        <td>
          <p align="center" dir="auto">
            <a target="_blank" rel="noopener noreferrer" href="/img/candle-patterns-red-green-v1.PNG">
              <img src="/img/candle-patterns-red-green-v1.PNG" alt="Goal Getter Add New Goal">
            </a>
          </p>
        </td>
      </tr>
      <tr>
        <td>
          <p align="center" dir="auto">
            <a target="_blank" rel="noopener noreferrer" href="/img/candle-patterns-magenta-gold-v1.PNG">
              <img src="/img/candle-patterns-magenta-gold-v1.PNG" alt="Goal Getter Add New Goal">
            </a>
          </p>
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
