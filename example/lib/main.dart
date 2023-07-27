import 'dart:convert';

import 'package:example/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream24_flutter/stream24_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController retailerDomainController,
      brandController,
      productIdController,
      templateTypeController,
      languageController,
      pageController;
  bool throwError = true;
  Stream24ContentType contentType = Stream24ContentType.shopInShops;
  Stream24ResultType resultType = Stream24ResultType.html;
  List<RichPageTemplate> _templates = [];
  @override
  void initState() {
    super.initState();
    // SharedPreferences.getInstance().then((value) => value.clear());
    retailerDomainController = TextEditingController(text: 'irshad.az');
    brandController = TextEditingController(text: 'Samsung');
    productIdController = TextEditingController(text: '16651081549');
    templateTypeController = TextEditingController(text: 'master_template');
    pageController = TextEditingController(text: 'index.html');
    languageController = TextEditingController(text: 'ru');
    _fetchSavedTemplates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Retailer domain"),
                controller: retailerDomainController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Brand"),
                controller: brandController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Product ID"),
                controller: productIdController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Language"),
                controller: languageController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Template type"),
                controller: templateTypeController,
              ),
              DropdownButton<bool>(
                  value: throwError,
                  items: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text(
                        'Throw error',
                      ),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text(
                        'Don\'t throw error',
                      ),
                    ),
                  ],
                  onChanged: (_throwError) {
                    setState(() {
                      throwError = _throwError!;
                    });
                  }),
              DropdownButton<Stream24ContentType>(
                  value: contentType,
                  items: const [
                    DropdownMenuItem(
                      value: Stream24ContentType.shopInShops,
                      child: Text(
                        'Shop in shops',
                      ),
                    ),
                    DropdownMenuItem(
                      value: Stream24ContentType.minisite,
                      child: Text(
                        'Minisite',
                      ),
                    ),
                  ],
                  onChanged: (type) {
                    setState(() {
                      contentType = type!;
                    });
                  }),
              DropdownButton<Stream24ResultType>(
                  value: resultType,
                  items: const [
                    DropdownMenuItem(
                      value: Stream24ResultType.html,
                      child: Text(
                        'html',
                      ),
                    ),
                    DropdownMenuItem(
                      value: Stream24ResultType.json,
                      child: Text(
                        'json',
                      ),
                    ),
                    DropdownMenuItem(
                      value: Stream24ResultType.iframe,
                      child: Text(
                        'iframe',
                      ),
                    ),
                  ],
                  onChanged: (type) {
                    setState(() {
                      resultType = type!;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () async {
                        saveTemplate(RichPageTemplate(
                            brand: brandController.value.text,
                            retailerDomain: retailerDomainController.value.text,
                            productId: productIdController.value.text,
                            templateType: templateTypeController.value.text,
                            language: languageController.value.text,
                            page: pageController.value.text,
                            throwError: throwError,
                            contentType: contentType,
                            resultType: resultType));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.save_rounded),
                          const Text("Save template"),
                        ],
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.green)),
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => WebViewPage(
                              brand: brandController.value.text,
                              productId: productIdController.value.text,
                              retailerDomain:
                                  retailerDomainController.value.text,
                              templateType: templateTypeController.value.text,
                              language: languageController.value.text,
                              contentType: contentType,
                              resultType: resultType,
                            ),
                          ),
                        );
                      },
                      child: const Text("Open page"),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll<Color>(Colors.blue)),
                    ),
                  ),
                ],
              ),
              Divider(),
              Text(
                'Saved templates:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              // ListView(
              //   children: _templates.map((element) {
              //     return Container();
              //   }).toList(),
              // )
            ]..addAll(_templates.reversed.map((element) {
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(element.brand),
                      Text(element.retailerDomain),
                      Text(element.productId),
                      Text(element.language),
                      Text(element.templateType),
                      // Text(element.page),
                      Text(element.throwError
                          ? 'Throw error'
                          : "Don't throw error"),
                      Text(element.contentType
                          .toString()
                          .replaceFirst('.', ': ')),
                      Text(element.resultType
                          .toString()
                          .replaceFirst('.', ': ')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () async {
                              removeTemplate(element);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever),
                                const Text("Remove"),
                              ],
                            ),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              useTemplate(element);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.check),
                                const Text("Apply"),
                              ],
                            ),
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        Colors.blue)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList()),
          ),
        ),
      ),
    );
  }

  saveTemplate(RichPageTemplate newTemplate) {
    if (_templates.contains(newTemplate)) {
      return;
    }
    _templates.add(newTemplate);
    setState(() {});
    saveTemplates();
  }

  Future saveTemplates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'templates', _templates.map((e) => e.toJson()).toList());
  }

  Future _fetchSavedTemplates() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var jsonsList =
        prefs.containsKey('templates') ? prefs.getStringList('templates')! : [];
    jsonsList.forEach((jsonString) {
      _templates.add(RichPageTemplate.fromJson(jsonString));
    });
    setState(() {});
  }

  void useTemplate(RichPageTemplate element) {
    setState(() {
      retailerDomainController.text = element.retailerDomain;
      brandController.text = element.brand;
      productIdController.text = element.productId;
      templateTypeController.text = element.templateType;
      pageController.text = element.page;
      languageController.text = element.language;
      throwError = element.throwError;
      contentType = element.contentType;
      resultType = element.resultType;
    });
  }

  void removeTemplate(RichPageTemplate element) {
    if (_templates.remove(element)) {
      setState(() {});
      saveTemplates();
    }
  }
}

