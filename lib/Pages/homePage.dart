import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:timeclock/widgets/fluatingActionBubble.dart';
import 'package:timeclock/provider/providers.dart';
import '../provider/stopwatchModel.dart';
import '../provider/stopwatch_model.dart';
import '../widgets/timer_picker.dart';
import 'countUpStartButtun.dart';
import 'countUpStopButtun.dart';
import 'countUpTimerWidget.dart';
import 'exampletimer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  @override
  Widget build(BuildContext context) {
    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  stateDate = Provider.of<TimerProvider>(context);

    var _height = MediaQuery.of(context).size.height;
    var  _width = MediaQuery.of(context).size.width;

    final CountDownController controller = new CountDownController();
    bool isReverse = true;

    return Scaffold(
      body: Column(
        children: [
          TopBar_Widget(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            // transitionBuilder: (Widget child, Animation<double> animation) {
            //   return ScaleTransition(scale: animation, child: child);
            // },
            child: ((){//即時関数を使えばif文が使える。ただしwidgetを返すにはreturnが必要
              if (stateDate.currentPageIndex == 0) {
                return SavingTimeWidget(height: _height, width: _width,);
              } else if(stateDate.currentPageIndex == 1){
                return SpendingTimeWidget(controller: controller, isReverse: isReverse);
              } else if(stateDate.currentPageIndex == 2){
                return 
                Setting();
                

              } else{
                //return SavingTimeWidget(height: _height, width: _width);
              }
            })(),
          ),
        ],
      ),
    
      floatingActionButton: Container(
        margin:EdgeInsets.only(bottom: 50.0.h,right: 10.w,),
        child: FloatingActionBubbleWidget()),
    );
    //将来的にはここに広告
  }
}

class Setting extends StatelessWidget {
  const Setting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  TimerModel = Provider.of<StopWatchTimerModel>(context);
    return Column(
      children: [
        SizedBox(height: 48.h,),
        Text('【設定】',
        style: TextStyle(
              fontSize: 30.sp,
              color: Color(0xff5f8d9a),
              fontWeight: FontWeight.bold,
            ),
        ),
        SizedBox(height: 24.h,),
        Text('・貯めた時間をリセットする',
        style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xff5f8d9a),
              fontWeight: FontWeight.bold,
            ),
        ),
        SizedBox(height: 24.h,),
        AnimatedButton(
            height: 60.h,
            width: 180.w,
              child: Padding(
                padding:EdgeInsets.all(8.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size:28.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'RESET',
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              //onPressed: TimerModel.stopWatchTimer.onStopTimer,
              onPressed: () {
                TimerModel.removePrefItems();
                print('reset');
              },
              shadowDegree: ShadowDegree.light,
              //color: Color(0xffc3c8b0),
              color: Color(0xff5f8d9a),
              // color: Color(0xffc3c8b0),
              // color: Color(0xfffac172),
              // color: Color(0xfff0ceb5),
            ),
        
      ],
    );
  }
}


class SpendingTimeWidget extends StatefulWidget {
  const SpendingTimeWidget({
    super.key,
    required this.controller,
    required this.isReverse,
    
  });

  final CountDownController controller;
  final bool isReverse;
  

  @override
  State<SpendingTimeWidget> createState() => SpendingTimeWidgetState();
}

class SpendingTimeWidgetState extends State<SpendingTimeWidget> {

  
  
