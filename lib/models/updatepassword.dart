// import 'dart:async';
// import 'dart:convert';
// import 'package:erpapp/helpers/api.dart';
// import 'package:erpapp/helpers/values.dart';

// class UpdatePasswordModel extends Api {
//   final String mobile;
//   final String newPassword;

//   UpdatePasswordModel({required this.mobile, required this.newPassword});

//   Map<String, dynamic> toJson() => {
//         "mobile": mobile,
//         "new_password": newPassword,
//       };

//   Future<Map<String, dynamic>> updatePassword() async {
//     Map<String, dynamic> result = {
//       "ok": 0,
//       "data": null,
//       "message": "",
//       "error": "Unknown error",
//     };

//     try {
//       final String url = "$api_url/partners/update-password/";
//       print("Request URL: $url");
//       print("Request Body: ${jsonEncode(toJson())}");

//       var response = await postCalling(url, toJson());
//       print("Raw Response: $response");

//       if (response is Map<String, dynamic>) {
//         result = response;
//         print("Parsed Response: $result");
//       } else {
//         throw Exception("Unexpected response format");
//       }
//     } catch (error, stackTrace) {
//       result["error"] = "Something went wrong: $error";
//       print("Exception: $error\nStackTrace: $stackTrace");
//     }

//     return result;
//   }
// }
