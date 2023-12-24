import 'package:swizzle/consts/consts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.termsandconditionsgenerator.com/live.php?token=6IYZDU6hEissGYUdtHRpAPGRvsitVJP5'));

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
          height: context.screenHeight,
          width: double.infinity,
          child: WebViewWidget(controller: controller)),
    );
  }
}
