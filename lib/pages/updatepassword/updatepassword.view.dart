// import 'package:erpapp/helpers/values.dart';
// import 'package:flutter/material.dart';
// import 'package:erpapp/widgets/form.dart';
// import 'package:erpapp/pages/home/home.view.dart';
// import 'package:erpapp/helpers/get.dart';
// import 'package:erpapp/helpers/session.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   const ForgotPasswordPage({super.key});

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final Session session = Session(); // Added session management

//   bool isLoading = false;
//   bool isOtpSent = false;
//   bool isOtpVerified = false;

//   // Function to simulate OTP sending
//   void _sendOtp() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });

//       // Simulate API call to send OTP
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           isOtpSent = true;
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("OTP sent to your mobile!")),
//         );
//       });
//     }
//   }

//   // Function to simulate OTP verification
//   void _verifyOtp() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });

//       // Simulate API call for OTP verification
//       Future.delayed(const Duration(seconds: 2), () {
//         setState(() {
//           isOtpVerified = true;
//           isLoading = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text("OTP verified! You can reset your password.")),
//         );
//       });
//     }
//   }

//   // Function to reset password and maintain session
//   void _resetPassword() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         isLoading = true;
//       });

//       // Simulate API call for password reset
//       Future.delayed(const Duration(seconds: 2), () async {
//         setState(() {
//           isLoading = false;
//         });

//         // Store session after successful password reset
//         await session.setSession("loggedInUserKey", mobileController.text);

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Password successfully reset!")),
//         );

//         // Navigate to HomePage with maintained session
//         Future.delayed(const Duration(seconds: 1), () {
//           Get.toWithNoBack(context, () => HomePage(session: session));
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: blackColor),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'assets/img/login-img.png',
//                   height: 220,
//                 ),
//                 const SizedBox(height: 20),
//                 textH1('Update Password!',
//                     font_size: 24,
//                     color: blackColor,
//                     font_weight: FontWeight.w600),
//                 const SizedBox(height: 5),
//                 subtext("Reset your password here",
//                     font_size: 15,
//                     text_align: TextAlign.center,
//                     color: Colors.grey[600]!),
//                 const SizedBox(height: 20),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       // Mobile Number Input
//                       if (!isOtpSent) ...[
//                         textField(
//                           "Enter Mobile",
//                           controller: mobileController,
//                           keyboardType: TextInputType.phone,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your mobile number';
//                             }
//                             return null;
//                           },
//                           prefixText: "",
//                         ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: ResponsiveApp().height * 0.06,
//                           width: ResponsiveApp().width * 1,
//                           child: darkButton(
//                             buttonText('Send OTP', color: whiteColor),
//                             onPressed: _sendOtp,
//                           ),
//                         ),
//                       ],

//                       // OTP Verification Input
//                       if (isOtpSent && !isOtpVerified) ...[
//                         textField(
//                           "Enter OTP",
//                           controller: otpController,
//                           keyboardType: TextInputType.number,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter OTP';
//                             }
//                             return null;
//                           },
//                           prefixText: "",
//                         ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: ResponsiveApp().height * 0.06,
//                           width: ResponsiveApp().width * 1,
//                           child: darkButton(
//                             buttonText('Verify OTP', color: whiteColor),
//                             onPressed: _verifyOtp,
//                           ),
//                         ),
//                       ],

//                       // Password Reset Inputs
//                       if (isOtpVerified) ...[
//                         textField(
//                           "New Password",
//                           controller: newPasswordController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your new password';
//                             }
//                             return null;
//                           },
//                           prefixText: "",
//                         ),
//                         const SizedBox(height: 20),
//                         textField(
//                           "Confirm Password",
//                           controller: confirmPasswordController,
//                           validator: (value) {
//                             if (value != newPasswordController.text) {
//                               return 'Passwords do not match';
//                             }
//                             return null;
//                           },
//                           prefixText: "",
//                         ),
//                         const SizedBox(height: 20),
//                         SizedBox(
//                           height: ResponsiveApp().height * 0.06,
//                           width: ResponsiveApp().width * 1,
//                           child: darkButton(
//                             buttonText('Reset Password', color: whiteColor),
//                             onPressed: _resetPassword,
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
