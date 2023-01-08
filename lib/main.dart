import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:timeclock/Pages/homePage.dart';
import 'package:timeclock/provider/providers.dart';
import 'package:timeclock/provider/stopwatch_model.dart';


void main() {
    runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerProvider>( //プロバイダー名
          create: (context) => TimerProvider(),//プロバイダー名
        ),
        ChangeNotifierProvider<StopWatchModel>( //プロバイダー名
          create: (context) => StopWatchModel(),//プロバイダー名
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
    return ScreenUtilInit(
    //デザインで使用しているデバイス画面の大きさ(単位：dp)を設定する
    designSize: const Size(428, 926),
      minTextAdapt: true,//幅と高さの最小値に応じてテキストサイズを可変させるか
      splitScreenMode: true,
      builder: (context , child) {

        return MaterialApp(
          title: 'Flutter Demo',

          localizationsDelegates: [ 
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate, 
          ], 
          // localeに英語と日本語を登録する
          supportedLocales: [ 
            const Locale("en"), 
            const Locale("ja"), 
          ],
          // アプリのlocaleを日本語に変更する 
          locale: Locale('ja', 'JP'), 

          theme: ThemeData(
            //primarySwatch: Colors.blue,
            primaryColor:Color(0xffeee3d0),
            scaffoldBackgroundColor: Color(0xffFFFEF6)
          ),
          //home: const MyHomePage(title: 'Flutter Demo Home Page'),
          //home: const newClock(title: 'Flutter Demo Home Page'),
          //home: ExampleControlDuration(),
          home: HomePage(),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final CountDownController controller = new CountDownController();
  int CurrentTimer = 0;
  String str = '';
  
  void setCurrentTimer () {
    controller.getTime();
    str = controller.getTime();
    print(str);
    //CurrentTimer = int.parse(str);
  }
  bool isReverse = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'TimeBank',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SlideCountdownSeparated(
              duration: const Duration(days: 2),
              countUp: true,
            ),
            NeonCircularTimer(
                      onComplete: () {
                        setCurrentTimer();
                        controller.restart();
                      },
                      width: 240,
                      controller: controller,//カウントダウン タイマーを制御 (開始、一時停止、再開、再起動)
                      duration: 180,//秒単位のカウントダウン期間
                      strokeWidth: 16,
                      textFormat:TextFormat.HH_MM_SS,
                      initialDuration:0,//CurrentTimer,//タイマーの最初の経過時間 (秒)
                      isTimerTextShown: true,
                      isReverse:isReverse,//カウントダウンモード
                      isReverseAnimation:isReverse,
                      autoStart:false,
                      neumorphicEffect: true,//ニューモーフィックボーダーを表示
                      outerStrokeColor: Colors.grey.shade100,//カウントダウン ウィジェットの境界線の色
                      innerFillGradient: LinearGradient(colors: [
                        Colors.greenAccent.shade200,
                        Colors.blueAccent.shade400
                      ]),
                      neonGradient: LinearGradient(colors: [
                        Colors.greenAccent.shade200,
                        Colors.blueAccent.shade400
                      ]),
                      strokeCap: StrokeCap.round,
                      innerFillColor: Color.fromARGB(150, 4, 189, 149),
                      backgroudColor: Colors.grey.shade100,//丸の部分の背景
                      neonColor: Colors.blue.shade900,),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: () {
                                controller.resume();
                              }),
                          IconButton(
                              icon: Icon(Icons.pause),
                              onPressed: () {
                                controller.pause();
                              }),
                          IconButton(
                              icon: Icon(Icons.repeat),
                              onPressed: () {
                                controller.restart();
                              }),
                          IconButton(
                              icon: Icon(Icons.hourglass_bottom),
                              onPressed: () {
                                controller.getTimeInSeconds();
                                print(controller.getTime());
                                str = controller.getTime();
                                isReverse =! isReverse;
                                print('isReverse=$isReverse');
                              }),
                        ]),
                  )
          ],
        ),
      ),
    );
  }
}
