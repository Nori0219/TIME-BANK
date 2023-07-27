import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//プラットホームごとのテスト広告IDを取得するメソッド
String getTestAdBannerUnitId() {
  String testBannerUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき
    testBannerUnitId = "ca-app-pub-3940256099942544/6300978111";
  } else if (Platform.isIOS) {
    // iOSのとき
    testBannerUnitId = "ca-app-pub-3940256099942544/2934735716";
  }
  return testBannerUnitId;
}

String getTestAdInterstitialUnitId() {
  String testInterstitialUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき
    testInterstitialUnitId = "ca-app-pub-3940256099942544/1033173712";
  } else if (Platform.isIOS) {
    // iOSのとき
    testInterstitialUnitId = "ca-app-pub-3940256099942544/4411468910";
  }
  return testInterstitialUnitId;
}

//プラットホームごとの広告IDを取得するメソッド
String getAdBannerUnitId() {
  String bannerUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき　*現在はiOSのもの要変更
    bannerUnitId = "ca-app-pub-2758102039369928/4263697263";
  } else if (Platform.isIOS) {
    // iOSのとき
    bannerUnitId = "ca-app-pub-2758102039369928/4263697263";
  }
  return bannerUnitId;
}

String getAdInterstitialUnitId() {
  String interstitialUnitId = "";
  if (Platform.isAndroid) {
    // Android のとき　*現在はiOSのもの要変更
    interstitialUnitId = "ca-app-pub-2758102039369928/4149048556";
  } else if (Platform.isIOS) {
    // iOSのとき
    interstitialUnitId = "ca-app-pub-2758102039369928/4149048556";
  }
  return interstitialUnitId;
}

class AdmobHelper {
  //初期化処理
  static initialization() {
    //if (MobileAds.instance == null) {
    MobileAds.instance.initialize();
    print(" MobileAds.instance.initialize():初期化しました");
    //}
    //print("初期化処理は行われませんでした");
  }

  //バナー広告を初期化する処理
  static BannerAd getBannerAd() {
    BannerAd bAd = BannerAd(
      adUnitId: getTestAdBannerUnitId(),
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdClosed: (Ad ad) {
          print('ad dispose.');
          ad.dispose();
        },
      ),
    );
    return bAd;
  }
}