class RichPageTemplate {
  String retailerDomain, brand, productId, templateType, language, page;
  bool throwError;
  Stream24ContentType contentType;
  Stream24ResultType resultType;
  RichPageTemplate({
    required this.brand,
    required this.retailerDomain,
    required this.productId,
    required this.templateType,
    required this.language,
    required this.page,
    required this.throwError,
    required this.contentType,
    required this.resultType,
  });
  //""{\"brand\":\"Samsung\",\"retailerDomain\":\"irshad.az\",\"productId\":\"16651081549\",\"templateType\":\"master_template\",\"la…"

  factory RichPageTemplate.fromJson(String jsonMap) {
    print(jsonMap);
    Map<String, dynamic> map = json.decode(jsonMap) as Map<String, dynamic>;
    return RichPageTemplate(
      brand: map['brand']!,
      retailerDomain: map['retailerDomain']!,
      productId: map['productId']!,
      templateType: map['templateType']!,
      language: map['language']!,
      page: map['page']!,
      throwError: map['throwError']! == 'true',
      contentType: _contentTypeMap[map['contentType']!]!,
      resultType: _resultTypeMap[map['resultType']!]!,
    );
  }

  static String _getContentType(Stream24ContentType contentType) {
    switch (contentType) {
      case Stream24ContentType.shopInShops:
        return 'sis';
      case Stream24ContentType.minisite:
        return 'minisite';
    }
  }

  static String _getResultType(Stream24ResultType resultType) {
    switch (resultType) {
      case Stream24ResultType.json:
        return 'json';
      case Stream24ResultType.html:
        return 'html';
      case Stream24ResultType.iframe:
        return 'iframe';
    }
  }

  static final Map<String, Stream24ContentType> _contentTypeMap = {
    'sis': Stream24ContentType.shopInShops,
    'minisite': Stream24ContentType.minisite,
  };
  static final Map<String, Stream24ResultType> _resultTypeMap = {
    'json': Stream24ResultType.json,
    'html': Stream24ResultType.html,
    'iframe': Stream24ResultType.iframe,
  };

  String toJson() {
    return json.encode({
      "brand": brand,
      "retailerDomain": retailerDomain,
      "productId": productId,
      "templateType": templateType,
      "language": language,
      "page": page,
      "throwError": throwError.toString(),
      "contentType": _getContentType(contentType),
      "resultType": _getResultType(resultType),
    });
  }

  @override
  bool operator ==(Object other) {
    if (other is! RichPageTemplate) return false;
    if (other.hashCode != hashCode) return false;
    if (brand != other.brand) return false;
    if (retailerDomain != other.retailerDomain) return false;
    if (productId != other.productId) return false;
    if (language != other.language) return false;
    if (templateType != other.templateType) return false;
    if (page != other.page) return false;
    if (throwError != other.throwError) return false;
    if (contentType != other.contentType) return false;
    if (resultType != other.resultType) return false;

    return true;
  }

  @override
  int get hashCode {
    var result = 1;
    result *= brand.hashCode *
        retailerDomain.hashCode *
        productId.hashCode *
        language.hashCode *
        templateType.hashCode *
        page.hashCode *
        throwError.hashCode *
        contentType.hashCode *
        resultType.hashCode;
    return result;
  }
}
