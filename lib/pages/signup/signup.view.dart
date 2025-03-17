import 'package:flutter/material.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/get.dart';
import 'package:erpapp/pages/signup/signup.controller.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/widgets/form.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupController>.reactive(
      viewModelBuilder: () => SignupController(),
      builder: (context, ctrl, child) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: ctrl.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/signup-img.png',
                        height: 120,
                      ),
                      const SizedBox(height: 30),
                      textH1('Create an Account', color: Colors.blueGrey[900]!),
                      const SizedBox(height: 30),
                      textField('Full Name',
                          controller: ctrl.nameController,
                          validator: emptyValidator),
                      const SizedBox(height: 15),
                      textField('Email',
                          controller: ctrl.emailController,
                          validator: emailValidator),
                      const SizedBox(height: 15),
                      textField('Password',
                          controller: ctrl.passwordController,
                          isPassword: true, validator: (val) {
                        if (val == null || val.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      }),
                      const SizedBox(height: 15),
                      textField('Confirm Password',
                          controller: ctrl.confirmPasswordController,
                          isPassword: true,
                          validator: (val) =>
                              val != ctrl.passwordController.text
                                  ? 'Passwords do not match'
                                  : null),
                      const SizedBox(height: 20),
                      darkButton(
                        ctrl.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : textH2('Sign Up', color: whiteColor),
                        primary: Colors.green,
                        onPressed: () => ctrl.signup(context),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Login',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
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
