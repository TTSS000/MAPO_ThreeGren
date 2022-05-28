//+------------------------------------------------------------------+
//|                                                  MAPO_Three.mq5 |
//|                                                          TTSS000 |
//|                                             https://twitter.com/ttss000 |
//+------------------------------------------------------------------+
#property copyright "TTSS000"
#property link      "https://twitter.com/ttss000"
#property version   "1.00"
#property strict
#property indicator_chart_window

#property indicator_buffers 11
#property indicator_plots   9
//--- 線のプロパティはコンパイラディレクティブで設定される
#property indicator_label1 "MA_L_Line"     // データウィンドウでのプロット名
#property indicator_type1   DRAW_LINE   // プロットの種類は「線」
#property indicator_color1  clrLime     // 線の色
#property indicator_style1 STYLE_SOLID // 線のスタイル
#property indicator_width1  1           // 線の幅

#property indicator_label2 "MA_M_Line"     // データウィンドウでのプロット名
#property indicator_type2   DRAW_LINE   // プロットの種類は「線」
#property indicator_color2  clrGreen     // 線の色
#property indicator_style2 STYLE_SOLID // 線のスタイル
#property indicator_width2  1           // 線の幅

#property indicator_label3 "MA_S_Line"     // データウィンドウでのプロット名
#property indicator_type3   DRAW_LINE   // プロットの種類は「線」
#property indicator_color3  clrBlue     // 線の色
#property indicator_style3 STYLE_SOLID // 線のスタイル
#property indicator_width3  1           // 線の幅

#property indicator_label4 "UpArrow"     // データウィンドウでのプロット名
#property indicator_type4   DRAW_ARROW   // プロットの種類は「yajirushi」
#property indicator_color4  clrBlue     // 線の色
#property indicator_style4 STYLE_SOLID // 線のスタイル
#property indicator_width4  1           // 線の幅

#property indicator_label5 "DnArrow"     // データウィンドウでのプロット名
#property indicator_type5   DRAW_ARROW   // プロットの種類は「yajirushi」
#property indicator_color5  clrRed     // 線の色
#property indicator_style5 STYLE_SOLID // 線のスタイル
#property indicator_width5  1           // 線の幅

#property indicator_label6 "UpStep1Arrow"     // データウィンドウでのプロット名
#property indicator_type6   DRAW_ARROW   // プロットの種類は「yajirushi」
#property indicator_color6  clrBlue     // 線の色
#property indicator_style6 STYLE_SOLID // 線のスタイル
#property indicator_width6  1           // 線の幅

#property indicator_label7 "DnStep1Arrow"     // データウィンドウでのプロット名
#property indicator_type7   DRAW_ARROW   // プロットの種類は「yajirushi」
#property indicator_color7  clrRed     // 線の色
#property indicator_style7 STYLE_SOLID // 線のスタイル
#property indicator_width7  1           // 線の幅

#property indicator_label8 "UpStep2Arrow"     // データウィンドウでのプロット名
#property indicator_type8   DRAW_ARROW   // プロットの種類は「yajirushi」
#property indicator_color8  clrTurquoise     // 線の色
#property indicator_style8 STYLE_SOLID // 線のスタイル
#property indicator_width8  1           // 線の幅

#property indicator_label9 "DnStep2Arrow"     // データウィンドウでのプロット名
#property indicator_type9   DRAW_ARROW   // プロットの種類は「yajirushi」
#property indicator_color9  clrBrown     // 線の色
#property indicator_style9 STYLE_SOLID // 線のスタイル
#property indicator_width9  1           // 線の幅

//#property indicator_color1 Lime
//#property indicator_width1 0

//#property indicator_color2 Green
//#property indicator_width2 0

//#property indicator_color3 Blue
//#property indicator_width3 0

// up
//#property indicator_color4 Blue
//#property indicator_width4 0

// down
//#property indicator_color5 Red
//#property indicator_width5 0



//---- input parameters
int MA_L_Bars=200; //長期移動平均線の本数
int MA_M_Bars=75; // 中期移動平均線の本数
int MA_S_Bars=20; // 短期移動平均線の本数
input int Symbol_UP=159; //上向きの記号の文字コード
input int Symbol_Down=159; //下向きの記号の文字コード

input int Symbol_Step2_UP=241; //上向きの記号の文字コード
input int Symbol_Step2_Down=242; //下向きの記号の文字コード
//extern int Symbol_UP=217; //上向きの記号の文字コード
//extern int Symbol_Down=218; //下向きの記号の文字コード
//extern int MVA_L=50; //長期移動平均線の日数大
//extern int MVA_S=50; //短期移動平均線の日数小

