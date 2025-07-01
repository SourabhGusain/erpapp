import 'dart:async';
import 'dart:convert';
import 'package:erpapp/helpers/api.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:erpapp/helpers/values.dart';

class LoginModel extends Api {
  final String mobile;
  final String password;
  final Session session = Session();

  LoginModel({required this.mobile, required this.password});

  Map<String, dynamic> toJson() => {"mobile": mobile, "password": password};

  Future<Map<String, dynamic>> login() async {
    try {
      final url = "$api_url/partners/login/";
      print("Login URL: $url");
      final response = await postCalling(url, toJson());

      if (response["ok"] == 1 && response.containsKey("data")) {
        // Save session
        String sessionData = jsonEncode(response["data"]);
        await session.setSession("loggedInUser", sessionData);

        String? token = response["data"]["token"];
        if (token != null) {
          await session.setSession("loggedInUserKey", token);
          print("Session data set: $sessionData");
          print("Session token set: $token");
        } else {
          print("No token found in response data");
        }
        return {
          "ok": 1,
          "message": "Login successful",
          "data": response["data"]
        };
      } else {
        return {
          "ok": 0,
          "message": response["message"] ?? "Invalid credentials"
        };
      }
    } catch (e) {
      return {
        "ok": 0,
        "message": "Something went wrong",
        "error": e.toString()
      };
    }
  }
}
