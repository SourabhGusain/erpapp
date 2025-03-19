import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/models/login.dart';
import 'dart:convert';

class LoginController extends BaseViewModel {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void toggleLoading(bool state) {
    isLoading = state;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (!(formKey.currentState?.validate() ?? false)) {
      print("Form validation failed.");
      return;
    }

    toggleLoading(true);
    String mobile = mobileController.text.trim();
    String password = passwordController.text.trim();
    print("User Input: Mobile: $mobile, Password: $password");

    try {
      // Hardcoded credentials for temporary login
      if (mobile == "6398792562" && password == "roax") {
        print("Temporary Login Successful");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );

        // Navigate to Home Page after successful login
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        throw Exception("Invalid credentials. Try 9999999999 / password123");
      }
    } catch (e) {
      print("Login error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      toggleLoading(false);
    }
  }

  // Future<void> login(BuildContext context) async {
  //   if (!(formKey.currentState?.validate() ?? false)) {
  //     print("Form validation failed.");
  //     return;
  //   }

  //   toggleLoading(true);
  //   String mobile = mobileController.text.trim();
  //   String password = passwordController.text.trim();
  //   print("User Input: Mobile: $mobile, Password: $password");

  //   try {
  //     var loginModel = LoginModel(mobile: mobile, password: password);
  //     print("Sending Request: ${jsonEncode(loginModel.toJson())}");
  //     var response = await loginModel.login();
  //     print("API Response: $response");

  //     if (response["ok"] == 1) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Login Successful!')),
  //       );
  //     } else {
  //       throw Exception(response["error"] ?? 'Login failed');
  //     }
  //   } catch (e) {
  //     print("Login error: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error: $e')),
  //     );
  //   } finally {
  //     toggleLoading(false);
  //   }
  // }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
