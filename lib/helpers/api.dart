import 'dart:async';
import 'dart:convert';
// import 'package:chanakyaapp/helpers/get.dart';
import 'package:erpapp/helpers/session.dart';
import 'package:dio/dio.dart';

class Api {
  static final Dio dio = Dio(); // Singleton instance of Dio

  // Initialize the CookieManager with the shared CookieJar
  Api() {
    // Session session = Session();
    // session.getSession("loggedInUserKey").then((key) {
    //   if (key != null) {
    //     dio.options.headers['Authorization'] = "Token $key";
    //   }
    // });
  }

  Future<Map> getCalling(api, fromJson, {dynamic data}) async {
    Map returnObj = {"ok": 0, "data": [], "message": "", "error": ""};
    try {
      Session session = Session();
      String? key = await session.getSession("loggedInUserKey");
      if (key != null) {
        dio.options.headers['Authorization'] = "Token $key";
      }

      var response = await dio.get(api);

      if (response.statusCode == 200) {
        if (response.data['ok'] > 0) {
          if (response.data['data'] != null) {
            returnObj["data"] = fromJson(response.data['data']);
          }
          returnObj["message"] = response.data['message'];
          returnObj["ok"] = 1;
        } else {
          returnObj["error"] = response.data['error'];
        }
      } else {
        if (response.statusMessage != null) {
          returnObj["error"] = response.statusMessage!;
        } else {
          returnObj["error"] = "Something went wrong ${response.statusCode}";
        }
      }
    } on Exception catch (exception) {
      returnObj["error"] = "Something went wrong $exception";
    } catch (error) {
      returnObj["error"] = "Something went wrong $error";
    } finally {
      // ignore: control_flow_in_finally
      return returnObj;
    }
  }

// ignore: non_constant_identifier_names
  Future<Map> postCalling(api, JsonEncodedData,
      {Map<String, dynamic>? headers}) async {
    Map returnObj = {"ok": 0, "data": [], "message": "", "error": ""};
    try {
      // var dio = Dio();
      // if (headers != null) {
      //   dio.options.headers = headers;
      // }
      // Session session = Session();
      // String? key = await session.getSession("loggedInUserKey");
      // if (key != null) {
      //   dio.options.headers['Authorization'] = "Token $key";
      // }
      // dio.options.headers['Authorization'] =
      //     'gAAAAABnWoSsfV85KkUSdWq3hnBoHtYR9pMBFLTmpYVOSPgvW-jNe6JfUPD9d6qfHJoCWOYFsnaA_Ss0Ru2-Gm-_-obAcm6wYHkKE7Blf0Wa0OHZAJefZn0yG5tZZP9SdkFQ0-Xd6Ba4';
      print(jsonEncode(JsonEncodedData));
      var response = await dio.post(api, data: jsonEncode(JsonEncodedData));
      print(response);
      print('-----------------------');
      // List<Cookie> cookie = await cookieJar.loadForRequest(Uri.parse(api));
      if (response.statusCode == 200) {
        if (response.data['ok'] > 0) {
          returnObj["data"] = response.data['data'];
          returnObj["message"] = response.data['message'];
          returnObj["ok"] = 1;
        } else {
          returnObj["error"] = response.data['error'];
        }
      } else {
        if (response.statusMessage != null) {
          returnObj["error"] = response.statusMessage!;
        } else {
          returnObj["error"] = "Something went wrong ${response.statusCode}";
        }
      }
    } on Exception catch (exception) {
      returnObj["error"] = "Something went wrong $exception";
    } catch (error) {
      returnObj["error"] = "Something went wrong $error";
    } finally {
      // ignore: control_flow_in_finally
      return returnObj;
    }
  }

// ignore: non_constant_identifier_names
  Future<Map> putCalling(api, JsonEncodedData) async {
    Map returnObj = {"ok": 0, "data": [], "message": "", "error": ""};
    try {
      Session session = Session();
      String? key = await session.getSession("loggedInUserKey");
      if (key != null) {
        dio.options.headers['Authorization'] = "Token $key";
      }
      var response = await dio.put(api, data: JsonEncodedData);

      if (response.statusCode == 200) {
        if (response.data['ok'] > 0) {
          returnObj["data"] = response.data['data'];
          returnObj["message"] = response.data['message'];
          returnObj["ok"] = 1;
        } else {
          returnObj["error"] = response.data['error'];
        }
      } else {
        if (response.statusMessage != null) {
          returnObj["error"] = response.statusMessage!;
        } else {
          returnObj["error"] = "Something went wrong ${response.statusCode}";
        }
      }
    } on Exception catch (exception) {
      returnObj["error"] = "Something went wrong $exception";
    } catch (error) {
      returnObj["error"] = "Something went wrong $error";
    } finally {
      // ignore: control_flow_in_finally
      return returnObj;
    }
  }

// ignore: non_constant_identifier_names
  Future<Map> patchCalling(api, JsonEncodedData) async {
    Map returnObj = {"ok": 0, "data": [], "message": "", "error": ""};
    try {
      Session session = Session();
      String? key = await session.getSession("loggedInUserKey");
      if (key != null) {
        dio.options.headers['Authorization'] = "Token $key";
      }
      var response = await dio.patch(api, data: JsonEncodedData);

      if (response.statusCode == 200) {
        if (response.data['ok'] > 0) {
          returnObj["data"] = response.data['data'];
          returnObj["message"] = response.data['message'];
          returnObj["ok"] = 1;
        } else {
          returnObj["error"] = response.data['error'];
        }
      } else {
        if (response.statusMessage != null) {
          returnObj["error"] = response.statusMessage!;
        } else {
          returnObj["error"] = "Something went wrong ${response.statusCode}";
        }
      }
    } on Exception catch (exception) {
      returnObj["error"] = "Something went wrong $exception";
    } catch (error) {
      returnObj["error"] = "Something went wrong $error";
    } finally {
      // ignore: control_flow_in_finally
      return returnObj;
    }
  }

// ignore: non_constant_identifier_names
  Future<Map> deleteCalling(api, JsonEncodedData) async {
    Map returnObj = {"ok": 0, "data": [], "message": "", "error": ""};
    try {
      Session session = Session();
      String? key = await session.getSession("loggedInUserKey");
      if (key != null) {
        dio.options.headers['Authorization'] = "Token $key";
      }
      var response = await dio.delete(api, data: JsonEncodedData);

      if (response.statusCode == 200) {
        if (response.data['ok'] > 0) {
          returnObj["data"] = response.data['data'];
          returnObj["message"] = response.data['message'];
          returnObj["ok"] = 1;
        } else {
          returnObj["error"] = response.data['error'];
        }
      } else {
        if (response.statusMessage != null) {
          returnObj["error"] = response.statusMessage!;
        } else {
          returnObj["error"] = "Something went wrong ${response.statusCode}";
        }
      }
    } on Exception catch (exception) {
      returnObj["error"] = "Something went wrong $exception";
    } catch (error) {
      returnObj["error"] = "Something went wrong $error";
    } finally {
      // ignore: control_flow_in_finally
      return returnObj;
    }
  }
}
