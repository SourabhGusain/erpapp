import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SignupController extends BaseViewModel {
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void init() {}

  void signup(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return; // Stop execution if form is invalid
    }

    isLoading = true;
    notifyListeners(); // Update UI

    // Simulate API call (replace with actual signup logic)
    await Future.delayed(const Duration(seconds: 2));

    isLoading = false;
    notifyListeners(); // Update UI

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Signup Successful!')),
    );

    // Navigate to login screen after signup
    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
