import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:morshed/bloc/show_office_provider_info/state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/tranlations/locale_keys.g.dart';
import 'package:morshed/utiels/dio_helper.dart';

import '../../constant/const_color.dart';
import '../../models/api_model/get_all_offices.dart';
import '../../models/api_model/provider_model.dart';
import '../../utiels/socket.dart';

class ShowOfficesAndProviderInfoCubit
    extends Cubit<ShowOfficesAndProviderInfoState> {
  ShowOfficesAndProviderInfoCubit() : super(InitialShowDataState());

  static ShowOfficesAndProviderInfoCubit get(context) =>
      BlocProvider.of(context);
  int index = 0;

  changeTabBarIndex({required var value}) {
    index = value;
    emit(ChangeTabBarState());
  }

  late GetAllOffices getAllOffices;
  bool isGetOfficesData = false;
  var myIcon;
  int tabbed = 00;
  int officeId=0;
  getAllOfficesData() {
    officeMarkers = [];
    tabbed = 00;
    officeId=0;
    isGetOfficesData = false;
    emit(GetAllOfficesDataLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/getoffices')
        .then((value) {
      tabbed = 00;
      officeId=0;
      print(value.data);
      getAllOffices = GetAllOffices.fromJson(value.data);
      emit(GetAllOfficesDataSuccessState());
      addMarkerOffice();
      isGetOfficesData = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetAllOfficesDataErrorState(error: error.toString()));
    });
  }
  searchOffices({required String keyWord}) {
    officeMarkers = [];
    tabbed = 00;
    officeId=0;
    isGetOfficesData = false;
    emit(SearchOfficesLoadingState());
    DioHelper.postData(
        url: 'https://murshidguide.com/api/searchOffice',
        token: token,
        data: {'name': keyWord}).then((value) {
      print(value.data);
     // tabbed = 00;
      getAllOffices = GetAllOffices.fromJson(value.data);
      emit(SearchOfficesSuccessState());
      addMarkerOffice();
      isGetOfficesData = true;

    }).catchError((error) {
      print(error.toString());
      showToast(text: LocaleKeys.no_office_found.tr(), state: ToastState.ERROR);
      isGetOfficesData = true;
      emit(SearchOfficesErrorState(error: error.toString()));

    });
  }

  List<Marker> officeMarkers = [];

  addMarkerOffice() async {
    officeMarkers=[];
    for (var data in getAllOffices.offices!) {
      final marker = Marker(
          icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(10, 10)),
              'assets/images/office_navigation.png'),
          markerId: MarkerId(data.id.toString()),
          position: LatLng(data.latitude!, data.longitude!),
          onTap: () {
            changeTapMarker(id: data.id!);
          });
      officeMarkers.add(marker);
    }
    emit(FullMarkListState());
  }



  changeTapMarker({
    required int id,
  }) {
    officeId = getAllOffices.offices!.indexWhere((element) => element.id == id);
    print('indexx $officeId');
    tabbed = id;
    print('tabbed $tabbed');
    emit(ChangeTabbedMarkerState());
  }

  late GetProvidersModel getProvidersModel;
  final StreamController<GetProvidersModel> _dataStreamController =
      StreamController.broadcast();

  Stream<GetProvidersModel> get dataStream => _dataStreamController.stream;
  List<Marker> providerMarkers = [];

  getDataProvider() {
    DioHelper.getData(
      url: 'https://murshidguide.com/api/pilgrims/getproviders',
      token: token,
    ).then((value) async {
      getProvidersModel = GetProvidersModel.fromJson(value.data);
      print(
          '/////////////////emit////////////${value.data}/////////////////////////////////');
      _dataStreamController.add(getProvidersModel);
      for (var data in getProvidersModel.providers!) {
        final marker = Marker(
            icon: await BitmapDescriptor.fromAssetImage(
                ImageConfiguration(size: Size(10, 10)),
                'assets/images/marker.png'),
            markerId: MarkerId(data.id.toString()),
            position: LatLng(double.parse(data.lat!), double.parse(data.lng!)),
            onTap: () {
              changeTapMarkerProvider(id: data.id!);
            });
        providerMarkers.add(marker);
      }
    }).catchError((e) {
      print('$e : //////////////////////////////////////////////');
    });
  }

  // final providerLocationService = ProviderLocationService();
  int providerTab = 00;
  int? providerId;

  changeTapMarkerProvider({
    required int id,
  }) {
    providerId =
        getProvidersModel.providers!.indexWhere((element) => element.id == id);
    print('indexx $providerId');
    providerTab = id;
    print('tabbed $tabbed');
    emit(ChangeTabbedMarkerState());
  }


}
