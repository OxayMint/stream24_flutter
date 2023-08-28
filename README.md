
# 24Stream Flutter

Flutter плагин для создания виджетов 24Stream Rich Page.

## Установка

Для установки добавьте stream24_flutter в зависимости внутри `pubspec.yaml` вашего проекта.

```yaml
dependencies:
  ...
  stream24: ^0.1.1
...
```

## Использование

#### Stream24RichPage

Webview виджет с рич контентом и автоматической настройкой высоты.


| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `brand` | `string` | **Обязательно**. Название бренда страницы |
| `productId` | `string` | **Обязательно**. Идентификатор продукта страницы |
| `retailerDomain` | `string` | **Обязательно**. Домен ретейлера страницы |
| `templateType` | `string` | **Обязательно**. Тип шаблона страницы |
| `language` | `string` | Языковой код страницы в виде страна_язык. Код страны должен быть указан в стандарте ISO 3166-1, а код языка - в стандарте ISO 639-1. По умолчанию `ru_ru` |
| `onError` | `Function(String)` | Функция, вызываемая при возникновении ошибки. |
| `contentType` | `Stream24ContentType` | Тип содержимого страницы. `.shopInShops` Или `.minisite`. По умолчанию `.minisite`|



#### getHtml

Возвращает HTML код страницы в виде строки.

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `brand` | `string` | **Обязательно**. Название бренда страницы |
| `productId` | `string` | **Обязательно**. Идентификатор продукта страницы |
| `retailerDomain` | `string` | **Обязательно**. Домен ретейлера страницы |
| `templateType` | `string` | **Обязательно**. Тип шаблона страницы |
| `language` | `string` | Языковой код страницы в виде страна_язык. Код страны должен быть указан в стандарте ISO 3166-1, а код языка - в стандарте ISO 639-1. По умолчанию `ru_ru` |
| `contentType` | `Stream24ContentType` | Тип содержимого страницы. `.shopInShops` Или `.minisite`. По умолчанию `.minisite`|


## Примеры использования

`Используя Stream24RichPage`
```dart
import 'package:flutter/material.dart';
import 'package:stream24/stream24.dart';
import 'package:stream24/rich_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  WebViewPage({super.key});
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}
class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return  Stream24RichPage(
            brand: 'Samsung',
            productId: '16651081549',
            retailerDomain: 'irshad.az',
            templateType: 'master_template',
            contentType: Stream24ContentType.shopInShops,
            onError: (errorMsg){ print(errorMsg); }
        );
    }
}

```
ИЛИ 

`Используя getHtml`
```dart
import 'package:flutter/material.dart';
import 'package:stream24/stream24.dart';
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

      // to automatically adjust height add the following block
      ..addJavaScriptChannel("FlutterWebviewHeight",
          onMessageReceived: (JavaScriptMessage msg) {
        setState(() {
          height = double.tryParse(msg.message) ?? 0;
        });
      })
      //////////////////////////////////////////////////////////////////

      //if you want to throw errors on 404 content add the following block
      ..addJavaScriptChannel("FlutterError",
          onMessageReceived: (JavaScriptMessage msg) {
            
        throw Exception(msg.message);
      })
      //////////////////////////////////////////////////////////////////

      ..loadHtmlString(Stream24.getHtml(
          brand: 'Samsung',
          productId: '16651081549',
          retailerDomain: 'irshad.az',
          templateType: 'master_template',
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
