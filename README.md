
# 24Stream Flutter

A flutter plugin for generating 24Stream HTML widgets to be used in webview_flutter or any other nested browser.


## Installation

To install add stream24_flutter plugin to your dependencies in your `pubspec.yaml`

```yaml
dependencies:
  ...
  stream24_flutter:
    git:
      url: https://github.com/OxayMint/stream24_flutter.git
      ref: main
...
```
## Usage

#### getHtml

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `brand` | `string` | **Required**. Brand name for the page |
| `productId` | `string` | **Required**. Prouct ID for the page |
| `retailerDomain` | `string` | **Required**. Domain of the retailer of the page |
| `templateType` | `string` | **Required**. Template type of the page |
| `language` | `string` | Language code for the page encoded as country_language. Country code should set according to ISO 3166-1 standard and the language code - to ISO 639-1. Defaults to `ru_ru` |
| `throwError` | `bool` | Whether to throw an error if the content not found. Defaults to `true` |
| `resultType` | `Stream24ResultType` | Result type of the page. One of `.json`, `.html` or `.iframe`. Defaults to `.html`|
| `contentType` | `Stream24ContentType` | Content type of the page. One of `.shopInShops` or `.minisite`. Defaults to `.minisite`|

Returns HTML code of the page.

## Example

Example of usage with webview_flutter

```dart
import 'package:flutter/material.dart';
import 'package:stream24_flutter/stream24_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({super.key});
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
    double height = 120;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
       controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // to automatically adjust height add the following block
      ..addJavaScriptChannel("FlutterWebview",
          onMessageReceived: (JavaScriptMessage msg) {
        double? y = double.tryParse(msg.message);
        setState(() {
          height = y ?? 0;
        });
      })
      //////////////////////////////////////////////////////////////////

      //if you want to throw errors on 404 content add the following block
      ..addJavaScriptChannel("MobileError",
          onMessageReceived: (JavaScriptMessage msg) {
        throw Exception(msg.message);
      })
      //////////////////////////////////////////////////////////////////

      ..loadHtmlString(Stream24.getHtml(
          brand: 'Samsung',
          productId: '16651081549',
          retailerDomain: 'irshad.az',
          templateType: 'master_template',
          resultType: Stream24ResultType.html,
          contentType: Stream24ContentType.shopInShops));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: WebViewWidget(
          controller: controller,
        ),
    );
  }
}

```