//---- buffers
double MA_L_Line[]; //
double MA_M_Line[]; //
double MA_S_Line[];//
double UpArrow[];
double DnArrow[];
double UpStep1Arrow[];
double DnStep1Arrow[];
double UpStep2Arrow[];
double DnStep2Arrow[];
double LongStatus[];
double ShortStatus[];

int h_MA_L;
int h_MA_M;
int h_MA_S;

int i_lastsig_Lplus_Sminus_0None=0;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
//--- indicator buffers mapping
//SetIndexStyle(0,DRAW_LINE);
//SetIndexStyle(0,DRAW_NONE);
  SetIndexBuffer(0,MA_L_Line, INDICATOR_DATA);
  PlotIndexSetInteger(0,PLOT_LINE_STYLE, STYLE_SOLID);

//SetIndexStyle(1,DRAW_LINE);
//SetIndexStyle(1,DRAW_NONE);
  SetIndexBuffer(1,MA_M_Line, INDICATOR_DATA);
  PlotIndexSetInteger(1,PLOT_LINE_STYLE, STYLE_SOLID);

//SetIndexStyle(2,DRAW_NONE);
  SetIndexBuffer(2,MA_S_Line, INDICATOR_DATA);
  PlotIndexSetInteger(2,PLOT_LINE_STYLE, STYLE_SOLID);

//SetIndexStyle(3,DRAW_ARROW);
//SetIndexArrow(2,233);
//SetIndexArrow(2,225);
//SetIndexArrow(3,Symbol_UP);
  SetIndexBuffer(3,UpArrow, INDICATOR_DATA);
  PlotIndexSetInteger(3,PLOT_ARROW,Symbol_UP);
//SetIndexStyle(4,DRAW_ARROW);
//SetIndexArrow(3,234);
//SetIndexArrow(3,226);
//SetIndexArrow(4,Symbol_Down);
  SetIndexBuffer(4,DnArrow, INDICATOR_DATA);
  PlotIndexSetInteger(4,PLOT_ARROW,Symbol_Down);

  SetIndexBuffer(5,UpStep1Arrow, INDICATOR_DATA);
  PlotIndexSetInteger(5,PLOT_ARROW,Symbol_UP);

  SetIndexBuffer(6,DnStep1Arrow, INDICATOR_DATA);
  PlotIndexSetInteger(6,PLOT_ARROW,Symbol_Down);

  SetIndexBuffer(7,UpStep2Arrow, INDICATOR_DATA);
  PlotIndexSetInteger(7,PLOT_ARROW,Symbol_Step2_UP);

  SetIndexBuffer(8,DnStep2Arrow, INDICATOR_DATA);
  PlotIndexSetInteger(8,PLOT_ARROW,Symbol_Step2_Down);

//PlotIndexSetInteger(5,PLOT_ARROW,Symbol_Down);
  SetIndexBuffer(9,LongStatus, INDICATOR_CALCULATIONS);
  SetIndexBuffer(10,ShortStatus, INDICATOR_CALCULATIONS);


//  MVA_5M75_Line[i]=iMA(NULL,PERIOD_M5,MVA_5M75,0,MODE_SMA,PRICE_CLOSE,i);
//  MVA_5M20_Line[i]=iMA(NULL,PERIOD_M5,MVA_5M20,0,MODE_SMA,PRICE_CLOSE,i);
//  MVA_5M5_Line[i]=iMA(NULL,PERIOD_M5,MVA_5M5,0,MODE_SMA,PRICE_CLOSE,i);

  h_MA_L=iMA(NULL, PERIOD_CURRENT, MA_L_Bars, 0, MODE_SMA, PRICE_CLOSE);
  h_MA_M=iMA(NULL, PERIOD_CURRENT, MA_M_Bars, 0, MODE_SMA, PRICE_CLOSE);
  h_MA_S=iMA(NULL, PERIOD_CURRENT, MA_S_Bars, 0, MODE_SMA, PRICE_CLOSE);

  ArraySetAsSeries(MA_L_Line, true);
  ArraySetAsSeries(MA_M_Line, true);
  ArraySetAsSeries(MA_S_Line, true);
  ArraySetAsSeries(UpArrow, true);
  ArraySetAsSeries(DnArrow, true);

  ArraySetAsSeries(UpStep1Arrow, true);
  ArraySetAsSeries(DnStep1Arrow, true);
  ArraySetAsSeries(UpStep2Arrow, true);
  ArraySetAsSeries(DnStep2Arrow, true);
  ArraySetAsSeries(LongStatus, true);
  ArraySetAsSeries(ShortStatus, true);

  return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
