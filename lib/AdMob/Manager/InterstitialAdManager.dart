import 'dart:async';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class InterstitialAdManager implements InterstitialAdLoadCallback {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;

  void interstitialAd() {
    print("interstitialAd()が呼ばれました");
    InterstitialAd.load(
      adUnitId: Platform.isAndroid
          //テスト用-動画
          // ? 'ca-app-pub-3940256099942544/4411468910'
          // : 'ca-app-pub-3940256099942544/5135589807',

          //本番用 ca-app-pub-2758102039369928/4149048556
          ? 'ca-app-pub-2758102039369928/4149048556' //未取得のためiPhoneと同じ
          : 'ca-app-pub-2758102039369928/4149048556',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('InterstitialAd loaded.');
          _interstitialAd = ad;
          _isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (_isAdLoaded) {
      _interstitialAd?.fullScreenContentCallback;
      _interstitialAd?.show();
      print('Interstitial ad opened.');
      //initState()で実行されない時のために自動でロードできる様にする
      Timer(const Duration(seconds: 15), () {
        print("15s経過：自動でAdをロードします");
        interstitialAd();
      });
    } else {
      print('Interstitial ad is not yet loaded.');
    }
  }

  @override
  // TODO: implement onAdFailedToLoad
  FullScreenAdLoadErrorCallback get onAdFailedToLoad =>
      throw UnimplementedError();

  @override
  // TODO: implement onAdLoaded
  GenericAdEventCallback<InterstitialAd> get onAdLoaded =>
      throw UnimplementedError();
}
