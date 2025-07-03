// // helpers/session.dart or wherever your login function is
// import 'package:http/http.dart' as http;
// import 'package:erpapp/models/manage.model.dart'; // points to your Session class

// Future<Session?> login(String username, String password) async {
//   final response = await http.post(
//     Uri.parse('https://corrtechsolutions.in/api/login/'),
//     body: {
//       'username': username,
//       'password': password,
//     },
//   );

//   print('Login status: ${response.statusCode}');
//   print('Response headers: ${response.headers}');

//   if (response.statusCode == 200) {
//     final setCookieHeader = response.headers['set-cookie'];
//     if (setCookieHeader != null) {
//       final cookies = extractCookies(setCookieHeader);
//       print('Extracted cookies: $cookies');

//       final sessionId = cookies['sessionid'];
//       if (sessionId != null) {
//         return Session(sessionId: sessionId);
//       } else {
//         print('sessionid cookie not found.');
//       }
//     } else {
//       print('No Set-Cookie header returned.');
//     }
//   } else {
//     print('Login failed with status ${response.statusCode}');
//   }

//   return null; // login failed
// }

// Map<String, String> extractCookies(String setCookie) {
//   final cookieMap = <String, String>{};
//   final cookies = setCookie.split(',');

//   for (var cookie in cookies) {
//     final parts = cookie.split(';');
//     for (var part in parts) {
//       if (part.contains('=')) {
//         final kv = part.trim().split('=');
//         if (kv.length == 2) {
//           final key = kv[0].trim();
//           final value = kv[1].trim();
//           cookieMap[key] = value;
//         }
//       }
//     }
//   }

//   return cookieMap;
// }
