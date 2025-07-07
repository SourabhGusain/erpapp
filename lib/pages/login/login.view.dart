import 'package:flutter/material.dart';
import 'package:erpapp/pages/login/login.controller.dart';
import 'package:stacked/stacked.dart';
import 'package:erpapp/widgets/form.dart';
import 'package:erpapp/helpers/values.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  final Session session;
  const LoginPage({super.key, required this.session});

  Future<void> _launchProfile() async {
    const url = 'https://corrtechsolutions.in/profile/';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginController>.reactive(
      viewModelBuilder: () => LoginController(),
      builder: (context, ctrl, child) {
        return SafeArea(
          child: Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 40,
                      ),
                      child: Form(
                        key: ctrl.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/img/login-img.png',
                              height: 200,
                            ),
                            const SizedBox(height: 40),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: textH1(
                                'Welcome Back!',
                                font_size: 26,
                                color: primaryColor,
                              ),
                            ),
                            // const SizedBox(height: ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: subtext(
                                'Your Project & Issue Tracker — employee & partner access.',
                                font_size: 14,
                                font_weight: FontWeight.w400,
                                color: Colors.grey[600]!,
                              ),
                            ),
                            const SizedBox(height: 30),
                            textField(
                              'Enter Mobile',
                              controller: ctrl.mobileController,
                              validator: mobileValidator,
                            ),
                            const SizedBox(height: 5),
                            textField(
                              'Enter Password',
                              controller: ctrl.passwordController,
                              isPassword: true,
                              validator: passwordValidator,
                            ),
                            const SizedBox(height: 70),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: darkButton(
                                ctrl.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : buttonText('Log In', color: whiteColor),
                                onPressed: ctrl.isLoading
                                    ? null
                                    : () => ctrl.login(context),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Column(
                              children: [
                                subtext(
                                  'v1.0.0',
                                  font_size: 12,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: _launchProfile,
                                  child: subtext(
                                    'Visit Our Profile',
                                    font_size: 14,
                                    color: primaryColor,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
