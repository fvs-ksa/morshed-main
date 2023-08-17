import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshed/bloc/boarding_cubit/state.dart';
import 'package:morshed/component/navigation_functions.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/screen/borading_screen/boarding_screen.dart';
import 'package:morshed/screen/bottom_navigations_screens/main_screen.dart';

import '../../models/account_type_model.dart';
import '../../models/api_model/company_model.dart';
import '../../utiels/dio_helper.dart';

class BoardingCubit extends Cubit<BoardingState> {
  BoardingCubit() : super(InitialBoardingState());

  static BoardingCubit get(context) => BlocProvider.of(context);
  bool isLastBoarding = false;

  changeLastBoarding() {
    isLastBoarding = true;
    emit(ChangeBoardingState());
  }
  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 300));
    FlutterNativeSplash.remove();
    // token==null?navigateForward(BoardingScreen()):navigateForward(MainScreen());
    emit(RemoveNativeSplashState());
  }


  int i = -1;

  changeTypeOfAccount(int index) {
    i = index;
    typeModel[i].isTabbed = !typeModel[i].isTabbed;
    emit(ChangeAccountTypeState());
  }
  Future<Position> determinePosition() async {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      AppSettings.openLocationSettings();

      return Future.error(
          'Location Service are denied/////////////////////////');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Service are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location Permision are denied permanently, we cannot request permission');
    }
    return Geolocator.getCurrentPosition();
  }

  String cityName = '';
  bool isLoading = false;
  String address='';

  void getPlace(Position pos, BuildContext context) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(
      pos.latitude,
      pos.longitude,
      localeIdentifier: context.locale.languageCode,
    );
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String street = placeMark.street.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    address = subLocality +
        ',' +
        street +
        ',' +
        locality +
        ',' +
        postalCode +
        ',' +
        administrativeArea +
        ',' +
        country +
        ',' +
        name;
    isLoading = true;
    cityName = placeMark.locality.toString();
    print(address);
    print(placeMark.locality.toString());
    emit(GetPlacesSuccessState());
    print(pos.longitude);
  }



  Future<dynamic> getUserCurrentLocation(BuildContext context) async {
    emit(GetUserCurrentLocation());
    await determinePosition().then((value) => getPlace(value, context));
  }
  LatLng? latLn;
  String addressFromMap = '';
  getLocationFromMap(cameraPositions) async {
    List<Placemark> newPlace = await placemarkFromCoordinates(
        cameraPositions.target.latitude, cameraPositions.target.longitude,
        localeIdentifier: myLocale.toString());
    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String street = placeMark.street.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String address =
        name + ',' + street + ',' + locality + ',' + postalCode + ',' + country;
    print(address);
    addressFromMap = address;
    latLn = LatLng(
        cameraPositions.target.latitude, cameraPositions.target.longitude);
    print('${latLn?.latitude}latLn?.latitude');
    // address='';
    emit(ConvertLocationFromMapSuccessState());
    print('/////////////////////////################## $addressFromMap');
    lat=latLn?.latitude;
    lng=latLn?.longitude;
    print('$lat ////// $lng');
  }
  Position? position;

  void getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    try {
      position = await GeolocatorPlatform.instance.getCurrentPosition();
      print('location:${position!.longitude}');
      final coordinate = await placemarkFromCoordinates(
          position!.latitude, position!.longitude);
      // currentLocation=await Location().getLocation();
      var first = coordinate.first;
      print("${first.name} : ${first..administrativeArea}");
      print(position!.longitude.toString());
      lat=position?.latitude;
      lng=position!.longitude;
      print('$lat ////// $lng');
      emit(GetCurrentLocationSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetCurrentLocationErrorState(
        error: e.toString(),
      ));
    }
  }
  getStringAddress(int i){

    if(i == 0){

      meenaLoc = addressFromMap;
      emit(ChangeAddressState());
      addressFromMap='';
    }else if(i == 1){

      arafaLoc = addressFromMap;
      emit(ChangeAddressState());
      addressFromMap='';

    }else if(i == 3) {
      reportLocation = addressFromMap;

      emit(ChangeAddressState());
      addressFromMap='';
    }else{
      mozdalifaLoc = addressFromMap;
      emit(ChangeAddressState());
      addressFromMap='';
    }
  }
//   late CompanyModel companyModel;
//   getAllCompanies(){
//     emit(GetCompaniesLoadingState());
//     DioHelper.getData(url: 'https://murshidguide.com/api/listCompanies').then((value) {
//       print(value.data);
//       companyModel=CompanyModel.fromJson(value.data);
//       emit(GetCompaniesSuccessState());
//     }).catchError((error){
//       print(error.toString());
//       emit(GetCompaniesErrorState(error: error.toString()));
//     });
//   }
 }
