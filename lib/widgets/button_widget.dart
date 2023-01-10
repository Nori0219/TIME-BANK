import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => 
      // ElevatedButton(
      //   style: ElevatedButton.styleFrom(minimumSize: Size(100, 42)),
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Icon(Icons.more_time, size: 28),
      //       const SizedBox(width: 8),
      //       Text(
      //         'Show Picker',
      //         style: TextStyle(fontSize: 20),
      //       ),
      //     ],
      //   ),
      //   onPressed: onClicked,
      // );

      AnimatedButton(
        height: 80.h,
        width: 220.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.access_alarm,
                  color: Colors.white,
                  size:32.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'SpendTime',
                  style: TextStyle(
                    fontSize: 26.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          //onPressed: TimerModel.stopWatchTimer.onStopTimer,
          onPressed: onClicked,
          shadowDegree: ShadowDegree.light,
          color: Color(0xffc3c8b0),
          //color: Color(0xff5f8d9a),
          //color: Color(0xffc3c8b0),
          //color: Color(0xfffac172),
          //color: Color(0xfff0ceb5),
      );
}

          