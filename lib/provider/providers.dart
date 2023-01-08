
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';


class TimerProvider extends ChangeNotifier{
  bool isStartSepedingTimer = false;
  int currentPageIndex = 2;
  

  void checkSaving() {
    currentPageIndex = 0;
    print('時間を貯める');
    notifyListeners();
  }

  void checkSpending() {
    currentPageIndex = 1;
    print('時間を使う');
    notifyListeners();
  }

  void checkSetting() {
    currentPageIndex = 2;
    print('設定');
    notifyListeners();
  }

  void setSpendingTimer() {
    print('タイマースタート');
    notifyListeners();
  }

}
