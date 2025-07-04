import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:erpapp/helpers/widgets.dart';
import 'package:erpapp/pages/home/home.view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:erpapp/pages/home/home.controller.dart';
import 'package:secure_application/secure_application.dart';

// import 'package:erpapp/models/manage.model.dart';

class ManagePage extends StatefulWidget {
  final Session session;

  const ManagePage({super.key, required this.session});

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  int selectedIndex = 1;
  // final String url = 'https://corrtechsolutions.in/admin/';
  final String url = 'https://corrtechsolutions.in/custom-login/';

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    // _setCookieAndLoad();
  }

  // Future<void> _setCookieAndLoad() async {
  //   final cookieManager = WebViewCookieManager();

  //   await cookieManager.setCookie(
  //     WebViewCookie(
  //       name: 'sessionid',
  //       value: widget.session.sessionId,
  //       domain: 'corrtechsolutions.in',
  //       path: '/',
  //     ),
  //   );

  //   await _controller.loadRequest(Uri.parse(url));
  // }

  @override
  Widget build(BuildContext context) {
    final SecureApplicationController secureController =
        SecureApplicationController(SecureApplicationState());

    return SecureApplication(
      child: SecureApplicationProvider(
        child: ViewModelBuilder<HomeController>.reactive(
          viewModelBuilder: () => HomeController(),
          onViewModelReady: (controller) {
            controller.init();
            secureController.unlock();
          },
          builder: (context, ctrl, child) {
            return SafeArea(
              child: Scaffold(
                body: WebViewWidget(controller: _controller),
                bottomNavigationBar: bottomBar(
                  selectedIndex,
                  (index) {
                    if (index == selectedIndex) return;
                    switch (index) {
                      case 0:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(session: widget.session),
                          ),
                        );
                        break;
                      case 1:
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ManagePage(session: widget.session),
                          ),
                        );
                        break;
                      default:
                        break;
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
