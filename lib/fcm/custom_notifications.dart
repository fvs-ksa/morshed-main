//import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   @override
//   void initState() {
//     super.initState();
//
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     var initializationSettingsIOS = IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification notification = message.notification;
//       AndroidNotification android = message.notification?.android;
//
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//                 android: AndroidNotificationDetails(
//                     'your channel id', 'your channel name', 'your channel description',
//                     importance: Importance.high,
//                     priority: Priority.high,
//                     ticker: 'ticker')),
//             payload: message.data['screen']); // set the screen name here
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       Navigator.pushNamed(context, message.data['screen']); // navigate to the screen here
//     });
//   }
//
//   Future<void> onSelectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: ' + payload);
//     }
//     await Navigator.pushNamed(context, payload); // navigate to the screen here
//   }
//
//   Future<void> onDidReceiveLocalNotification(
//       int id, String title, String body, String payload) async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: Text('Notification tapped $payload'),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Local Notifications Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Local Notifications Demo'),
//         ),
//         body: Center(
//           child: Text('This is the home screen'),
//         ),
//       ),
//       routes: <String, WidgetBuilder>{
//         '/first': (BuildContext context) => FirstScreen(),
//         '/second': (BuildContext context) => SecondScreen(),
//       },
//     );
//   }
// }
//
// class FirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('First Screen'),
//       ),
//       body: Center(
//         child: Text('This is the first screen'),
//       ),
//     );
//   }
// }
//
// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Screen'),
//       ),
//       body: Center(
//         child: Text('This is the second screen'),
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../utiels/shared_pref.dart';



pushNotification(String title,String mBody) async{
  CacheHelper.init();
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  var headers = {'Authorization':'key= AAAA_u4v9l8:APA91bHq4I-Lh4y4ZylSxTMWxM5I1JvTK43TRCiljG7cjapWG56NZXq5kuK2UvtZeOzo-m87syjQsLN0gpg0yQvK0jOp2ZwcFTpiNLDxlJmgjyDjSIYaEfpCUph00mMfMv7GJ0ZkUmfz',
    'Content-Type':'application/json'};
  var body = jsonEncode(
      {
        "to": CacheHelper.getData(key: 'fcmToken'),
        'notification': {'title':title,'body': mBody},
        "data": {
          "click_action": "FLUTTER_NOTIFICATION_CLICK",
          "sound": "default",
          "status": "done",
          "screen": "screenA",
        },

  });
  var response = await http.post(url, body: body,headers: headers);
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'my_channel', // id
  'My Channel', // title
 // 'Important notifications from my server.', // description
  importance: Importance.high,
);

class NotificationsHelper {
  static Future init() async {
    await Firebase.initializeApp();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(

                channel.id,
                channel.name,
               // channel.description,
                icon: 'ic_launcher.png',
              ),
            ));
      }
    });
  }
}