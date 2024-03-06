import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _Maps createState() => _Maps();
}

class _Maps extends State<Maps> {
  final String url =
      'https://www.google.co.in/maps/@19.2251777,72.7674201,14z?entry=ttu';
  late WebViewController _webViewController;

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://www.bing.com/maps/?cp=19.082428%7E72.88595&lvl=11.0'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
