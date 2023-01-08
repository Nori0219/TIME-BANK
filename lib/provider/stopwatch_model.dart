
import 'dart:async';
import 'package:flutter/material.dart';

class StopWatchModel extends ChangeNotifier{

  bool isStopPressed = false;
  bool isResetPressed = false;
  bool isStartPressed = false;
  bool isTimerWorking = false;

  String stopWatchTimeDisplay = '00:00:00';
  var swatch = Stopwatch();
  final dul = const Duration(seconds: 1);

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

  startStopWatch() {
    this.isStopPressed = false;
    this.isTimerWorking = true;
    swatch.start();
    startTimer();
    notifyListeners();
  }


  stopStopWatch() {
    this.isStopPressed = true;
    this.isTimerWorking = false;
    swatch.stop();
    notifyListeners();
  }

  resetStopWatch() {
    this.isResetPressed = true;
    this.isTimerWorking = false;
    swatch.reset();
    stopWatchTimeDisplay = '00:00:00';
    notifyListeners();
  }

}