  @override
  Widget build(BuildContext context) {

    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  TimerModel = Provider.of<StopWatchTimerModel>(context);
    final  stateDate = Provider.of<TimerProvider>(context);

    List <String> wordsList = [      
      '時間を使用中',
    ];
    var random = new Random();

    var randomWords = wordsList[random.nextInt(wordsList.length)];
    void chageWords(){
      setState(() {
        randomWords == randomWords;
      });
      print(randomWords);
    }

    return Column(
      children: [
        SizedBox(height: 48.h,),
        
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 10000),
          child: stateDate.hasTimerDuration?
          Column(
            children: [
              SizedBox(height: 20.h,),
              NeonCircularTimer(
                onComplete: () {
                  
                  stateDate.setSpendingTimer();
                  stateDate.setTimerDuration();
                  //ここでリセットするのが重要
                  TimerModel.stopWatchTimer.onResetTimer();
                  print('reset');
                  print('アラーム終了です');
                },
                width: 240.w,
                controller: widget.controller,//カウントsダウン タイマーを制御 (開始、一時停止、再開、再起動)
                duration: TimerModel.spendTime,//秒単位のカウントダウン期間
                strokeWidth: 16,
                textFormat:TextFormat.HH_MM_SS,
                initialDuration:0,//CurrentTimer,//タイマーの最初の経過時間 (秒)
                isTimerTextShown: true,
                isReverse:widget.isReverse,//カウントダウンモード
                isReverseAnimation:widget.isReverse,
                autoStart:false,
                neumorphicEffect: true,//ニューモーフィックボーダーを表示
                outerStrokeColor: Colors.grey.shade100,//カウントダウン ウィジェットの境界線の色
                innerFillGradient: LinearGradient(colors: [
                  Color(0xffeee3d0),
                  Color(0xfffac172)
                ]),
                neonGradient: LinearGradient(colors: [
                  Color(0xffeee3d0),
                  Color(0xfffac172)
                ]),
                strokeCap: StrokeCap.round,
                innerFillColor: Color(0xffFFFEF6),
                backgroudColor: Colors.grey.shade100,//丸の部分の背景
                neonColor: Color(0xfffac172),
                ),
              //const SizedBox(height: 24),
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.all(24.r),
                child: Column(
                  children: [
                    Text('時間を費う',
                    style: TextStyle(
                          fontSize: 24.sp,
                          color: Color(0xff5f8d9a),
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    SizedBox(height: 8.h,),
                    AnimatedButton(
                        height: 80.h,
                        width: 220.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: stateDate.isTimerRunning?//時間を使うタイマーがスタートしているか
          
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.emoji_food_beverage,
                                color: Colors.white,
                                size:32.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text( randomWords,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )
                        :Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.emoji_food_beverage,
                                color: Colors.white,
                                size:32.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text( 'START',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (stateDate.isTimerRunning == true) {
                          
                          //chageWords();
                          //widget.controller.pause();
                          //stateDate.setSpendingTimer();
                          //print('ボタンは無効化されました');
                        } else {
                          print('isStartSepedingTimer:${stateDate.isTimerRunning}');
                        
                          widget.controller.start();
                          
                          stateDate.setSpendingTimer();
                          TimerModel.subtractElapsedSeconds();
                        }
                      },
                      shadowDegree: ShadowDegree.light,
                      color: Color(0xffeee3d0),
                      //color: Color(0xff5f8d9a),
                      //color: Color(0xffc3c8b0),
                      //color: Color(0xfffac172),
                      //color: Color(0xfff0ceb5),
                    ),
                  ],
                ),
              ),
            ],
          ):
          Column(
            children: [
              LottieAnimation(),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text('時間を費う',
                    style: TextStyle(
                          fontSize: 24.sp,
                          color: Color(0xff5f8d9a),
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    SizedBox(height: 8.h,),
                    TimerPickerPage(),
                  ],
                ),
              ),
            ],
          )
          ,
        ),
        
      ],
    );
  }
}

class SavingTimeWidget extends StatelessWidget {
  const SavingTimeWidget({
    super.key,
    required double height,
    required double width,
  }) : _height = height, _width = width;

  final double _height;
  final double _width;
  
  

