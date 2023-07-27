import 'package:example/letual_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stream24_flutter/stream24_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({
    super.key,
    required this.brand,
    required this.productId,
    required this.retailerDomain,
    required this.templateType,
    this.language = 'ru_ru',
    this.throwError = true,
    this.resultType = Stream24ResultType.html,
    this.contentType = Stream24ContentType.minisite,
  });
  String brand;
  String productId;
  String retailerDomain;
  String templateType;
  String language;
  bool throwError;
  Stream24ResultType resultType;
  Stream24ContentType contentType;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  double height = 120;

  @override
  void initState() {
    super.initState();
    final html = Stream24.getHtml(
        brand: widget.brand,
        productId: widget.productId,
        retailerDomain: widget.retailerDomain,
        templateType: widget.templateType,
        resultType: widget.resultType,
        contentType: widget.contentType,
        language: widget.language,
        throwError: widget.throwError);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..addJavaScriptChannel("MobileWebview",
      ..addJavaScriptChannel("FlutterWebview",
          onMessageReceived: (JavaScriptMessage msg) {
        double? y = double.tryParse(msg.message);
        setState(() {
          height = y ?? 0;
        });
      })
      ..addJavaScriptChannel("MobileError",
          onMessageReceived: (JavaScriptMessage msg) {
        print(msg.message);
        _showMyDialog(msg.message);
        // throw Exception(msg.message);
      })
      ..loadHtmlString(html);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: LetualDemo(
        contentWidget: SizedBox(
          height: height,
          child: WebViewWidget(
            controller: controller,
          ),
        ),
      )),
    );
  }

  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
