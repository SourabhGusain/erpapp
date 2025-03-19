import 'package:erpapp/pages/home/home.view.dart';
import 'package:flutter/material.dart';
import 'package:erpapp/pages/login/login.controller.dart';
import 'package:erpapp/pages/updatepassword/updatepassword.view.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/widgets/form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                  child: Form(
                    key: ctrl.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Image.asset('assets/img/login-img.png', height: 220),
                        const SizedBox(height: 30),

                        /// 📌 Welcome Message
                        textH1('Welcome Back!',
                            font_size: 24, color: Colors.blueGrey[900]!),
                        const SizedBox(height: 5),
                        subtext('Login to continue',
                            font_size: 16, color: Colors.grey[600]!),
                        const SizedBox(height: 30),

                        /// 📌 Mobile Input Field
                        textField('Mobile',
                            controller: ctrl.mobileController,
                            validator: mobileValidator),
                        const SizedBox(height: 15),

                        /// 📌 Password Input Field
                        textField('Password',
                            controller: ctrl.passwordController,
                            isPassword: true,
                            validator: passwordValidator),
                        const SizedBox(height: 10),

                        /// 📌 Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () =>
                                Get.to(context, () => ForgotPasswordPage()),
                            child: linkText('Forgot Password?',
                                font_size: 14,
                                font_weight: FontWeight.w600,
                                text_border: TextDecoration.none),
                          ),
                        ),
                        const SizedBox(height: 50),

                        /// 📌 Login Button with Temporary Login
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: darkButton(
                            buttonText('Log In', color: whiteColor),
                            onPressed: () {
                              if (ctrl.formKey.currentState?.validate() ??
                                  false) {
                                /// Temporary login logic (bypasses API call)
                                print("Temporary Login Successful");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Please enter valid details')),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
