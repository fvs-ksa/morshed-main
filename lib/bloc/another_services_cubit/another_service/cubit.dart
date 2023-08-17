import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/another_services_cubit/another_service/state.dart';
import 'package:morshed/models/api_model/Harameen_services_model.dart';
import 'package:morshed/models/api_model/info_guide_model.dart';
import 'package:morshed/models/api_model/info_hajji_model.dart';
import 'package:morshed/models/api_model/transportation_model.dart';
import 'package:morshed/utiels/dio_helper.dart';

class AnotherServicesCubit extends Cubit<AnotherServicesState> {
  AnotherServicesCubit() : super(InitialAnotherServicesState());

  static AnotherServicesCubit get(context) => BlocProvider.of(context);
 late TransportationModel transportationModel;
 bool isGetTransportation=false;
  getTransportation() {
    isGetTransportation=false;
    emit(GetTransportationLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/listTransportation')
        .then((value) {
      print(value.data);
      transportationModel=TransportationModel.fromJson(value.data);
      emit(GetTransportationSuccessState());
      isGetTransportation=true;
    }).catchError((error) {
      print(error.toString());
      emit(GetTransportationErrorState(error: error.toString()));
    });
  }


  bool isGetHarameenServices=false;
  late HarameenServicesModel harameenServicesModel;
  getHarameenServices() {
    isGetHarameenServices=false;
    emit(GetTransportationLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/listServicesMosques')
        .then((value) {
      print(value.data);
      harameenServicesModel=HarameenServicesModel.fromJson(value.data);
      emit(GetTransportationSuccessState());
      isGetHarameenServices=true;
    }).catchError((error) {
      print(error.toString());
      emit(GetTransportationErrorState(error: error.toString()));
    });
  }

  bool isGetinfoHajji=false;
  late InfoHajjiModel infoHajjiModel;
  getInfoHajjiServices() {
    isGetinfoHajji=false;
    emit(GetTransportationLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/listInfo')
        .then((value) {
      print(value.data);
      infoHajjiModel=InfoHajjiModel.fromJson(value.data);
      emit(GetTransportationSuccessState());
      isGetinfoHajji=true;
    }).catchError((error) {
      print(error.toString());
      emit(GetTransportationErrorState(error: error.toString()));
    });
  }

  bool isGetinfoGuide=false;
  late InfoGuideModel infoGuideModel;
  getInfoGuideServices() {
    isGetinfoGuide=false;
    emit(GetTransportationLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/listGuide')
        .then((value) {
      print(value.data);
      infoGuideModel=InfoGuideModel.fromJson(value.data);
      emit(GetTransportationSuccessState());
      isGetinfoGuide=true;
    }).catchError((error) {
      print(error.toString());
      emit(GetTransportationErrorState(error: error.toString()));
    });
  }


}
