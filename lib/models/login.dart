import 'dart:async';
import 'dart:convert';
import 'package:erpapp/helpers/api.dart';
import 'package:erpapp/helpers/values.dart';

class LoginModel extends Api {
  final String mobile;
  final String password;

  LoginModel({required this.mobile, required this.password});

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "password": password,
      };

  Future<Map<String, dynamic>> login() async {
    Map<String, dynamic> result = {
      "ok": 0,
      "data": null,
      "message": "",
      "error": "Unknown error",
    };

    try {
      final String url = "$api_url/partners/login/";
      print("Request URL: $url");
      print("Request Body: ${jsonEncode(toJson())}");

      var response = await postCalling(url, toJson()); // Use URL as a string
      print("Raw Response: $response");

      if (response is Map<String, dynamic>) {
        result = response;
        print("Parsed Response: $result");
      } else {
        throw Exception("Unexpected response format");
      }
    } catch (error, stackTrace) {
      result["error"] = "Something went wrong: $error";
      print("Exception: $error\nStackTrace: $stackTrace");
    }

    return result;
  }
}
