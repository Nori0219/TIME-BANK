import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../provider/providers.dart';
import '../provider/stopwatch_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlideCountdownWidget extends StatefulWidget {
  const SlideCountdownWidget({Key? key}) : super(key: key);
  
  @override
  State<SlideCountdownWidget> createState() => _SlideCountdownWidgetState();
}

class _SlideCountdownWidgetState extends State<SlideCountdownWidget> {
  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) {
      final displayTime = StopWatchTimer.getDisplayTime(value);
      print('displayTime $displayTime');
    },
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await stopWatchTimer.dispose();  // Need to call dispose function.
  }
  @override
  Widget build(BuildContext context) {

    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  stateDate = Provider.of<TimerProvider>(context);
    final  model = Provider.of<StopWatchModel>(context);

    return Column(
      children: [
        Container(
          //width: 200,
          padding: EdgeInsets.all(8.0.r),
          margin: EdgeInsets.only(left:30.w,right:30.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.h)),
          color: Color(0xfff0ceb5),
          ),
          child: Text(
            
            model.stopWatchTimeDisplay,//タイマーの時間
            style: TextStyle(fontSize: 45.sp,fontWeight: FontWeight.bold,color: Color(0xffFFFEF6)),
          ),
        ),
      ],
    );
  }
}