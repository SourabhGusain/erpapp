import 'package:flutter/material.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:erpapp/pages/login/login.view.dart';
import 'package:erpapp/widgets/form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Session session = Session();
  String? key = await session.getSession("loggedInUserKey");
  bool isLoggedIn = false;
  if (key != null && key != "") {
    isLoggedIn = true;
    // FireBaseHelper.saveToken();
  }
  LoggedInUserActivity.set(isLoggedIn);
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
          primarySwatch: Colors.orange, scaffoldBackgroundColor: Colors.white),
      home: const LoginPage(),
    );
  }
}
