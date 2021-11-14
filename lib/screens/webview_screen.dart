import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/models.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  static MaterialPage page({String url = 'https://www.raywenderlich.com/'}) {
    return MaterialPage(
      name: FooderlichPages.webviewPath,
      key: ValueKey(FooderlichPages.webviewPath),
      child: WebViewScreen(url: url),
    );
  }

  const WebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
