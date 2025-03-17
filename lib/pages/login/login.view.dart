import 'package:erpapp/pages/home/home.view.dart';
import 'package:flutter/material.dart';
import 'package:erpapp/pages/login/login.controller.dart';
import 'package:erpapp/pages/updatepassword/updatepassword.view.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/widgets/form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget customTextField({
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
  }) {
    return textField(
      label,
      controller: controller,
      isPassword: isPassword,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginController>.reactive(
      viewModelBuilder: () => LoginController(),
      builder: (context, ctrl, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/login-img.png',
                        height: 220,
                      ),
                      const SizedBox(height: 30),
                      textH1('Welcome Back!',
                          font_size: 24, color: Colors.blueGrey[900]!),
                      const SizedBox(height: 10),
                      subtext('Login to continue',
                          font_size: 16, color: Colors.grey[600]!),
                      const SizedBox(height: 30),
                      customTextField(
                        label: 'Email',
                        icon: Icons.email,
                        controller: TextEditingController(),
                        validator: emailValidator,
                      ),
                      const SizedBox(height: 15),
                      customTextField(
                        label: 'Password',
                        icon: Icons.lock,
                        isPassword: true,
                        controller: TextEditingController(),
                        validator: emptyValidator,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to Forgot Password Page
                            Get.to(context, () => ForgotPasswordPage());
                          },
                          child: linkText('Forgot Password?',
                              font_size: 14,
                              font_weight: FontWeight.w600,
                              text_border: TextDecoration.none),
                        ),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: ResponsiveApp().height * 0.06,
                        width: ResponsiveApp().width * 1,
                        child: darkButton(
                          buttonText('Login', color: whiteColor),
                          onPressed: () {
                            Get.toWithNoBack(context, () => const HomePage());
                          },
                        ),
                      ),
                      const SizedBox(height: 120),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textH2("Don't have an account?"),
                          const SizedBox(width: 10),
                          buttonText('Signup', color: primaryColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      onViewModelReady: (controller) => controller.init(),
    );
  }
}
