import 'dart:ui';

import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morshed/bloc/register_cubit/state.dart';
import 'package:morshed/component/navigation_functions.dart';
import 'package:morshed/models/api_model/company_model.dart';
import 'package:morshed/models/api_model/login_model.dart';
import 'package:morshed/screen/bottom_navigations_screens/main_screen.dart';
import 'package:morshed/utiels/baseurl.dart';
import 'package:morshed/utiels/dio_helper.dart';
import 'package:morshed/utiels/shared_pref.dart';
import 'dart:io';

import '../../component/animation_component.dart';
import '../../constant/const_color.dart';
import '../../models/nationality_model.dart';
import '../../tranlations/locale_keys.g.dart';
import '../login_cubit/login_cubit.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);


  EdgeInsets viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;
  viewAboveKeyBoard() {
    window = WidgetsBinding.instance.window;
    window?.onMetricsChanged = () {
      final window = this.window;
      if (window != null) {
        viewInsets = EdgeInsets.fromWindowPadding(
          window.viewInsets,
          window.devicePixelRatio,
        ).add(EdgeInsets.fromWindowPadding(
          window.padding,
          window.devicePixelRatio,
        )) as EdgeInsets;
      }
      emit(ChangeKeyboardState());
    };
  }
  late CompanyModel companyModel;
  bool isGetCompany = false;

  getAllCompanies() {
    isGetCompany = false;
    emit(GetCompaniesLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/listCompanies')
        .then((value) {
      print(value.data);
      companyModel = CompanyModel.fromJson(value.data);
      isGetCompany = true;
      emit(GetCompaniesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCompaniesErrorState(error: error.toString()));
    });
  }

  String? chooseCompany;

  onChangeCompany(onChange) {
    chooseCompany = onChange;
    print(chooseCompany);
    emit(ChangeCompanyDropDownState());
  }
//Nationality
  String? chooseNationality;
  late NationalityModel nationalityModel;
  bool isGetNationality = false;
getAllNationality(){
  isGetNationality = false;
  emit(GetAllNationalityLoadingState());
  DioHelper.getData(url: 'https://murshidguide.com/api/listNationality').then((value) {
    print(value.data);
    nationalityModel=NationalityModel.fromJson(value.data);
    emit(GetAllNationalitySuccessState());
    isGetNationality = true;
  }).catchError((error){
    print(error.toString());
    emit(GetAllNationalityErrorState(error: error.toString()));
  });
}
  onChangeNationalityName(onChange) {
    chooseNationality = onChange;
    print(chooseNationality);
    emit(ChangeNationalityDropDownState());
  }





  //Disability

  String? chooseDisability;
  List<String> disabilities = [
    LocaleKeys.hearing_disability.tr(),
    LocaleKeys.mental_disabilities.tr(),
    LocaleKeys.visual_disability.tr(),
    LocaleKeys.motor_and_physical_disabilities.tr(),

  ];
  bool isDisability = false;

  changeDisabilityValue() {
    isDisability = !isDisability;
    print('///////////////////////////$isDisability');
    emit(ChangeDisabilitySwitchValueState());
  }
  onChangeDisability(onChange) {
    chooseDisability = onChange;
    print(isDisability);
    print('//////////////fffffffffffffffff$chooseDisability');
    print('//////////////fffffffffffffffff$isDisability');
    emit(ChangeDisabilityDropDownState());
  }

//Residence
  String? chooseResidence;
  List<Map<String, dynamic>> residence = [
    {'id': 1, 'residenceName': 'مكه'},
    {'id': 2, 'residenceName': 'المدينه'}
  ];

  onChangeResidence(onChange) {
    chooseResidence = onChange;
    print('object: $chooseResidence');
    emit(ChangeResidenceDropDownState());
  }

  //chooseDateTime
 // String? convertedDateDepurat;
  var dateDep;

  chooseDateTimeDepuration({required BuildContext context,required TextEditingController controller}) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        initialDate: DateTime.now(),
        lastDate: DateTime(3100));

    if (date != null) {
      print(date);
      dateDep = date;
    }
    controller.text =
    "${date?.year.toString()}-${date?.month.toString().padLeft(2, '0')}-${date
        ?.day.toString().padLeft(2, '0')}";
    print(controller.text);
  //  controller.text=convertedDateDepurat!;
  //   DateTime string = DateTime.parse(convertedDateDepurat!);
  //   print("DateTime $string");
    emit(ChooseDateOfBirthState());
  }

  //String? convertedDateTimeBirth;
  var dateBirth;

  Future chooseDateTimeForBirth({required BuildContext context,required TextEditingController controller}) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: DateTime(1900),
        lastDate: DateTime(3100));
    if (date != null) {
      print(date);
      dateBirth = date;
    }
    controller.text =
    "${date?.year.toString()}-${date?.month.toString().padLeft(2, '0')}-${date
        ?.day.toString().padLeft(2, '0')}";
    print(controller.text);
    //controller.text=convertedDateTimeBirth!;
    print('controller ${controller.text}');
    emit(ChooseDateOfBirthState());
  }

  //String? convertedDateTimeArrival;
  var dateArrival;

  chooseDateTimeForArrival({required BuildContext context,required TextEditingController controller}) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(2023),
        initialDate: DateTime.now(),
        lastDate: DateTime(3100));
    if (date != null) {
      print(date);
      dateArrival = date;
    }
    controller.text =
    "${date?.year.toString()}-${date?.month.toString().padLeft(2, '0')}-${date
        ?.day.toString().padLeft(2, '0')}";
    print(controller.text);
  //  controller.text=convertedDateTimeArrival!;
    emit(ChooseDateOfBirthState());
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
  String address = '';

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
    lat = latLn?.latitude;
    lng = latLn?.longitude;
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
      lat = position?.latitude;
      lng = position!.longitude;

      print('$lat ////// $lng');
      emit(GetCurrentLocationSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GetCurrentLocationErrorState(
        error: e.toString(),
      ));
    }
  }

  getStringAddress({required int i, required TextEditingController controller}) {
    if (i == 0) {
      controller.clear();
      meenaLoc = addressFromMap;
      controller.text=addressFromMap;
      latMinna = lat;
      lngMinna = lng;
      emit(ChangeAddressState());
      print('controller ${controller.text}');
      addressFromMap = '';
    } else if (i == 1) {
      controller.clear();
      arafaLoc = addressFromMap;
      controller.text=addressFromMap;
      latArafa = lat;
      lngArafa = lng;
      emit(ChangeAddressState());
      print('controller ${controller.text}');
      addressFromMap = '';
    } else if (i == 3) {
      controller.clear();
      reportLocation = addressFromMap;
      controller.text=addressFromMap;
      print('controller ${controller.text}');
      emit(ChangeAddressState());
      addressFromMap = '';
    } else if (i == 4) {
      controller.clear();
      maccaHotelLocation = addressFromMap;
      controller.text=addressFromMap;
      latMaccaHotel = lat;
      lngMaccaHotel = lng;
      print('controller ${controller.text}');
      emit(ChangeAddressState());
      addressFromMap = '';
    } else if (i == 5) {
      controller.clear();
      madinaHotelLocation = addressFromMap;
      controller.text=addressFromMap;
      latMadinaHotel = lat;
      lngMadinaHotel = lng;
      print('controller ${controller.text}');
      emit(ChangeAddressState());
      addressFromMap = '';
    } else {
      controller.clear();
      mozdalifaLoc = addressFromMap;
      controller.text=addressFromMap;
      latMozdalifa = lat;
      lngMozdalifa = lng;
      emit(ChangeAddressState());
      print('controller ${controller.text}');
      addressFromMap = '';

    }
  }

  File? file;
  bool isPickImage = false;

  Future pickImageFromCamera() async {
    final XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.camera);
    file = (File(pickedFile!.path));
    print('IMAGE IS $file');
    emit(PickImageFromCameraState());
    isPickImage = true;
    print('afasdasdasds$isPickImage');
  }

  Future pickImageFromGallery() async {
    final XFile? pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    file = (File(pickedFile!.path));
    print('IMAGE IS $file');
    emit(PickImageFromGalleryState());
    isPickImage = true;
    print('afasdasdasds$isPickImage');
  }
  bool registerLoading = false;
  late LoginModel loginModel;

  hajjiRegister({
    required String nameAr,
    required String nameEn,
    required String phoneNumber,
    // required String birthDate,
    //  required String nationality,
    required String email,
    required String visaNo,
    required String passportNo,
    required String borderNo,
    required String maccaHotelName,
    required String madinahHotelName,
    required String dateOfBirth,
    required String dateOfArrival,
    required String dateOfDeparture,
    required var password,
    required var confirmPassword,
    required File imageFile}) async {
    emit(RegisterLoadingState());
    registerLoading = false;
    try {
      Dio dio = Dio();
      String apiUrl = 'https://murshidguide.com/api/pilgrims/register';
      FormData formData = FormData.fromMap({
        'name_ar':nameAr,
        'name_en':nameEn,
        'phone_number': phoneNumber,
        'nationality': chooseNationality,
        'birthdate': dateOfBirth,
        'email': email,
        'visa_number': visaNo,
        'passport_number': passportNo,
        'border_number': borderNo,
        'arrival_date': dateOfArrival,
        'departure_date': dateOfDeparture,
        'latitude_mina': latMinna,
        'longitude_mina': lngMinna,
        'location_mina': meenaLoc,
        'latitude_mozdalifa': latMozdalifa,
        'longitude__mozdalifa': lngMozdalifa,
        'location_mozdalifa': mozdalifaLoc,
        'latitude_arfat': latArafa,
        'longitude__arfat': lngArafa,
        'location_arfat': arafaLoc,
        'type_of_disability': isDisability ? chooseDisability : 'لاشيئ',
        'agent_name': 'chooseCompany',
        'password': password,
        'disability':isDisability?1:0,
        'password_confirmation': confirmPassword,
        'image': isPickImage
            ? await MultipartFile.fromFile(imageFile.path,
            filename: 'image.jpg')
            : null,
        'company_id': chooseCompany,
        'location_makkah_hotel':maccaHotelLocation,
        'location_madinah_hotel':madinaHotelLocation,
        'hotel_madinah':madinahHotelName,
        'hotel_makkah':maccaHotelName,
        'latitude_makkah':latMaccaHotel,
        'longitude__makkah':lngMaccaHotel,
        'latitude_madinah':latMadinaHotel,
        'longitude__madinah':lngMadinaHotel,
      });
      Response userRegister = await dio.post(apiUrl, data: formData);
      loginModel = LoginModel.fromJson(userRegister.data);
      print('tokeeeen ${loginModel.token}');

      token = CacheHelper.saveData(key: 'token', value: loginModel.token);
      token = CacheHelper.getData(key: 'token');
     print('isDisability  /////////////// $isDisability');

      emit(RegisterSuccessState());
      print('object $token');
      print('FIRE $fcmToken');
      registerLoading = true;
      navigateForwardReplace(MainScreen());
      sendFcmToken();
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data['message']}');
        print('HEADERS: ${e.response?.headers}');
         showToast(text: e.response?.data['message'], state: ToastState.ERROR);
      } else {
        print('Error sending request!');
        print('/////////////////////// ${e.message}');
      }
      emit(RegisterErrorState(error: e.toString()));
    }
    return loginModel;
  }
  sendFcmToken() {
    emit(SendFcmTokenLoadingState());
    DioHelper.postData(
        url: 'https://murshidguide.com/api/pilgrims/fcm-token',
        data: {
          'fcm_token': fcmToken,
        },
        token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value.data);

      emit(SendFcmTokenSuccessState());
      //  getProfileDate();
    }).catchError((error) {
      print(error.toString());
      emit(SendFcmTokenErrorState(error: error.toString()));
    });
  }
