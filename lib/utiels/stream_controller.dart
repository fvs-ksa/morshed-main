// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:morshed/constant/const_color.dart';
// import 'package:morshed/utiels/dio_helper.dart';
//
// import '../models/api_model/provider_model.dart';
//
// class MyApiDataSource {
//   StreamController<GetProvidersModel> _dataStreamController = StreamController();
//
//   Stream<GetProvidersModel> get dataStream => _dataStreamController.stream;
//   late GetProvidersModel getProvidersModel;
//   List<Marker> providerMarkers = [];
//   void startListening()async {
//     // Simulate an API that returns data every second
//    // Timer.periodic(Duration(minutes: 2), (timer) async {
//       try {
//         DioHelper.getData(url:'https://murshidguide.com/api/pilgrims/getproviders',token: '114|BwgFdtV7URu1u9qoATVeQFXC5W0RgRUbOQlwKQ6L').then((value) {
//           getProvidersModel=GetProvidersModel.fromJson(value.data);
//           _dataStreamController.add(getProvidersModel);
//           print(value.data);
//         }).catchError((error){
//           print(error.toString());
//           //_dataStreamController.addError(error);
//         });
//         for(var data in getProvidersModel.providers!){
//           final marker= Marker(
//             icon:await BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(10,10)), 'assets/images/marker.png'),
//             markerId: MarkerId(data.id.toString()),
//             position: LatLng(double.parse(data.lat!), double.parse(data.lng!)),
//
//           );
//           providerMarkers.add(marker);
//         }
//       } catch (e) {
//         _dataStreamController.addError(e);
//       }
//     // }
//     // );
//   }
//
//   void stopListening() {
//     _dataStreamController.close();
//   }
// }