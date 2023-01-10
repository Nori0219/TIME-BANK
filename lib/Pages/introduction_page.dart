import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';


class IntroductionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          // when user select SKIP
          Navigator.pop(context);
        },
        finishCallback: () {
          // when user select NEXT
          Navigator.pop(context);
        },
      ),
    );
  }

  final pages = [
    PageModel.withChild(
        child: Container(
          //color: Colors.blue,
          width: 0.85.sw,
          child: Padding(
              padding: EdgeInsets.only(bottom: 25.0,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height:250,
                    child: Image.asset('assets/image/Waiting_Monochromatic (1).png'),
                  ),
                  SizedBox(height: 70.h,),
                  Text(
                    "Time is money",
                    style: TextStyle(
                      color: const Color(0xFF95f8d9a),
                      fontSize: 32,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500
                    ),            
                  ),
                  SizedBox(height: 16.h,),
                  Text(
                    "1748年 \nアメリカの政治家\nベンジャミン・フランクリン",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF95f8d9a),
                      fontSize: 20,
                    ),            
                  ),
                ],
              )),
        ),
        color: const Color(0xFFeee3d0),
        //color: const Color(0xFFfac172),
        doAnimateChild: true),
    PageModel(
        color: const Color(0xFF95f8d9a),
        imageAssetPath: 'assets/image/Time_Two Color.png',
        title: '「時間を可視化」',
        body: '毎日の生活で、「時間が足りない」\n「やることがたくさんある」\nと感じることはありませんか？\nこのアプリを使うことで時間を可視化し、有効的に使うことができます。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFFc3c8b0),
        imageAssetPath: 'assets/image/Money transfer _Two Color.png',
        title: '「時間を貯める」',
        body: 'このアプリでは時間の記録ができます。\n記録する時間は何でも構いません。\n例えば、仕事、勉強、バイト、普段の生活で集中している時間など自由に決めてください。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFFf0ceb5),
        imageAssetPath: 'assets/image/Wallet_TwoColor.png',
        title: '「時間を費う」',
        body: '貯めた時間を息抜きに使おう。\n使う時間を設定し、過剰な息抜きを防ぎましょう。ただし、費やした時間は記録から差し引かれ、使い過ぎると「時間貯金」がマイナスになってしまいます。',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              "さあ、始めましょう",
              style: TextStyle(
                color: const Color(0xFF95f8d9a),
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
            )),
        color: const Color(0xFFfac172),
        
        doAnimateChild: true)
  ];
}