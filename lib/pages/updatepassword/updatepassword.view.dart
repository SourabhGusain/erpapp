import 'package:flutter/material.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/widgets/form.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Password reset link sent to your email!")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: textH1("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/forgot-password.png', // Add an appropriate image
              height: 150,
            ),
            const SizedBox(height: 20),
            textH2(
              "Enter your registered email and we'll send you a reset link.",
              text_align: TextAlign.center,
              color: Colors.black54,
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: textField(
                "Email Address",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
                prefixText: " ",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: darkButton(
                buttonText("Send Reset Link", isLoading: isLoading),
                onPressed: isLoading ? null : _resetPassword,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: linkText("Back to Login"),
            ),
          ],
        ),
      ),
    );
  }
}
