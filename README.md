
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

#### GetLink

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `brand` | `string` | **Required**. Brand name for the page |
| `productId` | `string` | **Required**. Prouct ID for the page |
| `retailerDomain` | `string` | **Required**. Domain of the retailer of the page |
| `templateType` | `string` | **Required**. Template type of the page |
| `resultType` | `Stream24ResultType` | Result type of the page. One of `.json`, `.html` or `.iframe`. Defaults to `.html`|
| `contentType` | `Stream24ContentType` | Content type of the page. One of `.shopInShops` or `.minisite`. Defaults to `.minisite`|

## Example

Example of usage with

```dart
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
          brand: 'Samsung',
          productId: '16651081549',
          retailerDomain: 'irshad.az',
          templateType: 'master_template',
          resultType: Stream24ResultType.html,
          contentType: Stream24ContentType.shopInShops));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: controller,
    );
  }
}

```