//+------------------------------------------------------------------+
//|                                                GeneralDrawer.mqh |
//|                                               Svetozar Pasulschi |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "SimonG"
#property link      "https://www.mql5.com"
#property strict


// ------------------------------------------------------------------------------------------------------ +
// ----------------------------------------- RECTANGLE CREATION ----------------------------------------- +

bool createRectangle (long chart_id, int sub_window, string nameRect, datetime time1, double price1, datetime time2, double price2, color clr, ENUM_LINE_STYLE style, int width, bool fill, bool back, 
                      bool selection, bool hidden, long z_order){
   ResetLastError();    //--- reset the error value
   ObjectDelete(nameRect);
   if( !ObjectCreate( chart_id, nameRect, OBJ_RECTANGLE, sub_window, time1, price1, time2, price2) ){       //--- create a rectangle by the given coordinates
      Alert(__FUNCTION__, ": failed to create a rectangle! Error code = ", GetLastError()); 
      return(false); 
   }
   ObjectSetInteger(sub_window, nameRect, OBJPROP_COLOR, clr);      //--- set rectangle color
   ObjectSetInteger(sub_window, nameRect, OBJPROP_STYLE, style);    //--- set the style of rectangle lines
   ObjectSetInteger(sub_window, nameRect, OBJPROP_WIDTH, width);    //--- set width of the rectangle lines
   ObjectSetInteger(sub_window, nameRect, OBJPROP_BACK, back);      //--- display in the foreground (false) or background (true)
   ObjectSetInteger(sub_window, nameRect, OBJPROP_FILL, fill);      //--- enable (true) or disable (false) the mode of filling the rectangle
   //--- enable (true) or disable (false) the mode of highlighting the rectangle for moving 
   //--- when creating a graphical object using ObjectCreate function, the object cannot be 
   //--- highlighted and moved by default. Inside this method, selection parameter 
   //--- is true by default making it possible to highlight and move the object 
   ObjectSetInteger(sub_window, nameRect, OBJPROP_SELECTABLE, selection);
   ObjectSetInteger(sub_window, nameRect, OBJPROP_SELECTED, selection);
   ObjectSetInteger(sub_window, nameRect, OBJPROP_HIDDEN, hidden);  //--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(sub_window, nameRect, OBJPROP_ZORDER, z_order); //--- set the priority for receiving the event of a mouse click in the chart
   return(true);                                                  //--- successful execution 
}

bool createTrendLine_WtithDelete (
                      long            chart_ID,    // chart's ID
                      int             sub_window,  // subwindow index 
                      datetime        time1,       // time start
                      double          price1,      // price start
                      datetime        time2,       // time end
                      double          price2,      // price end
                      string          name,        // object name
                      color           clr,         // object color
                      ENUM_LINE_STYLE style,       // object line style
                      int             width,       // object line width
                      bool            back,        // in the background
                      bool            ray,         // extends
                      bool            hidden){     // hidden in the object list
   ResetLastError();       //--- reset the error value
   if( ObjectDelete (chart_ID, name) )                     //--- delete object if one exists with same name
      return(false);
   if( !ObjectCreate(chart_ID, name, OBJ_TREND, sub_window, time1, price1, time2, price2) ){     //--- create a trend line by the given coordinates
      Print(__FUNCTION__, ": failed to create a trend line! Error code = ", GetLastError());
      return(false);
   }
   if(width < 1)    width= 1;
   if(width > 5)    width= 5;
   ObjectSetInteger(chart_ID, name, OBJPROP_COLOR, clr);        //--- set line color
   ObjectSetInteger(chart_ID, name, OBJPROP_STYLE, style);      //--- set line display style
   ObjectSetInteger(chart_ID, name, OBJPROP_WIDTH, width);      //--- set line width
   ObjectSetInteger(chart_ID, name, OBJPROP_BACK, back);        //--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_SELECTED, false);
   ObjectSetInteger(chart_ID, name, OBJPROP_RAY_RIGHT, ray);  //--- enable (true) or disable (false) the mode of continuation of the line's display to the right
   ObjectSetInteger(chart_ID, name, OBJPROP_HIDDEN, hidden);    //--- hide (true) or display (false) graphical object name in the object list
   return(true);                                                //--- successful execution
}