//---
//int limit=Bars()-IndicatorCounted();
  int limit=Bars(NULL, PERIOD_CURRENT) -prev_calculated;
//int i_tmp2 = MathMax(240, limit);
  int end_index = Bars(NULL, PERIOD_CURRENT) - prev_calculated;  // バー数取得(未計算分)

  CopyBuffer(h_MA_L,0,0,limit,MA_L_Line);
  CopyBuffer(h_MA_M,0,0,limit,MA_M_Line);
  CopyBuffer(h_MA_S,0,0,limit,MA_S_Line);

//for( int i = 0 ; i < end_index ; i++ ) {
  for( int i = end_index-2 ; 0<=i ; i-- ) {
    //for(int i=i_tmp2; i>=0; i--){

    if(i+1 <= end_index-1) {

      if(      ShortStatus[i+1]==3) {
        ShortStatus[i]=0;
      }
      if(      LongStatus[i+1]==3) {
        LongStatus[i]=0;
      }
    }
    UpArrow[i]=EMPTY_VALUE;
    DnArrow[i]=EMPTY_VALUE;

    UpStep1Arrow[i]=EMPTY_VALUE;
    DnStep1Arrow[i]=EMPTY_VALUE;
    UpStep2Arrow[i]=EMPTY_VALUE;
    DnStep2Arrow[i]=EMPTY_VALUE;

    int bar_minute=Period();
    //LongStatus[i]=0;
    //ShortStatus[i]=0;


    //---------- up arrow ----------
    if(//LongStatus[i]==0 &&
      MA_M_Line[i]<MA_S_Line[i]
      && MA_L_Line[i]<MA_M_Line[i]
      && MA_S_Line[i] > MA_S_Line[i+1]
      && MA_M_Line[i] > MA_M_Line[i+1]
      && MA_L_Line[i] > MA_L_Line[i+1]
    ) {
      if(      ShortStatus[i+1]==3) {
        ShortStatus[i]=0;
      }
      if(MA_S_Line[i] < iClose(NULL, PERIOD_CURRENT, i)) {
        UpArrow[i]=MA_L_Line[i];
        if(LongStatus[i+1]==0) {
          LongStatus[i]=1;
          //Print("000 LongStatus["+i+"]="+LongStatus[i]);
        }
        //UpStep1Arrow[i]=MA_M_Line[i];
      }

      //if(iClose(NULL, PERIOD_CURRENT, i) < MA_S_Line[i] && ShortStatus[i+1]==1 && UpArrow[i+1] != EMPTY_VALUE ) {
      if(LongStatus[i+1]==1) {
        LongStatus[i]=1;
        //Print("001 LongStatus["+i+"]="+LongStatus[i]);
      }
      if(LongStatus[i+1]==3) {
        LongStatus[i]=3;
        //Print("002 LongStatus["+i+"]="+LongStatus[i]);
      }
      if(
        iLow(NULL, PERIOD_CURRENT, i) < MA_S_Line[i]
        //&& LongStatus[i+1]==1
        && (UpArrow[i+1] != EMPTY_VALUE || UpArrow[i] != EMPTY_VALUE)
        //&& DnArrow[i] == EMPTY_VALUE
      ) {
        //Print("003 LongStatus["+i+"]="+LongStatus[i]);
        // touch from above
        if(MA_S_Line[i] < iClose(NULL, PERIOD_CURRENT, i)) {
          if(i_lastsig_Lplus_Sminus_0None != 1) {
            UpStep2Arrow[i]=MA_M_Line[i];
          }
          LongStatus[i]=3;
          i_lastsig_Lplus_Sminus_0None=1;
          //Print("004 LongStatus["+i+"]="+LongStatus[i]);
        } else {
          UpStep1Arrow[i]=MA_M_Line[i];
          LongStatus[i]=1;
          //Print("005 LongStatus["+i+"]="+LongStatus[i]);
        }
      } else if(MA_S_Line[i] < iClose(NULL, PERIOD_CURRENT, i) && LongStatus[i]==2  && UpArrow[i] != EMPTY_VALUE /* && DnArrow[i] == EMPTY_VALUE*/ ) {
        // touch from above
        if(i_lastsig_Lplus_Sminus_0None != 1) {
          UpStep2Arrow[i]=MA_M_Line[i];
        }
        i_lastsig_Lplus_Sminus_0None=1;
        LongStatus[i]=3;
        //Print("006 LongStatus["+i+"]="+LongStatus[i]);
        //longStatus[i]++;
      } else if(LongStatus[i+1]==1) {
        UpStep1Arrow[i]=MA_M_Line[i];
        //Print("007 LongStatus["+i+"]="+LongStatus[i]);
      } else if(LongStatus[i]==3) {
        UpStep1Arrow[i]=EMPTY_VALUE;
        UpStep2Arrow[i]=EMPTY_VALUE;
        //Print("008 LongStatus["+i+"]="+LongStatus[i]);
      }
    } else {
      LongStatus[i]=0;
      //i_lastsig_Lplus_Sminus_0None=0;
    }
    if(LongStatus[i]==0) {
      UpStep1Arrow[i]=EMPTY_VALUE;
      UpStep2Arrow[i]=EMPTY_VALUE;
      //Print("008 LongStatus["+i+"]="+LongStatus[i]);
    }



    //UpArrow[i]=MVA_5M75_Line[i];
    //------------------- down arrow ---------------------
    if(//ShortStatus[i]==0 &&
      MA_M_Line[i]>MA_S_Line[i]
      && MA_L_Line[i]>MA_M_Line[i]
      && MA_S_Line[i] < MA_S_Line[i+1]
      && MA_M_Line[i] < MA_M_Line[i+1]
      && MA_L_Line[i] < MA_L_Line[i+1]) {
      if(LongStatus[i+1]==3) {
        LongStatus[i]=0;
      }
      if(iClose(NULL, PERIOD_CURRENT, i) < MA_S_Line[i]) {
        //UpStep1Arrow[i]=MA_M_Line[i];
        DnArrow[i]=MA_L_Line[i];
        if(ShortStatus[i+1]==0) {
          ShortStatus[i]=1;
        }
      }
      //DnStep1Arrow[i]=MA_M_Line[i];
      //UpArrow[i]=MVA_5M75_Line[i];

      //if(iClose(NULL, PERIOD_CURRENT, i) < MA_S_Line[i] && ShortStatus[i+1]==1 && UpArrow[i+1] != EMPTY_VALUE ) {
      if(ShortStatus[i+1]==1) {
        ShortStatus[i]=1;
      }
      if(ShortStatus[i+1]==3) {
        ShortStatus[i]=3;
      }
      if(
        iHigh(NULL, PERIOD_CURRENT, i) > MA_S_Line[i]
        //&& ShortStatus[i+1]==1
        && (DnArrow[i+1] != EMPTY_VALUE || DnArrow[i] != EMPTY_VALUE)
        //&& UpArrow[i] == EMPTY_VALUE
      ) {
        // touch from below
        if(MA_S_Line[i] > iClose(NULL, PERIOD_CURRENT, i)) {
          if(i_lastsig_Lplus_Sminus_0None != -1) {
            DnStep2Arrow[i]=MA_M_Line[i];
          }
          ShortStatus[i]=3;
          i_lastsig_Lplus_Sminus_0None=-1;
        } else {
          DnStep1Arrow[i]=MA_M_Line[i];
          ShortStatus[i]=1;
        }
      } else if(MA_S_Line[i] > iClose(NULL, PERIOD_CURRENT, i) && ShortStatus[i]==2  && DnArrow[i] != EMPTY_VALUE /*  && UpArrow[i] == EMPTY_VALUE */) {
        // touch from above
        if(i_lastsig_Lplus_Sminus_0None != -1) {
          DnStep2Arrow[i]=MA_M_Line[i];
        }
        ShortStatus[i]=3;
        i_lastsig_Lplus_Sminus_0None=-1;
        //longStatus[i]++;
      } else if(ShortStatus[i+1]==1) {
        DnStep1Arrow[i]=MA_M_Line[i];
      } else if(ShortStatus[i]==3) {
        DnStep1Arrow[i]=EMPTY_VALUE;
        DnStep2Arrow[i]=EMPTY_VALUE;
      }
    } else {
      ShortStatus[i]=0;
      //i_lastsig_Lplus_Sminus_0None=0;
    }
    if(ShortStatus[i]==0) {
      DnStep1Arrow[i]=EMPTY_VALUE;
      DnStep1Arrow[i]=EMPTY_VALUE;
      //Print("008 LongStatus["+i+"]="+LongStatus[i]);
    }


  }//for//--- return value of prev_calculated for next call
  return(rates_total);
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
bool NewBar()
{
  static datetime dt = 0;
  if(dt != iTime(NULL, PERIOD_CURRENT, 0)) {
    dt = iTime(NULL, PERIOD_CURRENT, 0);
    //Sleep(100); // wait for tick
    return(true);
  }
  return(false);
}
//+------------------------------------------------------------------+