  @override
  Widget build(BuildContext context) {
    final  stateDate = Provider.of<TimerProvider>(context);
    final  model = Provider.of<StopWatchModel>(context);

    //Provider.of<T>(context) で親Widgetからデータを受け取る
    final  TimerModel = Provider.of<StopWatchTimerModel>(context);


    CountUpTimerPageState countUpTimer = CountUpTimerPageState();
    // setPrefItems() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // // 以下の「stopWatch」がキー名。
    // prefs.setString('stopWatch', model.stopWatchTimeDisplay);
    // print('sharedPreferencesに記録stopWatchTimeDisplay=${model.stopWatchTimeDisplay}');
    // }
    // Provider.of<T>(context) で親Widgetからデータを受け取る

    
    return Column(
      children: [
        SizedBox(height: 48.h,),
        LottieAnimation(),
        SizedBox(height: 24.h,),
        Text('時間を貯める',
        style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xff5f8d9a),
              fontWeight: FontWeight.bold,
            ),
        ),
        SizedBox(height: 8.h,),
        if (TimerModel.isTimerWorking) 
          CountUpStopButtun() 
        else 
          CountUpStartButtun()//startbuttun
      ],
    );
  }
}

class LottieAnimation extends StatelessWidget {
  const LottieAnimation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var  _width = MediaQuery.of(context).size.width;

    //String LottieImage ='assets/animation/saving_pig.json'; //デフォルトの画像

    final LottieImages = [
      'assets/animation/saving_pig.json',//豚貯金
      'assets/animation/cafe_time.json',//カフェタイム
      'assets/animation/thinking_man.json',
      'assets/animation/stopwatch.json',
      'assets/animation/Mechanical_timer.json',
      //'assets/animation/PeopleShopping.json',
      'assets/animation/peopleWithCalendar.json',
      'assets/animation/peopleWithClock.json',
    ];
    var random = new Random();
    
    var randomElem = LottieImages[random.nextInt(LottieImages.length)];
    
    
    return Container(
      //color: Colors.amberAccent,
      height:_height*0.3.h,
      child:Lottie.asset(randomElem),
    );
  }
}


class TopBar_Widget extends StatefulWidget {
  const TopBar_Widget({
    Key? key,
  }) : super(key: key);

  @override
  State<TopBar_Widget> createState() => _TopBar_WidgetState();
}
class _TopBar_WidgetState extends State<TopBar_Widget> {



  @override
  Widget build(BuildContext context) {
    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  TimerModel = Provider.of<StopWatchTimerModel>(context);

    var _height = MediaQuery.of(context).size.height;
    var  _width = MediaQuery.of(context).size.width;
  
    return Stack(
      children: <Widget>[
        Positioned(
          child: Container(
            child: Center(
            child: Container(
              //width:  double.infinity,
              height: 310.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.r),),
                color: Color(0xffc3c8b0),
              ),
            ),
            ),
          ),
        ),
        Container(
          width: _width,
          height: 110.h,
          child: Lottie.asset('assets/animation/topWave2.json', fit: BoxFit.cover),
        ),
        Container(
          //color: Colors.amberAccent,
          alignment: Alignment.center,
          margin: EdgeInsets.only( top: 50.h,left: 20.w, right: 20.w),
          child: Image.asset('assets/icon/TimeBankアプリテーマ日本語無し.png')),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 174.h),
          //color: Colors.amber,
          child: Material(
            borderRadius: BorderRadius.circular(16.h),
            elevation: 4,
            color:Color(0xffFFFEF6),
            child: Container(
              padding: EdgeInsets.all(10.h),
              width: _width/1.2.w,
              //height: _height/14.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0.r),
              ),
              child:  
              Center(
                child: CountUpTimerPage(),
              ),
            ),
          ),
        ),
        // Container(//上の横並びのところ
        // //color: Colors.blue,
        //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: _height/20.h),//上のやつ高さ
        //   child: Row(
        //     //crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: <Widget>[
        //       //右上のベルマーク
        //       Opacity(
        //         opacity: 0.5,
        //         child: GestureDetector(
        //           onTap: (){
        //             //押した時の処理
        //             TimerModel.removePrefItems();
        //             print('reset');
        //           },
        //             child: Icon(Icons.notifications, color: Colors.black,size: 30.h,)),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
