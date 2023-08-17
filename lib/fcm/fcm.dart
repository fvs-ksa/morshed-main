
// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:morshed/component/navigation_functions.dart';
// import 'package:morshed/models/api_model/notification_model.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
//
// import '../screen/bottom_navigations_screens/notification_screen.dart';
//
// class NotificationHelper {
//   static Future<void> initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize =
//     new AndroidInitializationSettings('notification_icon');
//     var iOSInitialize = new DarwinInitializationSettings();
//     var initializationsSettings = new InitializationSettings(
//         android: androidInitialize, iOS: iOSInitialize);
//
//     flutterLocalNotificationsPlugin.initialize(initializationsSettings,
//         onDidReceiveBackgroundNotificationResponse: (_pay) async {
//           final payload = _pay.payload;
//           try {
//            // NotificationBody _payload;
//             if (payload != null && payload.isNotEmpty) {
//               navigateForward(NotificationsScreen());
//               // _payload = NotificationBody.fromJson(jsonDecode(payload));
//               // if (_payload.notificationType == NotificationType.order) {
//               //   Get.toNamed(RouteHelper.getOrderDetailsRoute(
//               //       int.parse(_payload.orderId.toString())));
//               // } else if (_payload.notificationType == NotificationType.general) {
//               //   Get.toNamed(RouteHelper.getNotificationRoute());
//               // } else {
//               //   Get.toNamed(RouteHelper.getChatRoute(
//               //       notificationBody: _payload,
//               //       conversationID: _payload.conversationId));
//               // }
//             }
//           } catch (e) {}
//           return;
//         }, onDidReceiveNotificationResponse: (_pay) async {
//           final payload = _pay.payload;
//           try {
//            // NotificationBody _payload;
//             if (payload != null && payload.isNotEmpty) {
//               navigateForward(NotificationsScreen());
//               // _payload = NotificationBody.fromJson(jsonDecode(payload));
//               // if (_payload.notificationType == NotificationType.order) {
//               //   Get.toNamed(RouteHelper.getOrderDetailsRoute(
//               //       int.parse(_payload.orderId.toString())));
//               // } else if (_payload.notificationType == NotificationType.general) {
//               //   Get.toNamed(RouteHelper.getNotificationRoute());
//               // } else {
//               //   Get.toNamed(RouteHelper.getChatRoute(
//               //       notificationBody: _payload,
//               //       conversationID: _payload.conversationId));
//               // }
//             }
//           } catch (e) {}
//           return;
//         });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print(
//           "onMessage: ${message.notification?.title}/${message.data}");
//       NotificationHelper.showNotification(
//           message, flutterLocalNotificationsPlugin, false);
//       // if (message.data['type'] == 'message' &&
//       //     Get.currentRoute.startsWith(RouteHelper.messages)) {
//       //   if (Get.find<AuthController>().isLoggedIn()) {
//       //     Get.find<ChatController>().getConversationList(1);
//       //     if (Get.find<ChatController>()
//       //         .messageModel
//       //         .conversation
//       //         .id
//       //         .toString() ==
//       //         message.data['conversation_id'].toString()) {
//       //       Get.find<ChatController>().getMessages(
//       //         1,
//       //         NotificationBody(
//       //           notificationType: NotificationType.message,
//       //           adminId: message.data['sender_type'] == UserType.admin.name
//       //               ? 0
//       //               : null,
//       //           restaurantId:
//       //           message.data['sender_type'] == UserType.vendor.name
//       //               ? 0
//       //               : null,
//       //           deliverymanId:
//       //           message.data['sender_type'] == UserType.delivery_man.name
//       //               ? 0
//       //               : null,
//       //         ),
//       //         null,
//       //         int.parse(message.data['conversation_id'].toString()),
//       //       );
//       //     } else {
//       //       NotificationHelper.showNotification(
//       //           message, flutterLocalNotificationsPlugin, false);
//       //     }
//       //   }
//       // } else if (message.data['type'] == 'message' &&
//       //     Get.currentRoute.startsWith(RouteHelper.conversation)) {
//       //   if (Get.find<AuthController>().isLoggedIn()) {
//       //     Get.find<ChatController>().getConversationList(1);
//       //   }
//       //   NotificationHelper.showNotification(
//       //       message, flutterLocalNotificationsPlugin, false);
//       // } else {
//       //
//       //   // if (Get.find<AuthController>().isLoggedIn()) {
//       //   //   Get.find<OrderController>().getRunningOrders(1);
//       //   //   Get.find<OrderController>().getHistoryOrders(1);
//       //   //   Get.find<NotificationController>().getNotificationList(true);
//       //   //   // if(message.data['type'] == 'message' && message.data['message'] != null && message.data['message'].isNotEmpty) {
//       //   //   //   if(Get.currentRoute.contains(RouteHelper.conversation)) {
//       //   //   //     Get.find<ChatController>().reloadConversationWithNotification(m.Message.fromJson(message.data['message']).conversationId);
//       //   //   //   }else {
//       //   //   //     Get.find<ChatController>().reloadMessageWithNotification(m.Message.fromJson(message.data['message']));
//       //   //   //   }
//       //   //   // }
//       //   // }
//       // }
//     });
//
//
//
//
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print(
//           "onOpenApp: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
//       try {
//         if (message.data != null || message.data.isNotEmpty) {
//           convertNotification(message.data);
//           navigateForward(NotificationsScreen());
//           // NotificationBody _notificationBody =
//           // convertNotification(message.data);
//           // if (_notificationBody.notificationType == NotificationType.order) {
//           //   print('order call-------------');
//           //   Get.toNamed(RouteHelper.getOrderDetailsRoute(
//           //       int.parse(message.data['order_id'])));
//           // } else if (_notificationBody.notificationType ==
//           //     NotificationType.general) {
//           //   Get.toNamed(RouteHelper.getNotificationRoute());
//           // } else {
//           //   Get.toNamed(RouteHelper.getChatRoute(
//           //       notificationBody: _notificationBody,
//           //       conversationID: _notificationBody.conversationId));
//           // }
//         }
//       } catch (e) {}
//     });
//   }
//
//   static Future<void> showNotification(RemoteMessage message,
//       FlutterLocalNotificationsPlugin fln, bool data) async {
//     if (Platform.isIOS) {
//       String? _title;
//       String? _body;
//       String? _orderID;
//       String? _image;
//      GetNotificationModel getNotificationModel = convertNotification(message.data);
//       // if (data) {
//       //   _title = message.data['title'];
//       //   _body = message.data['body'];
//       //   _orderID = message.data['order_id'];
//       //   _image = (message.data['image'] != null &&
//       //       message.data['image'].isNotEmpty)
//       //       ? message.data['image'].startsWith('http')
//       //       ? message.data['image']
//       //       : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.data['image']}'
//       //       : null;
//       // } else {
//       //   _title = message.notification?.title;
//       //   _body = message.notification?.b?ody;
//       //   _orderID = message.notification.titleLocKey;
//       //   // if (GetPlatform.isAndroid) {
//       //   //   _image = (message.notification?.android?.imageUrl != null &&
//       //   //       message.notification.android.imageUrl.isNotEmpty)
//       //   //       ? message.notification?.android?.imageUrl.startsWith('http')
//       //   //       ? message.notification.android.imageUrl
//       //   //       : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.android.imageUrl}'
//       //   //       : null;
//       //   // } else if (GetPlatform.isIOS) {
//       //   //   _image = (message.notification.apple.imageUrl != null &&
//       //   //       message.notification.apple.imageUrl.isNotEmpty)
//       //   //       ? message.notification.apple.imageUrl.startsWith('http')
//       //   //       ? message.notification.apple.imageUrl
//       //   //       : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.apple.imageUrl}'
//       //   //       : null;
//       //   // }
//       // }
//
//       // if (_image != null && _image.isNotEmpty) {
//       //   try {
//       //     await showBigPictureNotificationHiddenLargeIcon(
//       //         _title, _body, _orderID, getNotificationModel, fln);
//       //   } catch (e) {
//       //     await showBigTextNotification(
//       //         _title, _body, _orderID, getNotificationModel, fln);
//       //   }
//       // } else {
//       //   await showBigTextNotification(
//       //       _title, _body, _orderID, _notificationBody, fln);
//       // }
//     }
//   }
//
//   static Future<void> showTextNotification(
//       String title,
//       String body,
//       String orderID,
//       GetNotificationModel getNotificationModel,
//     //  NotificationBody notificationBody,
//       FlutterLocalNotificationsPlugin fln) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'stackfood',
//       'stackfood',
//       playSound: true,
//       importance: Importance.max,
//       priority: Priority.max,
//       sound: RawResourceAndroidNotificationSound('notification'),
//     );
//     const NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, title, body, platformChannelSpecifics,
//         payload: getNotificationModel != null
//             ? jsonEncode(getNotificationModel.toJson())
//             : null);
//   }
//
//   static Future<void> showBigTextNotification(
//       String title,
//       String body,
//       String orderID,
//       GetNotificationModel notificationBody,
//       FlutterLocalNotificationsPlugin fln) async {
//     BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
//       body,
//       htmlFormatBigText: true,
//       contentTitle: title,
//       htmlFormatContentTitle: true,
//     );
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'stackfood',
//       'stackfood',
//       importance: Importance.max,
//       styleInformation: bigTextStyleInformation,
//       priority: Priority.max,
//       playSound: true,
//       sound: RawResourceAndroidNotificationSound('notification'),
//     );
//     NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, title, body, platformChannelSpecifics,
//         payload: notificationBody != null
//             ? jsonEncode(notificationBody.toJson())
//             : null);
//   }
//
//   static Future<void> showBigPictureNotificationHiddenLargeIcon(
//       String title,
//       String body,
//       String orderID,
//       GetNotificationModel notificationBody,
//       String image,
//       FlutterLocalNotificationsPlugin fln,
//       ) async {
//     final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
//     final String bigPicturePath =
//     await _downloadAndSaveFile(image, 'bigPicture');
//     final BigPictureStyleInformation bigPictureStyleInformation =
//     BigPictureStyleInformation(
//       FilePathAndroidBitmap(bigPicturePath),
//       hideExpandedLargeIcon: true,
//       contentTitle: title,
//       htmlFormatContentTitle: true,
//       summaryText: body,
//       htmlFormatSummaryText: true,
//     );
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//     AndroidNotificationDetails(
//       'stackfood',
//       'stackfood',
//       largeIcon: FilePathAndroidBitmap(largeIconPath),
//       priority: Priority.max,
//       playSound: true,
//       styleInformation: bigPictureStyleInformation,
//       importance: Importance.max,
//       sound: RawResourceAndroidNotificationSound('notification'),
//     );
//     final NotificationDetails platformChannelSpecifics =
//     NotificationDetails(android: androidPlatformChannelSpecifics);
//     await fln.show(0, title, body, platformChannelSpecifics,
//         payload: notificationBody != null
//             ? jsonEncode(notificationBody.toJson())
//             : null);
//   }
//
//   static Future<String> _downloadAndSaveFile(
//       String url, String fileName) async {
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';
//     final http.Response response = await http.get(Uri.parse(url));
//     final File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }
//
//   static GetNotificationModel convertNotification(Map<String, dynamic> data) {
//     if (data['type'] == 'general') {
//       return GetNotificationModel();
//     } else if (data['type'] == 'order_status') {
//       return GetNotificationModel(
//           // notificationType: NotificationType.order,
//           // orderId: int.parse(data['order_id'])
//       );
//     } else {
//       return GetNotificationModel(
//         // notificationType: NotificationType.message,
//         // deliverymanId: data['sender_type'] == 'delivery_man' ? 0 : null,
//         // adminId: data['sender_type'] == 'admin' ? 0 : null,
//         // restaurantId: data['sender_type'] == 'vendor' ? 0 : null,
//         // conversationId: int.parse(data['conversation_id'].toString()),
//       );
//     }
//   }
// }
//
// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
//   print(
//       "onBackground: ${message.notification?.title}/${message.notification?.body}/${message.notification?.titleLocKey}");
//
//   var androidInitialize = new AndroidInitializationSettings('notification_icon');
//   var iOSInitialize = new DarwinInitializationSettings();
//   var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   flutterLocalNotificationsPlugin.initialize(initializationsSettings);
//   NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
// }





import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:morshed/screen/bottom_navigations_screens/main_screen.dart';
import 'package:morshed/screen/bottom_navigations_screens/notification_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../component/navigation_functions.dart';
import '../constant/const_color.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  // await Firebase.initializeApp();
  // await Firebase.initializeApp();
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage) {

   // navigateForward(NotificationScreen());
    print('App Killed And navigate :${remoteMessage?.data}');
  });
  //_onMessageStreamController.add(message.data);
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
  //   print('on Opened ' + data.data.toString());
  //
  //   handlePathByRoute(data.data);
  // });
  debugPrint("Handling a background message: ${message.senderId}");

}

