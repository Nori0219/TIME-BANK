import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:timeclock/Pages/fluatingActionBubble.dart';
import 'package:timeclock/provider/providers.dart';

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
    int CurrentTimer = 0;
    String str = '';
    
    void setCurrentTimer () {
      controller.getTime();
      str = controller.getTime();
      print(str);
      //CurrentTimer = int.parse(str);
    }
    bool isReverse = true;

    return Scaffold(
      body: Column(
        children: [
          TopBar_Widget(),
          stateDate.isSavingTime && !stateDate.isSpendTime ? SavingTimeWidget(height: _height, width: _width):
          Column(
            children: [
              NeonCircularTimer(
                          onComplete: () {
                            setCurrentTimer();
                            controller.restart();
                          },
                          width: 240,
                          controller: controller,//カウントsダウン タイマーを制御 (開始、一時停止、再開、再起動)
                          duration: 180,//秒単位のカウントダウン期間
                          strokeWidth: 16,
                          textFormat:TextFormat.HH_MM_SS,
                          initialDuration:0,//CurrentTimer,//タイマーの最初の経過時間 (秒)
                          isTimerTextShown: true,
                          isReverse:isReverse,//カウントダウンモード
                          isReverseAnimation:isReverse,
                          autoStart:false,
                          neumorphicEffect: true,//ニューモーフィックボーダーを表示
                          outerStrokeColor: Colors.grey.shade100,//カウントダウン ウィジェットの境界線の色
                          innerFillGradient: LinearGradient(colors: [
                            Colors.greenAccent.shade200,
                            Colors.blueAccent.shade400
                          ]),
                          neonGradient: LinearGradient(colors: [
                            Colors.greenAccent.shade200,
                            Colors.blueAccent.shade400
                          ]),
                          strokeCap: StrokeCap.round,
                          innerFillColor: Color.fromARGB(150, 4, 189, 149),
                          backgroudColor: Colors.grey.shade100,//丸の部分の背景
                          neonColor: Colors.blue.shade900,),
                          Padding(
                    padding: const EdgeInsets.all(40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: () {
                                controller.resume();
                              }),
                          IconButton(
                              icon: Icon(Icons.pause),
                              onPressed: () {
                                controller.pause();
                              }),
                          IconButton(
                              icon: Icon(Icons.repeat),
                              onPressed: () {
                                controller.restart();
                              }),
                          IconButton(
                              icon: Icon(Icons.hourglass_bottom),
                              onPressed: () {
                                controller.getTimeInSeconds();
                                print(controller.getTime());
                                str = controller.getTime();
                                isReverse =! isReverse;
                                print('isReverse=$isReverse');
                              }),
                        ]),
                  ),
            ],
          ),
        ],
      ),
      //loatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
      floatingActionButton: Container(
        margin:EdgeInsets.only(bottom: 50.0,right: 30,),
        child: FloatingActionBubbleWidget()),
    );
    //将来的にはここに広告
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
    return Column(
      children: [
        LottieAnimation(),
        SizedBox(height: _height/16,),
        AnimatedButton(
          height: 80.h,
          width: 220.w,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size:32.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'START',
                style: TextStyle(
                  fontSize: 32.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          // print('width: $_width');
          // print('height: $_height');
        },
        shadowDegree: ShadowDegree.light,
        color: Color(0xffeee3d0),
        //color: Color(0xff5f8d9a),
        //color: Color(0xffc3c8b0),
        //color: Color(0xfffac172),
        //color: Color(0xfff0ceb5),
      ),
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

    final LottieImages = [
      'assets/animation/saving_pig.json',//豚貯金
      'assets/animation/cafe_time.json',//カフェタイム
      'assets/animation/thinking_man.json',
      'assets/animation/stopwatch.json',
      'assets/animation/Mechanical_timer.json',
    ];
    var random = new Random();

    var randomElem = LottieImages[random.nextInt(LottieImages.length)];;


    return Container(
      //color: Colors.amberAccent,
      height:_height*0.3,
      child:Lottie.asset(randomElem),
    );
  }
}


class TopBar_Widget extends StatelessWidget {
  const TopBar_Widget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var  _width = MediaQuery.of(context).size.width;

    return Stack(
      //alignment: AlignmentDirectional.center,
      children: <Widget>[
        Positioned(
          child: Container(
            child: Center(
            child: Container(
              //width:  double.infinity,
              height: _height / 3.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.r),),
                color: Color(0xffc3c8b0),
              ),
            ),
            ),
          ),
        ),
        Container(
          //color: Colors.amber,
          //width: _width/2, 
          alignment: Alignment.center,
          margin: EdgeInsets.only( top: _height/24),
          child: Container( child: Column(
            children: [
              Text('TIME BANK',textAlign: TextAlign.center,style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.bold),),
              Icon(Icons.savings_outlined,size: 64.h,color: Color(0xfffac172),)
            ],
          ))),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: _height/5),
          //color: Colors.amber,
          child: Material(
            borderRadius: BorderRadius.circular(30.h),
            elevation: 4,
            child: Container(
              padding: EdgeInsets.all(10.h),
              width: _width/1.2.w,
              height: _height/14.h,
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.blue), //縁の色
                borderRadius: BorderRadius.circular(30.0),
              ),
              child:  
              Center(
                child: SlideCountdownSeparated(
                  duration: const Duration(days: 2),
                  countUp: true,
                  height: 50.h,
                  width: 50.h,
                  textStyle: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold,color: Colors.white),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.h)),
                  color: Color(0xfff0ceb5),
                  
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(//上の横並びのところ
        //color: Colors.blue,
          margin: EdgeInsets.only(left: 20.w, right: 20.w, top: _height/20),//上のやつ高さ
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //右上のベルマーク
              Opacity(
                opacity: 0.5,
                child: GestureDetector(
                  onTap: (){
                    //押した時の処理
                  },
                    child: Icon(Icons.notifications, color: Colors.black,size: 30.h,)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

