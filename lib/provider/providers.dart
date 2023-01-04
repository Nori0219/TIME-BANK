import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier{
  bool isSavingTime = true;
  bool isSpendTime = false;
  bool isSetting = false;


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



}
