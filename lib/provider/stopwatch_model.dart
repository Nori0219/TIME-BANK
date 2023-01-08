
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StopWatchModel extends ChangeNotifier{

  bool isStopPressed = false;
  bool isResetPressed = false;
  bool isStartPressed = false;
  bool isTimerWorking = false;
  int elapsedSeconds = 0;

  String stopWatchTimeDisplay = '00:00:00';
  var swatch = Stopwatch();
  final dul = const Duration(seconds: 1);
  
  StopWatchModel(){
    _init();
  }
  void _init() async {
    final pref = await SharedPreferences.getInstance();
    final stopWatchTimeDisplay= pref.getString('stopWatch')??'00:00:02';
    final elapsedSeconds = pref.getInt('elapsed_seconds')??0;
    
    print('stopWatchTimeDisplay=$stopWatchTimeDisplay');
    print('elapsedSeconds=$elapsedSeconds');
    notifyListeners();
  }
  

  startTimer(){
    Timer(dul,keepRunning);
  }

  keepRunning(){
    if(swatch.isRunning){
      startTimer();
    }
    this.stopWatchTimeDisplay = swatch.elapsed.inHours.toString().padLeft(2,"0") +':'
        + (swatch.elapsed.inMinutes%60).toString().padLeft(2,"0") +':'
        + (swatch.elapsed.inSeconds%60).toString().padLeft(2,"0") ;
    notifyListeners();
  }

  startStopWatch(){
    this.isStopPressed = false;
    this.isTimerWorking = true;
    if (elapsedSeconds != 0) {
      // 読み込んだ秒数を使用して、Durationクラスのインスタンスを作成する
      final elapsedDuration = Duration(seconds: elapsedSeconds);
      // 作成したDurationクラスのインスタンスを使用して、ストップウォッチを開始する
      //watch.start(elapsedDuration);
    } else {
      // 保存された経過時間がない場合は、ストップウォッチを通常通り開始する
      swatch.start();
    }
    //swatch.start();
    startTimer();
    print('ストップウォッチが実行中かどうか${swatch.isRunning}');
    notifyListeners();
  }


  stopStopWatch() {
    this.isStopPressed = true;
    this.isTimerWorking = false;
    swatch.stop();
    print('ストップウォッチが実行中かどうか${swatch.isRunning}');
    notifyListeners();
  }

  resetStopWatch() {
    this.isResetPressed = true;
    this.isTimerWorking = false;
    swatch.reset();
    stopWatchTimeDisplay = '00:00:00';
    notifyListeners();
  }

  // Shared Preferenceに値を保存されているデータを読み込んで_counterにセットする。
  getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「counter」がキー名。見つからなければ０を返す
    prefs.getString('stopWatch')??'00:00:02';
  }

  // Shared Preferenceにデータを書き込む
  setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // 以下の「stopWatch」がキー名。
    prefs.setString('stopWatch', stopWatchTimeDisplay);
    prefs.setInt('elapsed_seconds', swatch.elapsed.inSeconds);
    print('sharedPreferencesに記録stopWatchTimeDisplay=$stopWatchTimeDisplay');
    print('sharedPreferencesに記録elapsedSeconds=${swatch.elapsed.inSeconds}');
  }
  
  // SharedPreferencesに経過時間を保存する
  Future<void> saveElapsedDuration(Duration duration) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('elapsed_seconds', swatch.elapsed.inSeconds);
  }

  // Shared Preferenceのデータを削除する
  removePrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
