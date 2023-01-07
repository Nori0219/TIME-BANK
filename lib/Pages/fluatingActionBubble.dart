import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:timeclock/provider/providers.dart';

class FloatingActionBubbleWidget extends StatefulWidget {
  const FloatingActionBubbleWidget({super.key});

  @override
  State<FloatingActionBubbleWidget> createState() => _FloatingActionBubbleWidgetState();
}

class _FloatingActionBubbleWidgetState extends State<FloatingActionBubbleWidget> with SingleTickerProviderStateMixin{

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState(){
        
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // Provider.of<T>(context) で親Widgetからデータを受け取る
    final  stateDate = Provider.of<TimerProvider>(context);

    return FloatingActionBubble(
        items: <Bubble>[

          // Floating action menu item
          Bubble(
            title:"設定",
            iconColor :Colors.white,
            bubbleColor : Color(0xff5f8d9a),
            icon:Icons.settings,
            titleStyle:TextStyle(fontSize: 16.sp , color: Colors.white),
            onPress: () {
              _animationController.reverse();
              stateDate.checkSetting();
            },
          ),
          // Floating action menu item
          Bubble(
            title:"使い方",
            iconColor :Colors.white,
            bubbleColor : Color(0xff5f8d9a),
            icon:Icons.help,
            titleStyle:TextStyle(fontSize: 16.sp , color: Colors.white),
            onPress: () {
              _animationController.reverse();
              print('使い方紹介ページへの遷移処理');
            },
          ),
          // Floating action menu item
          Bubble(
            title:"時間を使う",
            iconColor :Colors.white,
            bubbleColor : Color(0xff5f8d9a),
            icon:Icons.generating_tokens,
            titleStyle:TextStyle(fontSize: 16.sp , color: Colors.white),
            onPress: () {
              _animationController.reverse();
              stateDate.checkSpending();
              //stateDate.setSpendingTimer();
            },
          ),
          //Floating action menu item
          Bubble(
            title:"時間を貯める",
            iconColor :Colors.white,
            bubbleColor : Color(0xff5f8d9a),
            icon:Icons.alarm_on,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
             // Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
              _animationController.reverse();
              stateDate.checkSaving();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
              ? _animationController.reverse()
              : _animationController.forward(),
        
        // Floating Action button Icon color
        iconColor: Color(0xffFFFEF6),

        // Flaoting Action button Icon 
        // iconData: Icons.manage_history, 
        iconData: Icons.menu_open, 
        backGroundColor: Color(0xff5f8d9a),
        
      );
  }
}