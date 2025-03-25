// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class FireBaseHelper {
//   FireBaseHelper();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications',
//     description: "Description", // title
//     importance: Importance.max,
//     sound: RawResourceAndroidNotificationSound('cab_notification'),
//   );

//   static Future<String?> getToken() async {
//     FirebaseMessaging instance = FirebaseMessaging.instance;
//     String? token = await instance.getToken();

//     print("token: $token");

//     if (Platform.isIOS) {
//       token = await FirebaseMessaging.instance.getAPNSToken();
//       print('APNS Token: $token');
//     }

//     return token;
//   }

//   static Future<String?> saveToken() async {
//     String? token = await getToken();
//     if (token != null) {
//       // DriverModel driverModel = DriverModel();
//       // driverModel.fcm_token = token;
//       // await driverModel.updateFCM(driverModel);
//     }

//     return token;
//   }

//   Future<void> _showNotification(dynamic message) async {
//     print(message.data);
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'custom_channel_id',
//       'channel_name',
//       importance: Importance.high,
//       priority: Priority.high,
//       sound: RawResourceAndroidNotificationSound(
//           'cab_notification'), // No extension
//     );

//     const DarwinNotificationDetails iOSDetails =
//         DarwinNotificationDetails(sound: 'cab_notification.caf');

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails, iOS: iOSDetails);

//     flutterLocalNotificationsPlugin.show(
//       0,
//       message.data['title'] ?? 'No Title',
//       message.data['body'] ?? 'No Body',
//       notificationDetails,
//     );
//     // const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     //     AndroidNotificationDetails(
//     //   'default_channel_id',
//     //   'Default Channel',
//     //   channelDescription: 'This channel is used for important notifications.',
//     //   importance: Importance.high,
//     //   priority: Priority.high,
//     //   sound: RawResourceAndroidNotificationSound('cab_notification'),
//     // );

//     // const NotificationDetails platformChannelSpecifics =
//     //     NotificationDetails(android: androidPlatformChannelSpecifics);

//     // await flutterLocalNotificationsPlugin.show(
//     //   0, // Notification ID
//     //   title ?? 'No Title',
//     //   body ?? 'No Body',
//     //   platformChannelSpecifics,
//     // );
//   }

//   void handleNotification() {
//     FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//     _firebaseMessaging.requestPermission();
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Handle your notification here
//       _showNotification(message);
//     });

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       _showNotification(message);
//       // _showNotification(
//       //     message.notification?.title, message.notification?.body);

//       // const AndroidNotificationDetails androidDetails =
//       //     AndroidNotificationDetails(
//       //   'channel_id',
//       //   'channel_name',
//       //   importance: Importance.high,
//       //   priority: Priority.high,
//       //   sound: RawResourceAndroidNotificationSound(
//       //       'cab_notification'), // No extension
//       // );

//       // const DarwinNotificationDetails iOSDetails =
//       //     DarwinNotificationDetails(sound: 'cab_notification.caf');

//       // const NotificationDetails notificationDetails =
//       //     NotificationDetails(android: androidDetails, iOS: iOSDetails);

//       // flutterLocalNotificationsPlugin.show(
//       //   0,
//       //   message.data['title'] ?? 'No Title',
//       //   message.data['body'] ?? 'No Body',
//       //   notificationDetails,
//       // );
//     });
//   }

//   Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     // _showNotification(message);
//     print("Handling a background message: ${message.messageId}");
//     // Handle your background message here

//     if (message.data['title'] != null) {
//       flutterLocalNotificationsPlugin.show(
//           0,
//           message.data['title'] ?? 'No Title',
//           message.data['body'] ?? 'No Body',
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'custom_channel_id',
//               'channel_name',
//               importance: Importance.high,
//               priority: Priority.high,
//               sound: RawResourceAndroidNotificationSound('cab_notification'),
//             ),
//           ));
//     }
//   }
// }
