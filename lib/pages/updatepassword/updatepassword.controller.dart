// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:erpapp/models/updatepassword.dart';

// class ForgotPasswordController extends BaseViewModel {
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   final TextEditingController newPasswordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   bool isLoading = false;
//   bool isOtpSent = false;
//   bool isOtpVerified = false;

//   // Simulate sending OTP (replace with actual API)
//   Future<Map<String, dynamic>> sendOtp() async {
//     if (!(formKey.currentState?.validate() ?? false))
//       return {'error': 'Invalid input'};

//     setBusy(true);
//     isLoading = true;
//     notifyListeners();

//     try {
//       final mobile = mobileController.text;

//       final response =
//           await UpdatePasswordModel(mobile: mobile, newPassword: "").sendOtp();

//       if (response['ok'] == 1) {
//         isOtpSent = true;
//       }

//       return response;
//     } catch (error) {
//       return {'error': error.toString()};
//     } finally {
//       setBusy(false);
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Simulate verifying OTP (replace with actual API)
//   Future<Map<String, dynamic>> verifyOtp() async {
//     if (!(formKey.currentState?.validate() ?? false))
//       return {'error': 'Invalid input'};

//     setBusy(true);
//     isLoading = true;
//     notifyListeners();

//     try {
//       final otp = otpController.text;
//       final mobile = mobileController.text;

//       final response =
//           await UpdatePasswordModel(mobile: mobile, newPassword: "")
//               .verifyOtp(otp);

//       if (response['ok'] == 1) {
//         isOtpVerified = true;
//       }

//       return response;
//     } catch (error) {
//       return {'error': error.toString()};
//     } finally {
//       setBusy(false);
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // Handle password reset (replace with actual API)
//   Future<Map<String, dynamic>> resetPassword() async {
//     if (!(formKey.currentState?.validate() ?? false))
//       return {'error': 'Invalid input'};

//     setBusy(true);
//     isLoading = true;
//     notifyListeners();

//     try {
//       final mobile = mobileController.text;
//       final newPassword = newPasswordController.text;

//       final response =
//           await UpdatePasswordModel(mobile: mobile, newPassword: newPassword)
//               .updatePassword();

//       return response;
//     } catch (error) {
//       return {'error': error.toString()};
//     } finally {
//       setBusy(false);
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   @override
//   void dispose() {
//     mobileController.dispose();
//     otpController.dispose();
//     newPasswordController.dispose();
//     confirmPasswordController.dispose();
//     super.dispose();
//   }
// }
