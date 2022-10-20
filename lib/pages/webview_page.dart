import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../shared/theme.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({required this.url, Key? key}) : super(key: key);

  final String url;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: kPrimaryColor,
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_left,
                      size: 24,
                      color: kWhiteColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Kembali ke aplikasi',
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.url,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
