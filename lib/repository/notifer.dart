import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifier {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Notifier() {
    // タイムゾーンを初期化
    tz.initializeTimeZones();
    var tokyo = tz.getLocation('Asia/Tokyo');
    tz.setLocalLocation(tokyo);
  }

  /// ローカル通知をスケジュールする
  void scheduleLocalNotification(int spendSeconds) async {
    // 初期化

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
          android: AndroidInitializationSettings('app_icon'), // app_icon.pngを配置
          iOS: initializationSettingsIOS),
    );

    // スケジュール設定する
    int id = 1;
    flutterLocalNotificationsPlugin.zonedSchedule(
        id, // id
        'TIME BANK', // title
        'タイマー終了🕰️\n設定した時間を費い切りました！', // body
        tz.TZDateTime.now(tz.local).add(Duration(seconds: spendSeconds)), //
        NotificationDetails(
            android: AndroidNotificationDetails(
                'my_channel_id', 'my_channel_name',
                channelDescription: 'my_channel_description',
                importance: Importance.max,
                priority: Priority.high),
            iOS: DarwinNotificationDetails()),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  // スケジュールされたローカル通知をキャンセルする
  // void cancelScheduledLocalNotification(int notificationId) {
  //   if (notificationId == null) return;
  //   flutterLocalNotificationsPlugin.cancel(notificationId);
  // }
}