StreamController<Map<String, dynamic>> _onMessageStreamController =
StreamController.broadcast();

class FirebaseNotifications {
  late FirebaseMessaging _firebaseMessaging;

  StreamController<Map<String, dynamic>> get notificationSubject {
    return _onMessageStreamController;
  }

  void killNotification() {
    _onMessageStreamController.close();
  }

  late FlutterLocalNotificationsPlugin _notificationsPlugin;

  late Map<String, dynamic> _not;

  Future<void> setUpFirebase() async {

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getInitialMessage();

    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(

        alert: true, badge: true, sound: true);
    // checkLastMessage();
    firebaseCloudMessagingListeners();

    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = const DarwinInitializationSettings(
        defaultPresentBadge: true,
        defaultPresentAlert: true,
        defaultPresentSound: true);
    var initSetting = InitializationSettings(android: android, iOS: ios);
    _notificationsPlugin.initialize(initSetting,
      onDidReceiveBackgroundNotificationResponse:notificationTapBackground ,
      onDidReceiveNotificationResponse:notificationTapBackground,

      //  onSelectNotification: onSelectNotification
    );


  }

  Future<void> checkLastMessage() async {
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      print(initialMessage.data.toString());
      handlePath(initialMessage.data);
    }
  }
  BuildContext? context;
  Future<void> firebaseCloudMessagingListeners() async {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print("TOOOKEN" + token!);
      fcmToken = token;
      print(fcmToken);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage data) {
      // handlePath(data.data);
      print('on message notification body ${data.notification?.body}');
      print('on message notification title ${data.notification?.title}');
      print('on message notification bodyLocKey ${data.notification?.bodyLocKey}');
      print('on message notification titleLocKey ${data.notification?.titleLocKey}');
      String timeZone='Pm';
      data.sentTime!.hour>12?timeZone='Pm':timeZone='Am';

      String time='${data.sentTime?.hour}:${data.sentTime?.minute} $timeZone ';
      print(timeZone);
      print(DateFormat.yMEd().add_jms().format(DateFormat("hh:mm").parse(time)));
      print('on message notifications title ${data.sentTime?.hour}:${data.sentTime?.minute} $timeZone');
     // userType=='customer'? notificationList.add(NotificationModel(title: data.notification?.title, subTitle: data.notification?.body,
      //      timeZone: time)):notificationBickerList.add(BickerNotificationModel(data: [
      //        Data(message:data.notification?.title, ),
      // ]));

      //  _onMessageStreamController.add(data.data);
      // handlePath(data.data);

      _not = data.data;
      print(_not);

      showNotification(
          data.data, data.notification?.title, data.notification?.body);

      // if (Platform.isAndroid) {
      //   showNotificationWithAttachment(data.data, data.notification.title,
      //       data.notification.body, data.notification.android.imageUrl);
      // } else {
      //   showNotificationWithAttachment(data.data, data.notification.title,
      //       data.notification.body, data.notification.apple.imageUrl);
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage data) {
      print('on Opened ' + data.data.toString());
     // String time='${data.sentTime?.hour}:${data.sentTime?.minute} Pm ';
      // notificationList.add(NotificationModel(title: data.notification?.title, subTitle: data.notification?.body,
      //     timeZone: time));
      //  onSelectNotification( data.data.toString());
      handlePath(data.data);
    });
  }

  showNotification(
      Map<String, dynamic> _message, String? title, String? body) async {
    print("Notification Response : $_message");

    var androidt = const AndroidNotificationDetails(
        'morshed', 'channel_name',
        priority: Priority.high,
        channelShowBadge: true,
        playSound: true,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher",
        enableVibration: true,
        enableLights: true,
        importance: Importance.max);
    var iost = const DarwinNotificationDetails();
    var platform = NotificationDetails(android: androidt, iOS: iost);
    await _notificationsPlugin.show(0, title, body, platform, payload: "");
  }

  Future<void> showNotificationWithAttachment(Map<String, dynamic> _message,
      String title, String body, String imageUrl) async {
    print("Notification Response : $_message");
    var attachmentPicturePath = await _downloadAndSaveFile(
        imageUrl ?? 'https://via.placeholder.com/800x200',
        'attachment_img.jpg');
    var iOSPlatformSpecifics = DarwinNotificationDetails(
      attachments: [DarwinNotificationAttachment(attachmentPicturePath)],
    );
    var bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(attachmentPicturePath),
      contentTitle: '<b>$title</b>',
      htmlFormatContentTitle: true,
      summaryText: '$body',
      htmlFormatSummaryText: true,
    );
    var androidChannelSpecifics = AndroidNotificationDetails(
      'morshed',
      'channel_name',
      // 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );
    var notificationDetails = NotificationDetails(
        android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
    print("notificationDetails $notificationDetails");
    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void iOSPermission() {
    _firebaseMessaging.requestPermission(
        alert: true, announcement: true, badge: true, sound: true);
  }

  void handlePath(
      Map<String, dynamic> dataMap,
      //BuildContext context
      ) {
    handlePathByRoute(
      dataMap,
      // context
    );
  }

  void onSelectNotification(String payload) async {
    print(payload.toString());
    handlePath(_not);
  }
  void notificationTapBackground(NotificationResponse notificationResponse) {
    var androidInitialize = new AndroidInitializationSettings('notification_icon');
    var iOSInitialize = new DarwinInitializationSettings();
    var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  //  _notificationsPlugin.show(message, flutterLocalNotificationsPlugin, true);
    // ignore: avoid_print
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
   navigateForward(NotificationsScreen());
   // userType=="bicker"?navigateForward(NotificationBikerScreen()): navigateForward(NotificationScreen());
   //  if (notificationResponse.input?.isNotEmpty ?? false) {
   //    // ignore: avoid_print
   //    print(
   //        'notification action tapped with input: ${notificationResponse.input}');
   //    userType=="bicker"?navigateForward(NotificationBikerScreen()):  navigateForward(NotificationScreen()
    //);
    }
  }


Future<void> handlePathByRoute(
    Map<String, dynamic> dataMap,
    //BuildContext context
    ) async {
  //navigateForward(MainScreen())
  navigateForward(NotificationsScreen());
 // userType=="bicker"?navigateForward(NotificationBikerScreen()):  navigateForward(NotificationScreen());
  // print(dataMap);
  String orderId = dataMap["click_action"].toString();
  String userId = dataMap["id"].toString();
  String supplierId = dataMap["screenA"].toString();
  // String roomId = dataMap["chat_id"].toString();
  // String type = dataMap["type"].toString();
  //
  //  print(orderId);
  // print(userId);
  // if(supplierId=='screen1'){
  //
  // }else{
  //   navigateForward(OrdersScreens());
  // }
  // print(supplierId);
  // print(roomId);

  // if (type == '6') {
  //
  //   // navigateForward(
  //   //     ChatScreen(
  //   //       orderId: orderId,
  //   //       chatId: roomId,
  //   //       supplierId: supplierId,
  //   //       userId: userId,
  //   //     )
  //   // );
  // }else if(supplierId == '9' || type =='1'){
  //   // navigateForward(NotificationScreen(
  //   //
  //   // ));
  // }
  // else{
  //   // navigateForward(DetailsScreen(
  //   //   orderId: orderId,
  //   //   userId: userId,
  //   //   roomId: roomId,
  //   //   supplierId: supplierId,
  //   // ));
  // }

}
//import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// Future<void> main() async {
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
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future<void> _navigateToScreen(String screen) async {
//     if (screen == 'screen1') {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Screen1()));
//     } else if (screen == 'screen2') {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Screen2()));
//     }
//   }
//
//   Future<void> _showNotification(
//       Map<String, dynamic> message, String payload) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.high,
//         priority: Priority.high,
//         ticker: 'ticker',
//         playSound: true,
//         enableVibration: true,
//         enableLights: true);
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//
//     String title = message['notification']['title'];
//     String body = message['notification']['body'];
//
//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, platformChannelSpecifics,
//         payload: payload);
//   }
//
//   Future<void> _initializeNotifications() async {
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS,
//         macOS: null);
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (payload) async {
//       await _navigateToScreen(payload);
//     });
//   }
//
//   Future<void> _initializeFirebaseMessaging() async {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       await _showNotification(message.data, message.data['screen']);
//     });
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       await _navigateToScreen(message.data['screen']);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeNotifications();
//     _initializeFirebaseMessaging();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter Demo'),
//         ),
//         body: Center(
//           child: Text('Hello, World!'),
//         ),
//       ),
//     );
//   }
// }
//
// class Screen1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen 1'),
//       ),
//       body: Center(
//         child: Text('This is Screen 1'),
//       ),
//     );
//   }
// }
//
// class Screen2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen