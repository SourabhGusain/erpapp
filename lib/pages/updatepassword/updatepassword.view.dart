import 'package:erpapp/helpers/values.dart';
import 'package:flutter/material.dart';
import 'package:erpapp/widgets/form.dart';
import 'package:erpapp/pages/home/home.view.dart';
import 'package:erpapp/helpers/get.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: blackColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/img/login-img.png',
                  height: 220,
                ),
                const SizedBox(height: 20),
                textH1('Update Password!',
                    font_size: 24,
                    color: blackColor,
                    font_weight: FontWeight.w600),
                const SizedBox(height: 5),
                subtext("Reset your password here",
                    font_size: 15,
                    text_align: TextAlign.center,
                    color: Colors.grey[600]!),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: textField(
                    "Enter Mobile",
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                    prefixText: "",
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: ResponsiveApp().height * 0.06,
                  width: ResponsiveApp().width * 1,
                  child: darkButton(
                    buttonText('Verify', color: whiteColor),
                    onPressed: () {
                      Get.toWithNoBack(context, () => const HomePage());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
