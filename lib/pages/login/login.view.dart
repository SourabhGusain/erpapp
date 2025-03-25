import 'package:flutter/material.dart';
import 'package:erpapp/pages/login/login.controller.dart';
// import 'package:erpapp/pages/updatepassword/updatepassword.view.dart';
import 'package:stacked/stacked.dart';
// import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/widgets/form.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/session.dart';

class LoginPage extends StatelessWidget {
  final Session session;
  LoginPage({super.key, required this.session});

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
                        const SizedBox(height: 30),
                        Image.asset('assets/img/login-img.png', height: 220),
                        const SizedBox(height: 30),
                        textH1('Welcome Back!',
                            font_size: 24, color: Colors.blueGrey[900]!),
                        subtext('Login to continue',
                            font_size: 16, color: Colors.grey[600]!),
                        const SizedBox(height: 40),
                        SizedBox(
                          child: textField(
                            'Mobile',
                            controller: ctrl.mobileController,
                            validator: mobileValidator,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          child: textField('Password',
                              controller: ctrl.passwordController,
                              isPassword: true,
                              validator: passwordValidator),
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: GestureDetector(
                        //     onTap: () =>
                        //         Get.to(context, () => ForgotPasswordPage()),
                        //     child: linkText('Forgot Password?',
                        //         font_size: 14,
                        //         font_weight: FontWeight.w600,
                        //         text_border: TextDecoration.none),
                        //   ),
                        // ),
                        const SizedBox(height: 50),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: darkButton(
                            ctrl.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : buttonText('Log In', color: whiteColor),
                            onPressed: () => ctrl.login(context),
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
