import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordController extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void resetPassword(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    setBusy(true);
    isLoading = true;
    notifyListeners();

    // Simulating API call delay (replace with real API or Firebase call)
    Future.delayed(const Duration(seconds: 2), () {
      isLoading = false;
      setBusy(false);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset link sent to your email!")),
      );

      // Optionally navigate back to login screen
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
