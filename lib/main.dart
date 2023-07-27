import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:provider/provider.dart';
import 'package:timeclock/Pages/homePage.dart';
import 'package:timeclock/provider/providers.dart';
import 'package:timeclock/provider/stopwatchModel.dart';
import 'package:timeclock/provider/stopwatch_model.dart';
import 'Pages/introduction_page.dart';
import 'Pages/splash_screen.dart';

void main() {
  print("mainが実行");
  // //AdMobの初期化処理
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerProvider>(
          //プロバイダー名
          create: (context) => TimerProvider(), //プロバイダー名
        ),
        ChangeNotifierProvider<StopWatchModel>(
          //プロバイダー名
          create: (context) => StopWatchModel(), //プロバイダー名
        ),
        ChangeNotifierProvider<StopWatchTimerModel>(
          //プロバイダー名
          create: (context) => StopWatchTimerModel(), //プロバイダー名
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    return ScreenUtilInit(

        //デザインで使用しているデバイス画面の大きさ(単位：dp)を設定する
        designSize: const Size(428, 926),
        minTextAdapt: true, //幅と高さの最小値に応じてテキストサイズを可変させるか
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // localeに英語と日本語を登録する
            supportedLocales: const [
              const Locale("en"),
              const Locale("ja"),
            ],
            // アプリのlocaleを日本語に変更する
            locale: const Locale('ja', 'JP'),

            theme: ThemeData(
                //primarySwatch: Colors.blue,
                primaryColor: const Color(0xffeee3d0),
                scaffoldBackgroundColor: const Color(0xffFFFEF6)),
            routes: <String, WidgetBuilder>{
              '/home': (context) => HomePage(),
              '/splash_screen': (context) => AnimatedSplashScreen(),
              '/IntroduceApp': (context) => IntroductionPage(),
            },
            initialRoute: '/splash_screen',
            home: const HomePage(),
          );
        });
  }
}
