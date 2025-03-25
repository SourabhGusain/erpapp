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
      final response = await postCalling(url, toJson());

      print(url);
      print(jsonEncode(toJson()));
      print(response);

      if (response == null) throw Exception("Null response from server");

      if (response["ok"] == 1 && response.containsKey("data")) {
        String sessionData = jsonEncode(response["data"]);
        await session.setSession("usersession", sessionData);

        return {
          "ok": 1,
          "message": response["message"] ?? "Login successful",
          "data": response["data"]
        };
      }

      return {"ok": 0, "message": response["message"] ?? "Invalid credentials"};
    } catch (e) {
      return {
        "ok": 0,
        "message": "Something went wrong",
        "error": e.toString()
      };
    }
  }
}
