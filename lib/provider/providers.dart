import 'dart:math';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier{
  bool isSavingTime = true;
  bool isSpendTime = false;
  bool isSetting = false;
  bool isStartSepedingTimer = false;

  void checkSaving() {
    isSavingTime =! isSavingTime;
    print('isSavingTime :$isSavingTime');
    notifyListeners();
  }

  void checkSpending() {
    isSpendTime =! isSpendTime;
    print('isSpendTime :$isSpendTime');
    notifyListeners();
  }

  void checkSetting() {
    isSetting =! isSetting;
    notifyListeners();
  }

  void setSpendingTimer() {
    isStartSepedingTimer =! isStartSepedingTimer;
    notifyListeners();
  }

}
