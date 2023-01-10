import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../provider/stopwatchModel.dart';


class CountUpStopButtun extends StatefulWidget {

  @override
  State createState() => CountUpStopButtunState();
}

class CountUpStopButtunState extends State<CountUpStopButtun> {
  // final _isHours = true;

  // final StopWatchTimer stopWatchTimer = StopWatchTimer(
  //   mode: StopWatchMode.countUp,
    
  //   onStopped: () {
  //     print('onStop');
  //   },
  //   onEnded: () {
  //     print('onEnded');
  //   },
  // );

  // final _scrollController = ScrollController();
  // final elapsedSeconds = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   stopWatchTimer.setPresetSecondTime(elapsedSeconds);
  //   stopWatchTimer.fetchStopped
  //       .listen((value) => print('stopped from stream'));
  //   stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));
  // }

  // @override
  // void dispose() async {
  //   super.dispose();
  //   await stopWatchTimer.dispose();
  // }
  

  @override
  Widget build(BuildContext context) {

    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  TimerModel = Provider.of<StopWatchTimerModel>(context);

    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        /// Display stop watch time
        // StreamBuilder<int>(
        //   stream: TimerModel.stopWatchTimer.rawTime,
        //   initialData: TimerModel.stopWatchTimer.rawTime.value,
        //   builder: (context, snap) {
        //     final value = snap.data!;
        //     final displayTime =
        //       StopWatchTimer.getDisplayTime(value, hours: TimerModel.isHours);
        //     return Column(
        //       children: <Widget>[
        //         // Container(
        //         //   padding: EdgeInsets.all(8.0.r),
        //         //   margin: EdgeInsets.only(left:8.w,right:8.w),
        //         //   alignment: Alignment.center,
        //         //   decoration: BoxDecoration(
        //         //   borderRadius: BorderRadius.all(Radius.circular(12.h)),
        //         //   color: Color.fromARGB(255, 183, 94, 29),
        //         //   ),
        //         //   child: Text(
        //         //     displayTime,
        //         //     style: TextStyle(
        //         //         fontSize: 42.sp,
        //         //         fontWeight: FontWeight.bold,
        //         //         color: Color(0xffFFFEF6)
        //         //       ),
        //         //   ),
        //         // ),
        //       ],
        //     );
        //   },
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                  'STOP',
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          //onPressed: TimerModel.stopWatchTimer.onStopTimer,
          onPressed: () {
                  TimerModel.stopWatchTimer.onStopTimer();
                  TimerModel.changeTimerMode();
                  TimerModel.recordElapsedSeconds();
                  print('stop and change bool');
                },
          shadowDegree: ShadowDegree.light,
          color: Color(0xffc3c8b0),
          //color: Color(0xff5f8d9a),
          //color: Color(0xffc3c8b0),
          //color: Color(0xfffac172),
          //color: Color(0xfff0ceb5),
        ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 4),
            //   child: ElevatedButton(
            //     //color: Colors.lightBlue,
            //     onPressed: () {
            //       TimerModel.stopWatchTimer.onStartTimer();
            //       print('start');
            //     },
            //     //onPressed: TimerModel.stopWatchTimer.onStartTimer,
            //     child: const Text(
            //       'Start',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 4),
            //   child: ElevatedButton(
            //     //color: Colors.green,
            //     onPressed: TimerModel.stopWatchTimer.onStopTimer,
            //     //onPressed:TimerModel.stopStopWatch(),
            //     child: const Text(
            //       'Stop',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 4),
            //   child: ElevatedButton(
            //     //color: Colors.red,
            //     onPressed: TimerModel.stopWatchTimer.onResetTimer,
            //     child: const Text(
            //       'Reset',
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),        
        // Padding(
        //   padding: const EdgeInsets.all(0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
              
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 4),
        //         child:ElevatedButton(
        //           //color: Colors.pinkAccent,
        //           onPressed: () {
        //             TimerModel.stopWatchTimer.setPresetSecondTime(10);
        //           },
        //           child: const Text(
        //             'Set Second',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 4),
        //   child: ElevatedButton(
        //     //color: Colors.pinkAccent,
        //     onPressed: TimerModel.stopWatchTimer.clearPresetTime,
        //     child: const Text(
        //       'Clear PresetTime',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}