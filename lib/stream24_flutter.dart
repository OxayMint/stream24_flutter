library stream24_flutter;

class Stream24 {
  static String getHtml({
    required String brand,
    required String productId,
    required String retailerDomain,
    required String templateType,
    String language = 'ru_ru',
    bool throwError = true,
    Stream24ResultType resultType = Stream24ResultType.html,
    Stream24ContentType contentType = Stream24ContentType.minisite,
  }) {
    return """
  <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <title>24 Stream</title>
    <script async="" src="https://content.24ttl.stream/widget.js"></script>
</head>

<body>
    <div id="wrapper"></div>
    <script>(function (w, d, s, o) { var f = d.getElementsByTagName(s)[0]; var j = d.createElement(s); w.TTLStreamReady = new Promise((resolve) => { j.async = true; j.src = 'https://content.24ttl.stream/widget.js'; f.parentNode.insertBefore(j, f); j.onload = function () { w.ttlStream = new TTLStream(o); resolve(w.ttlStream); }; }); })(window, document, 'script', {}); </script>
    <script>
        const parameters = { "brand": "{{brand}}", "productId": "{{productId}}", "retailerDomain": "{{retailerDomain}}", "language": "{{language}}", "throwError": {{throwError}}, "templateType": "{{templateType}}", "resultType": "{{resultType}}", "contentType": "{{contentType}}", "el": "#wrapper", "windowMode": "self" }
        TTLStreamReady.then(() => { ttlStream.findAndInsert(parameters); }); 
        setTimeout((e) => { FlutterWebview.postMessage(document.documentElement.scrollHeight) }, 3000);
        (function(){ 
        var originalerror = console.error;
        console.error = function(txt) {
              MobileError.postMessage(txt);
        }})();

    </script>
</body>

</html>
"""
        .replaceFirst('{{brand}}', brand)
        .replaceFirst('{{productId}}', productId)
        .replaceFirst('{{retailerDomain}}', retailerDomain)
        .replaceFirst('{{templateType}}', templateType)
        .replaceFirst('{{language}}', language)
        .replaceFirst('{{throwError}}', throwError.toString())
        .replaceFirst('{{resultType}}', _getResultType(resultType))
        .replaceFirst('{{contentType}}', _getContentType(contentType));
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
}

enum Stream24ContentType { shopInShops, minisite }

enum Stream24ResultType { html, json, iframe }
