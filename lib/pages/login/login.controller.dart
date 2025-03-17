import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginController extends BaseViewModel {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void init() {}

  void login(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return; // Stop execution if form is invalid
    }

    isLoading = true;
    notifyListeners(); // Update UI

    // Simulate API call (replace with actual login logic)
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners(); // Update UI

    // Navigate to home screen or show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login Successful!')),
    );

    // Example: Navigate to another screen (uncomment if needed)
    // Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
