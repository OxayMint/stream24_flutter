import 'package:flutter/material.dart';
import 'package:stream24_flutter/stream24_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({
    super.key,
    required this.brand,
    required this.productId,
    required this.retailerDomain,
    required this.templateType,
    this.resultType = Stream24ResultType.html,
    this.contentType = Stream24ContentType.minisite,
  });
  String brand;
  String productId;
  String retailerDomain;
  String templateType;
  Stream24ResultType resultType;
  Stream24ContentType contentType;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(Stream24.getHtml(
          brand: widget.brand,
          productId: widget.productId,
          retailerDomain: widget.retailerDomain,
          templateType: widget.templateType,
          resultType: widget.resultType,
          contentType: widget.contentType));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}
