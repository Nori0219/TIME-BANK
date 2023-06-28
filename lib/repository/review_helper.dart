import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewHelper {
  static const int reviewRequestLimit = 3; //１年間に3回までしかレビュー依頼できない
  static const String reviewRequestKey = 'ReviewRequestCount';

  static Future<void> showReviewDialog(BuildContext context) async {
    final reviewRequestCount = await getReviewRequestCount();

    if (reviewRequestCount >= reviewRequestLimit) {
      // 制限に達している場合の処理
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: const Text(
            'ご利用ありがとうございます！',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(color: Colors.pink, fontSize: 18.sp),
          content: const Text(
            'アプリを気に入っていただけましたか？レビューでの応援が何よりの励みになります！',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              child: const Text('応援する'),
              onPressed: () {
                Navigator.of(context).pop();
                requestAppReview();
              },
            ),
            TextButton(
              child: const Text(
                '応援しない',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

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
