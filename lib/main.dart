import 'package:flutter/material.dart';
import 'package:goindia/helpers/get.dart';
import 'package:goindia/helpers/session.dart';
import 'package:goindia/pages/format/format.view.dart';

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
      title: 'Go India',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.orange, scaffoldBackgroundColor: Colors.white),
      home: const FormatPage(),
    );
  }
}
