import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/models/login.model.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/pages/home/home.view.dart';
import 'package:erpapp/helpers/session.dart';

class LoginController extends BaseViewModel {
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final Session session = Session();

  final _loginModel = LoginModel(mobile: '', password: '');

  void _toggleLoading(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    _toggleLoading(true);

    try {
      final response = await LoginModel(
        mobile: mobileController.text.trim(),
        password: passwordController.text.trim(),
      ).login();

      if (response["ok"] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );
        Get.toWithNoBack(context, () => HomePage(session: session));
      } else {
        throw Exception(response["message"] ?? "Login failed.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    } finally {
      _toggleLoading(false);
    }
  }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
