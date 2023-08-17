import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/profile_cubit/state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/navigation_functions.dart';
import 'package:morshed/screen/borading_screen/boarding_screen.dart';
import '../../models/api_model/profile_model.dart';
import '../../models/nationality_model.dart';
import '../../tranlations/locale_keys.g.dart';
import '../../utiels/dio_helper.dart';
import '../../utiels/shared_pref.dart';
import 'dart:io';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitialProfileState());

  static ProfileCubit get(context) => BlocProvider.of(context);


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
    emit(ChangeNationalityDropDownProfileState());
  }

  String? chooseDisability;
  List<String> disabilities = [
   // LocaleKeys.hea
    LocaleKeys.hearing_disability.tr(),
    LocaleKeys.mental_disabilities.tr(),
    LocaleKeys.visual_disability.tr(),
    LocaleKeys.motor_and_physical_disabilities.tr(),
  ];
  onChangeDisability(onChange) {
    chooseDisability = onChange;
    print('//////////////fffffffffffffffff$chooseDisability');
    emit(ChangeDisabilityDropDownState());
  }




  String? convertedDateTime;
  DateTime? dateTime;

  chooseDateTime({required BuildContext context}) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: DateTime(1900),
        lastDate: DateTime(3100));
    if (date != null) {
      print(date);
      dateTime=date;
    }
    convertedDateTime =
    "${date?.year.toString()}-${date?.month.toString().padLeft(2, '0')}-${date
        ?.day.toString().padLeft(2, '0')}";
    print(convertedDateTime);
    emit(ChooseDateOfBirthProfileState());
  }

  late ProfileModel profileModel;
  bool isLoading = false;

  getProfileDate() {
    getAllNationality();
    isLoading = false;
    emit(GetProfileLoadingState());
    DioHelper.getData(
        url: 'https://murshidguide.com/api/pilgrims/show',
        token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value.data);
      profileModel = ProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
      isLoading = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetProfileErrorState(error: error.toString()));
    });
  }

  updateUserInfo({
    required String nameAr,
    required String nameEn,
    required String phone,
   String? birthDate,
   String? nationality,
     String? locationMenna,
    required String email,
    required String passport,
    required BuildContext context,
    required String visaNo,
   String? borderNo,
    String? disabilityType,
     String? agentName,
     File? image }) {
    emit(UpdateProfileLoadingState());
    // DateTime birth=DateTime.parse(profileModel.data!.birthdate!);
    // DateTime arrival=DateTime.parse(profileModel.data!.birthdate!);
    // DateTime dapuration=DateTime.parse(profileModel.data!.departureDate!);
    DioHelper.postData(
      data: {
        "name_en":nameEn,
        "name_ar":nameAr,
        "phone_number":phone,
        "nationality":chooseNationality??profileModel.data!.nationality,
       // "nationality":chooseNationality,
        "birthdate":convertedDateTime??profileModel.data!.birthdate,
        "email":email,
        "visa_number":visaNo,
        "passport_number":passport,
        "border_number":borderNo,
       // "arrival_date":'1900-01-29',
       // "departure_date":'1900-01-29',
        "arrival_date":profileModel.data!.arrivalDate,
        "departure_date":profileModel.data!.departureDate,
        "location_mina":profileModel.data!.locationMina,
        "location_mozdalifa":profileModel.data!.locationMozdalifa,
        "location_arfat":profileModel.data!.locationArfat,
        "type_of_disability":chooseDisability??profileModel.data!.typeOfDisability,
        "agent_name":agentName,

        //"image":image,
      },
            url:
                'https://murshidguide.com/api/pilgrims/update/${profileModel.data!.id}',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value.data);
      Navigator.pop(context);
      showToast(text:LocaleKeys.profile_update_successfully.tr() , state: ToastState.SUCCESS);
      emit(UpdateProfileSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateProfileErrorState(error: error.toString()));
      showToast(text:LocaleKeys.error_occurred.tr(), state: ToastState.ERROR);
      print(error.toString());
    });
  }
  logOut() {
    emit(LogOutLoadingState());
    DioHelper.postData(
        url: 'https://murshidguide.com/api/pilgrims/logout', token: CacheHelper.getData(key: 'token'))
        .then((value) {
          print(value.data);
          CacheHelper.removeData();
          emit(LogOutSuccessState());
          navigateForwardReplace(BoardingScreen());
          print('REMOVE TOKEN IS ${CacheHelper.getData(key: 'token')}');
    }

    )
        .catchError((error) {
      print(error.toString());
      emit(LogOutErrorState(error: error.toString()));
      showToast(text:LocaleKeys.logout_fail.tr(), state: ToastState.ERROR);
    });
  }
  int tabbed=00;
  int? officeId;





}
