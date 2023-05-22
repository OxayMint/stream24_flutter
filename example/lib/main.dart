import 'dart:io';

import 'package:example/webview_page.dart';
import 'package:flutter/material.dart';
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
  Stream24ContentType contentType = Stream24ContentType.shopInShops;
  Stream24ResultType resultType = Stream24ResultType.html;

  @override
  void initState() {
    super.initState();
    retailerDomainController = TextEditingController(text: 'irshad.az');
    brandController = TextEditingController(text: 'Samsung');
    productIdController = TextEditingController(text: '16651081549');
    templateTypeController = TextEditingController(text: 'master_template');
    pageController = TextEditingController(text: 'index.html');
    languageController = TextEditingController(text: 'ru');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
              TextButton(
                onPressed: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebViewPage(
                            brand: brandController.value.text,
                            productId: productIdController.value.text,
                            retailerDomain: retailerDomainController.value.text,
                            templateType: templateTypeController.value.text,
                            contentType: contentType,
                            resultType: resultType,
                          )));
                },
                child: const Text("Open page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
