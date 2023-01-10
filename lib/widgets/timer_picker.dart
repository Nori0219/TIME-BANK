
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeclock/provider/stopwatchModel.dart';

import '../provider/providers.dart';
import '../utils/time_picker_utils.dart';
import 'button_widget.dart';

class TimerPickerPage extends StatefulWidget {
  @override
  _TimerPickerPageState createState() => _TimerPickerPageState();
}

class _TimerPickerPageState extends State<TimerPickerPage> {

  
    
  Duration duration = Duration(hours: 0, minutes: 3, seconds: 0);

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  formatSelectSeconds(Duration duration) {
    int SelectSeconds = duration.inSeconds.remainder(60) + duration.inMinutes.remainder(60)* 60 + duration.inHours * 3600; 
    return SelectSeconds;
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  TimerModel = Provider.of<StopWatchTimerModel>(context);
    final  stateDate = Provider.of<TimerProvider>(context);
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                onClicked: () => Utils.showSheet(
                  context,
                  child: buildTimePicker(),
                  onClicked: () {
                    final value = formatDuration(duration);
                    final SelectSeconds = formatSelectSeconds(duration);
                    TimerModel.spendTime = SelectSeconds;//pickerで選んだ時間でタイマーをセットする
                    print('Set spendTime : spendTime = ${TimerModel.spendTime}');
                    stateDate.setTimerDuration();// hasTimerDuration != hasTimerDuration
                    Utils.showSnackBar(context, 'Select "$value" "$SelectSeconds"');
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
      );
  }

  Widget buildTimePicker() => SizedBox(
        height: 180,
        child: CupertinoTimerPicker(
          initialTimerDuration: duration,
          mode: CupertinoTimerPickerMode.hms,
          minuteInterval: 3,
          secondInterval: 1,
          onTimerDurationChanged: (duration) =>
              setState(() => this.duration = duration),
        ),
      );
}