///moetamer
  moetamerRegister({
    required String nameAr,
    required String nameEn,
    required String phoneNumber,
    // required String birthDate,
    //  required String nationality,
    required String email,
    required String visaNo,
    required String passportNo,
    required String borderNo,
    required String maccaHotelName,
    required String madinahHotelName,
    required String dateOfBirth,
    required String dateOfArrival,
    required String dateOfDeparture,
    required var password,
    required var confirmPassword,
    required File imageFile}) async {
    emit(RegisterLoadingState());
    registerLoading = false;
    try {
      Dio dio = Dio();
      String apiUrl = 'https://murshidguide.com/api/pilgrimsumrah/register';
      FormData formData = FormData.fromMap({
        'name_ar':nameAr,
        'name_en':nameEn,
        'phone_number': phoneNumber,
        'nationality': chooseNationality,
        'birthdate': dateOfBirth,
        'email': email,
        'visa_number': visaNo,
        'passport_number': passportNo,
        'border_number': borderNo,
        'arrival_date': dateOfArrival,
        'departure_date': dateOfDeparture,
        // 'latitude_mina': latMinna,
        // 'longitude_mina': lngMinna,
        // 'location_mina': meenaLoc,
        // 'latitude_mozdalifa': latMozdalifa,
        // 'longitude__mozdalifa': lngMozdalifa,
        // 'location_mozdalifa': mozdalifaLoc,
        // 'latitude_arfat': latArafa,
        // 'longitude__arfat': lngArafa,
        // 'location_arfat': arafaLoc,
        'type_of_disability': isDisability ? chooseDisability : 'لاشيئ',
        'agent_name': 'chooseCompany',
        'password': password,
        'disability':isDisability?1:0,
        'password_confirmation': confirmPassword,
        'image': isPickImage
            ? await MultipartFile.fromFile(imageFile.path,
            filename: 'image.jpg')
            : null,
        'company_id': chooseCompany,
        'location_makkah_hotel':maccaHotelLocation,
        'location_madinah_hotel':madinaHotelLocation,
        'hotel_madinah':madinahHotelName,
        'hotel_makkah':maccaHotelName,
        'latitude_makkah':latMaccaHotel,
        'longitude__makkah':lngMaccaHotel,
        'latitude_madinah':latMadinaHotel,
        'longitude__madinah':lngMadinaHotel,
      });
      Response userRegister = await dio.post(apiUrl, data: formData);
      loginModel = LoginModel.fromJson(userRegister.data);
      print('tokeeeen ${loginModel.token}');

      token = CacheHelper.saveData(key: 'token', value: loginModel.token);
      accountTypeName=CacheHelper.saveData(key: 'accountTypeName', value: loginModel.data!.accountType);
      accountTypeName=CacheHelper.getData(key: 'accountTypeName');
      token = CacheHelper.getData(key: 'token');
      print('isDisability  /////////////// $isDisability');


      emit(RegisterSuccessState());
      print('<<<<<<<<<<<<<<<<<<<$token>>>>>>>>>>>>>>>>>>>');
      print('<<<<<<<<<<<<<<<<<<<$accountTypeName>>>>>>>>>>>>>>>>>>>');
      print('FIRE $fcmToken');
      registerLoading = true;
      navigateForwardReplace(MainScreen());
      sendFcmTokenMoetamer();
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data['message']}');
        print('HEADERS: ${e.response?.headers}');
        showToast(text: e.response?.data['message'], state: ToastState.ERROR);
      } else {
        print('Error sending request!');
        print('/////////////////////// ${e.message}');
      }
      emit(RegisterErrorState(error: e.toString()));
    }
    return loginModel;
  }
  sendFcmTokenMoetamer() {
    emit(SendFcmTokenLoadingState());
    DioHelper.postData(
        url: 'https://murshidguide.com/api/pilgrimsumrah/fcm-token',
        data: {
          'fcm_token': fcmToken,
        },
        token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value.data);

      emit(SendFcmTokenSuccessState());
      //  getProfileDate();
    }).catchError((error) {
      print(error.toString());
      emit(SendFcmTokenErrorState(error: error.toString()));
    });
  }





  bool isVisable = true;

  void changeVisabilityState() {
    isVisable = !isVisable;
    emit(ChangeVisabilityState());
  }
}
