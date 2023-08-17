import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshed/bloc/show_office_provider_info/cubit.dart';
import 'package:morshed/bloc/show_office_provider_info/state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:ui';
import '../constant/const_color.dart';
import '../models/api_model/provider_model.dart';
import 'dio_helper.dart';

class ProviderLocationService {
  late IO.Socket socket;
  late Position currentPosition;



  Future<void> start({required BuildContext context}) async {

    socket = IO.io('https://murshidguide.com:6001', <String, dynamic>{
     'port':6001,
      'transports': ['websocket'],
     //  'connect_timeout': 5000, // 5 seconds
     //  'timeout': 10000,
     //  'autoConnect': false
    },

    );
    // socket.connect();
    // socket.onConnect((_) {
    //   print('Connection established');
    // });
    // socket.onDisconnect((_) => print('Connection Disconnection'));
    // socket.onConnectError((err) => print(err));
    // socket.onError((err) => print(err));
    return getProviderData(context: context);
  }

  getProviderData({required BuildContext context}) {
    socket.on('getDataFromServer', (data) {
   ShowOfficesAndProviderInfoCubit.get(context).getDataProvider();
    print('on : $data');

    });
  //  socket.connect();

    socket.emit('data_Changed', (data){
      ShowOfficesAndProviderInfoCubit.get(context).getDataProvider();
      print('emit $data');
    });
    print('${socket.connected}');
    return ShowOfficesAndProviderInfoCubit.get(context).getDataProvider();

  }


  void stop() {
    socket.disconnect();
  //  _dataStreamController.close();
  }
//   void stopListening() {
//     _dataStreamController.close();
//   }
//  const fetchBackground = "fetchBackground";
//   @pragma('vm:entry-point')
//   void callbackDispatcher() {
//     //Workmanager().
//     Workmanager().executeTask((task, inputData) async {
//       // switch (task) {
//       // case fetchBackground:
//       print('/////////////////////////////////////////??????????????????');
//       Position userLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       notif.Notificationss notification = new notif.Notificationss();
//       notification.showNotificationWithoutSound(userLocation);
//       socket.emit('sendDataToServer',{
//         DioHelper.postData(
//             url: 'https://murshidguide.com/api/providers/$id/location',
//             token: token,
//             data: {
//               'latitude': currentPosition.latitude,
//               'longitude': currentPosition.longitude,
//             }).then((value) {
//           print(value.data);
//
//         }).catchError((e) {})
//       });
//       // break;
//       // }
//       return Future.value(true);
//     });
//   }
}

// class LocationService extends FlutterForegroundTask {
//   //static const String SERVICE_NAME = 'location_service';
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   LocationService(this.flutterLocalNotificationsPlugin);
//
//   @override
//
//   // void onStartCommand(intent, flags, startId) {
//   //   var locationOptions = LocationOptions(
//   //     accuracy: LocationAccuracy.high,
//   //     distanceFilter: 10,
//   //   );
//   //   final locationClient = LocationClient(locationOptions);
//   //   locationClient.getCurrentLocation().then((location) {
//   //     // Send location to backend API
//   //   });
//   //   locationClient.onLocationChanged.listen((location) {
//   //     // Send location update to backend API
//   //   });
//   // }
//
// // Rest of service implementation...
// }