bool createText (const long              chart_ID=0,               // chart's ID 
                 const int               sub_window=0,             // subwindow index 
                 const string            name="Text",              // object name 
                 datetime                time=0,                   // anchor point time 
                 double                  price=0,                  // anchor point price 
                 const string            text="Text",              // the text itself 
                 const string            font="Arial",             // font 
                 const int               font_size=10,             // font size 
                 const color             clr=clrRed,               // color 
                 const double            angle=0.0,                // text slope 
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type 
                 const bool              back=false,               // in the background 
                 const bool              selection=false,          // highlight to move 
                 const bool              hidden=true,              // hidden in the object list 
                 const long              z_order=0){               // priority for mouse click
   ResetLastError();                                           //--- reset the error value 
   if(!ObjectCreate(chart_ID,name, OBJ_TEXT, sub_window, time, price)){  //--- create Text object 
      Print(__FUNCTION__, ": failed to create \"Text\" object! Error code = ",GetLastError()); 
      return(false); 
   } 
   ObjectSetString (chart_ID,name, OBJPROP_TEXT, text);           //--- set the text 
   ObjectSetString (chart_ID,name, OBJPROP_FONT, font);           //--- set text font 
   //ObjectSetInteger (chart_ID,name, OBJPROP_ANCHOR, anchor);      //--- set anchor type 
   ObjectSetInteger (chart_ID,name, OBJPROP_FONTSIZE, font_size); //--- set font size 
   ObjectSetDouble (chart_ID,name, OBJPROP_ANGLE, angle);         //--- set the slope angle of the text
   ObjectSetInteger (chart_ID,name, OBJPROP_ANCHOR, anchor);      //--- set anchor type 
   
   ObjectSetInteger (chart_ID,name, OBJPROP_ANCHOR, anchor);      //--- set anchor type 
   ObjectSetInteger (chart_ID,name, OBJPROP_COLOR, clr);          //--- set color 
   ObjectSetInteger (chart_ID,name, OBJPROP_BACK, back);          //--- display in the foreground (false) or background (true) 
   ObjectSetInteger (chart_ID,name, OBJPROP_SELECTABLE, selection); //--- enable (true) or disable (false) the mode of moving the object by mouse 
   ObjectSetInteger (chart_ID,name, OBJPROP_SELECTED, selection); 
   ObjectSetInteger (chart_ID,name, OBJPROP_HIDDEN, hidden);      //--- hide (true) or display (false) graphical object name in the object list 
   ObjectSetInteger (chart_ID,name, OBJPROP_ZORDER, z_order);     //--- set the priority for receiving the event of a mouse click in the chart 
   return(true);                                                  //--- successful execution 
}


bool createLabel(const long              chart_ID=0,               // chart's ID
                 const int               sub_window=0,             // subwindow index
                 const string            name="Label",             // label name
                 const int               x=0,                      // X coordinate
                 const int               y=0,                      // Y coordinate
                 const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // chart corner for anchoring
                 const string            text="Label",             // text
                 const string            font="Arial",             // font
                 const int               font_size=10,             // font size
                 const color             clr=clrRed,               // color
                 const double            angle=0.0,                // text slope
                 const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // anchor type
                 const bool              back=false,               // in the background
                 const bool              selection=false,          // highlight to move
                 const bool              hidden=true,              // hidden in the object list
                 const long              z_order=0){               // priority for mouse click
   ResetLastError();                                                 //--- reset the error value
   if( !ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0) ){      //--- create a text label
      Print(__FUNCTION__, ": failed to create text label! Error code = ", GetLastError());
      return(false);
   }
   ObjectSetInteger (chart_ID,name, OBJPROP_XDISTANCE, x);           //--- set label coordinates
   ObjectSetInteger (chart_ID,name, OBJPROP_YDISTANCE, y);           //--- set label coordinates
   ObjectSetInteger (chart_ID,name, OBJPROP_CORNER, corner);         //--- set the chart's corner, relative to which point coordinates are defined
   ObjectSetString (chart_ID,name, OBJPROP_TEXT, text);              //--- set the text
   ObjectSetString (chart_ID,name, OBJPROP_FONT, font);              //--- set text font
   ObjectSetInteger (chart_ID,name, OBJPROP_FONTSIZE, font_size);    //--- set font size
   ObjectSetDouble (chart_ID,name, OBJPROP_ANGLE, angle);            //--- set the slope angle of the text
   ObjectSetInteger (chart_ID,name, OBJPROP_ANCHOR, anchor);         //--- set anchor type
   ObjectSetInteger (chart_ID,name, OBJPROP_COLOR, clr);             //--- set color
   ObjectSetInteger (chart_ID,name, OBJPROP_BACK, back);             //--- display in the foreground (false) or background (true)
   ObjectSetInteger (chart_ID,name, OBJPROP_SELECTABLE, selection);  //--- enable (true) or disable (false) the mode of moving the label by mouse
   ObjectSetInteger (chart_ID,name, OBJPROP_SELECTED, selection);
   ObjectSetInteger (chart_ID,name, OBJPROP_HIDDEN, hidden);         //--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger (chart_ID,name, OBJPROP_ZORDER, z_order);        //--- set the priority for receiving the event of a mouse click in the chart
   return(true);                                                     //--- successful execution
  }