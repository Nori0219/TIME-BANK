import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AnimatedSplashScreen extends StatefulWidget {
  
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

   late AnimationController animationController;
   late Animation<double> animation;

  startTime() async {
    var _duration = new Duration(milliseconds: 1500);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool('isAlreadyFirstLaunch') != true) {
      // 最初の起動ならチュートリアル表示
      print('初回起動です');
      Navigator.of(context).pushReplacementNamed('/IntroduceApp');
      //Navigator.pushNamed(context, '/whatApp');
      await pref.setBool('isAlreadyFirstLaunch', true);
    }else{
      //それ以降の表示
    print('初回起動ではありません');
    Navigator.of(context).pushReplacementNamed('/home');
    }
  }


  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOutQuart);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFeee3d0),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
           
           Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               Image.asset(
                'assets/icon/ アイコンTIMEBANK.png',
                width: animation.value * 200,
                height: animation.value * 200,
              ),
            ],
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[

          //     Padding(padding: EdgeInsets.only(bottom: 30.0),child:new Image.asset('assets/displey_images/banar_透過.png',height: 110,fit: BoxFit.scaleDown,))

          //   ],),
        ],
      ),
    );
  }
}