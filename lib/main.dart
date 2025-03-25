import 'package:flutter/material.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:erpapp/pages/login/login.view.dart';
import 'package:erpapp/pages/home/home.view.dart';
import 'package:erpapp/widgets/form.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<bool> _isLoggedIn;
  final Session session = Session();

  @override
  void initState() {
    super.initState();
    _isLoggedIn = _checkLoginStatus();
  }

  Future<bool> _checkLoginStatus() async {
    String? key = await session.getSession("loggedInUserKey");
    return key != null && key.isNotEmpty;
  }

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
      home: FutureBuilder<bool>(
        future: _isLoggedIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text("Error loading session")),
            );
          } else {
            return snapshot.data == true
                ? HomePage(session: session)
                : LoginPage(session: session);
          }
        },
      ),
    );
  }
}
