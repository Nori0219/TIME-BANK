import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchTimerModel extends ChangeNotifier {
  final isHours = true;
  bool isTimerWorking = false;
  int spendTime = 30; //タイマーで使う時間
  int elapsedSeconds = 0;

  StopWatchTimerModel() {
    init();
  }
  void init() {
    setElapsedSeconds();
    notifyListeners();
  }

  //sharedPreferencesから読み込みPresetSecondTimeを実行する
  void setElapsedSeconds() async {
    final pref = await SharedPreferences.getInstance();
    final elapsedSeconds = pref.getInt('elapsedSeconds') ?? 0;
    print('sharedPreferencesから読み込みelapsedSeconds=$elapsedSeconds');

    stopWatchTimer.setPresetSecondTime(elapsedSeconds);

    print('setPresetSecondTime elapsedSeconds = $elapsedSeconds');

    notifyListeners();
  }

  void changeTimerMode() {
    this.isTimerWorking = !isTimerWorking;
    print('changeTimerMode isTimerWorking=$isTimerWorking');
    notifyListeners();
  }

  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    //onChange: (value) => print('onChange $value'),
    //onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    //onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStop');
      //stopした時の処理
    },
    onEnded: () {
      print('onEnded');
    },
  );

  final _scrollController = ScrollController();
  //final elapsedSeconds = 0;

  void recordElapsedSeconds() async {
    elapsedSeconds = stopWatchTimer.secondTime.value;
    print('elapsedSeconds = $elapsedSeconds');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「stopWatch」がキー名。
    prefs.setInt('elapsedSeconds', elapsedSeconds);
    print('sharedPreferencesに記録elapsedSeconds=$elapsedSeconds');
    notifyListeners();
  }

  void subtractElapsedSeconds() async {
    //spendTimeを引く
    elapsedSeconds = stopWatchTimer.secondTime.value - spendTime;
    print('elapsedSecondsから$spendTime秒引く = $elapsedSeconds');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「stopWatch」がキー名。
    prefs.setInt('elapsedSeconds', elapsedSeconds);
    print('sharedPreferencesに記録elapsedSeconds=$elapsedSeconds');

    stopWatchTimer.clearPresetTime();
    stopWatchTimer.setPresetSecondTime(elapsedSeconds);
    notifyListeners();
  }

  // Shared Preferenceのデータを削除する
  removePrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('elapsedSeconds');
    print('sharedPreferencesから削除elapsedSeconds=$elapsedSeconds');
    stopWatchTimer.clearPresetTime();
    notifyListeners();
  }

  // StopWatchTimerModel() {
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
}
