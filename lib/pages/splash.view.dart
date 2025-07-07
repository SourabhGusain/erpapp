import 'package:flutter/material.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:erpapp/pages/home/home.view.dart';
import 'package:erpapp/pages/login/login.view.dart';
import 'package:erpapp/widgets/form.dart';

class SplashScreen extends StatefulWidget {
  final Session session;

  const SplashScreen({super.key, required this.session});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 1));

    String? key = await widget.session.getSession("loggedInUserKey");
    print("Session key: $key");

    Widget nextScreen;
    if (key != null && key.isNotEmpty) {
      nextScreen = HomePage(session: widget.session);
    } else {
      nextScreen = LoginPage(session: widget.session);
    }

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => nextScreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logo.png',
                height: 150,
              ),
              // const SizedBox(height: 20),
              // const CircularProgressIndicator(
              //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
