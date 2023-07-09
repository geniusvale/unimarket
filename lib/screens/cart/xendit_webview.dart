import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class XenditWebview extends StatelessWidget {
  String url;
  XenditWebview({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {
                print('APAAAA INIII $url');
              },
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                if (request.url
                    .startsWith('https://checkout-staging.xendit.co/')) {
                  return NavigationDecision.navigate;
                }
                return NavigationDecision.prevent;
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
              },
            ),
          )
          ..loadRequest(Uri.parse(url)),
      ),
    );
  }
}
