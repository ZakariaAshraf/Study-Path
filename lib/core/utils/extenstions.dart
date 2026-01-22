import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

 Future<void> launchUrls(String url, {bool forceWebView = false}) async {
  log(url);
  if (!await launchUrl(
    Uri.parse(url),
    // mode: LaunchMode.inAppWebView,
    // webViewConfiguration: const WebViewConfiguration(enableDomStorage: false),
  )) {
    throw 'Could not launch $url';
  }
  // await launchUrl(Uri.parse(url),mode: LaunchMode.inAppWebView,webViewConfiguration: WebViewConfiguration()).catchError((e) {
  //   log(e);
  //   toast('Invalid URL: $url');
  // });
}
Future<void> lunchInBrowser(String link) async {
  Uri url = Uri.parse(link);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.inAppWebView);
  } else {
    if (kDebugMode) {
      print("something went wrong");
    }
  }
}