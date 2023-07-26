import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewHelper {
  static const int reviewRequestLimit = 3; //１年間に3回までしかレビュー依頼できない
  static const String reviewRequestKey = 'ReviewRequestCount_20230726';

  static Future<void> showReviewDialog(BuildContext context) async {
    final reviewRequestCount = await getReviewRequestCount();

    if (reviewRequestCount >= reviewRequestLimit) {
      // 制限に達している場合の処理
      return;
    }

    AwesomeDialog(
      context: context,
      dialogType: DialogType.infoReverse,
      animType: AnimType.rightSlide,
      title: 'ご利用ありがとうございます！',
      desc: '週チャレを気に入っていただけましたか？',
      btnCancelText: 'いいえ',
      btnOkText: 'はい',
      btnCancelOnPress: () {
        // いいえで実行
      },
      btnOkOnPress: () {
        // はいで実行
        requestAppReview();
      },
    )..show();

    incrementReviewRequestCount();
  }

  static Future<void> requestAppReview() async {
    final InAppReview inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    } else {
      // レビュー機能が利用できない場合のカスタム処理
    }
  }

  static Future<int> getReviewRequestCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int count = prefs.getInt(reviewRequestKey) ?? 0;
    return count;
  }

  static Future<void> incrementReviewRequestCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int newCount = await getReviewRequestCount() + 1;
    await prefs.setInt(reviewRequestKey, newCount);
  }
}
