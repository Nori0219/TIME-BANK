import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../provider/stopwatchModel.dart';

class CountUpTimerPage extends StatefulWidget {

  @override
  State createState() => CountUpTimerPageState();
}

class CountUpTimerPageState extends State<CountUpTimerPage> {
  // final _isHours = true;

  // final StopWatchTimer stopWatchTimer = StopWatchTimer(
  //   mode: StopWatchMode.countUp,
  //   //onChange: (value) => print('onChange $value'),
  //   //onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
  //   //onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
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
  //  // _stopWatchTimer.rawTime.listen((value) =>
  //   //    print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
  //   // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
  //   // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
  //   // _stopWatchTimer.records.listen((value) => print('records $value'));
  //   stopWatchTimer.fetchStopped
  //       .listen((value) => print('stopped from stream'));
  //   stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

  //   /// Can be set preset time. This case is "00:01.23".
  //   // _stopWatchTimer.setPresetTime(mSec: 1234);
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
        StreamBuilder<int>(
          stream: TimerModel.stopWatchTimer.rawTime,
          initialData: TimerModel.stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data!;
            final displayTime =
              StopWatchTimer.getDisplayTime(value, hours: TimerModel.isHours);
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0.r),
                  margin: EdgeInsets.only(left:8.w,right:8.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.h)),
                  color: Color(0xfff0ceb5),
                  ),
                  child: Text(
                    displayTime,
                    style: TextStyle(
                        fontSize: 42.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFFFEF6)
                      ),
                  ),
                ),

              ],
            );
          },
        ),

        // /// Display every second.
        // StreamBuilder<int>(
        //   stream: stopWatchTimer.secondTime,
        //   initialData: stopWatchTimer.secondTime.value,
        //   builder: (context, snap) {
        //     final value = snap.data;
        //     print('Listen every second. $value');
        //     return Column(
        //       children: <Widget>[
        //         Padding(
        //             padding: const EdgeInsets.all(8),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               children: <Widget>[
        //                 const Padding(
        //                   padding: EdgeInsets.symmetric(horizontal: 4),
        //                   child: Text(
        //                     'second',
        //                     style: TextStyle(
        //                       fontSize: 17,
        //                       fontFamily: 'Helvetica',
        //                     ),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding:
        //                       const EdgeInsets.symmetric(horizontal: 4),
        //                   child: Text(
        //                     value.toString(),
        //                     style: const TextStyle(
        //                       fontSize: 30,
        //                       fontFamily: 'Helvetica',
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             )),
        //       ],
        //     );
        //   },
        // ),


        // // /// Lap time.
        // // Padding(
        // //   padding: const EdgeInsets.symmetric(vertical: 8),
        // //   child: SizedBox(
        // //     height: 100,
        // //     child: StreamBuilder<List<StopWatchRecord>>(
        // //       stream: _stopWatchTimer.records,
        // //       initialData: _stopWatchTimer.records.value,
        // //       builder: (context, snap) {
        // //         final value = snap.data!;
        // //         if (value.isEmpty) {
        // //           return const SizedBox.shrink();
        // //         }
        // //         Future.delayed(const Duration(milliseconds: 100), () {
        // //           _scrollController.animateTo(
        // //               _scrollController.position.maxScrollExtent,
        // //               duration: const Duration(milliseconds: 200),
        // //               curve: Curves.easeOut);
        // //         });
        // //         print('Listen records. $value');
        // //         return ListView.builder(
        // //           controller: _scrollController,
        // //           scrollDirection: Axis.vertical,
        // //           itemBuilder: (BuildContext context, int index) {
        // //             final data = value[index];
        // //             return Column(
        // //               children: <Widget>[
        // //                 Padding(
        // //                   padding: const EdgeInsets.all(8),
        // //                   child: Text(
        // //                     '${index + 1} ${data.displayTime}',
        // //                     style: const TextStyle(
        // //                         fontSize: 17,
        // //                         fontFamily: 'Helvetica',
        // //                         fontWeight: FontWeight.bold),
        // //                   ),
        // //                 ),
        // //                 const Divider(
        // //                   height: 1,
        // //                 )
        // //               ],
        // //             );
        // //           },
        // //           itemCount: value.length,
        // //         );
        // //       },
        // //     ),
        // //   ),
        // // ),

        /// Button
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     // Padding(
        //     //   padding: const EdgeInsets.symmetric(horizontal: 4),
        //     //   child: ElevatedButton(
        //     //     //color: Colors.lightBlue,
        //     //     onPressed: TimerModel.stopWatchTimer.onStartTimer,
        //     //     child: const Text(
        //     //       'Start',
        //     //       style: TextStyle(color: Colors.white),
        //     //     ),
        //     //   ),
        //     // ),
        //     // Padding(
        //     //   padding: const EdgeInsets.symmetric(horizontal: 4),
        //     //   child: ElevatedButton(
        //     //     //color: Colors.green,
        //     //     onPressed: TimerModel.stopWatchTimer.onStopTimer,
        //     //     //onPressed:TimerModel.stopStopWatch(),
        //     //     child: const Text(
        //     //       'Stop',
        //     //       style: TextStyle(color: Colors.white),
        //     //     ),
        //     //   ),
        //     // ),
        //     // Padding(
        //     //   padding: const EdgeInsets.symmetric(horizontal: 4),
        //     //   child: ElevatedButton(
        //     //     //color: Colors.red,
        //     //     onPressed: TimerModel.stopWatchTimer.onResetTimer,
        //     //     child: const Text(
        //     //       'Reset',
        //     //       style: TextStyle(color: Colors.white),
        //     //     ),
        //     //   ),
        //     // ),
        //   ],
        // ),
        // //
        // // Padding(
        // //   padding: const EdgeInsets.symmetric(horizontal: 4),
        // //   child: Row(
        // //     mainAxisAlignment: MainAxisAlignment.center,
        // //     children: <Widget>[
        //       Padding(
        //         padding: const EdgeInsets.all(0).copyWith(right: 8),
        //         child:ElevatedButton(
        //         //  color: Colors.deepPurpleAccent,
        //           onPressed: _stopWatchTimer.onAddLap,
        //           child: const Text(
        //             'Lap',
        //             style: TextStyle(color: Colors.white),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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