import 'dart:async';
import 'dart:io';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

//このメソッドを実行するとエラーが出る　 ERROLER: Unhandled Exception: MissingPluginException(No implementation found for method play on channel flutter_ringtone_player)

class Alarm {
  late Timer _alarmTimer;

  // /// アラームをスタートする
  // void start() {
  //   if (Platform.isAndroid) {
  //     FlutterRingtonePlayer.playAlarm();
  //   } else if (Platform.isIOS) {
  //     FlutterRingtonePlayer.playAlarm();
  //     _alarmTimer = Timer.periodic(
  //       Duration(seconds: 4),
  //       (Timer timer) {
  //         FlutterRingtonePlayer.playAlarm();
  //       },
  //     );
  //   }
  // }

  // /// アラームをストップする
  // void stop() {
  //   if (Platform.isAndroid) {
  //     FlutterRingtonePlayer.stop();
  //   } else if (Platform.isIOS) {
  //     if (_alarmTimer != null && _alarmTimer.isActive) {
  //       _alarmTimer.cancel();
  //     }
  //   }
  //   print("alarm stopped.");
  // }
}
