import 'package:flutter/material.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:erpapp/pages/home/home.view.dart';
import 'package:erpapp/pages/login/login.view.dart';
import 'package:erpapp/pages/splash.view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveApp.set(context);
    return MaterialApp(
      title: 'Erp App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: SplashScreen(
        session: Session(),
      ),
    );
  }
}
