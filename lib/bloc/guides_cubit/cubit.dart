import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/guides_cubit/state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/models/api_model/provider_model.dart';
import 'package:morshed/utiels/dio_helper.dart';

import '../../utiels/shared_pref.dart';

class GuidesCubit extends Cubit<GuidesState> {
  GuidesCubit() : super(InitialGuidesState());

  static GuidesCubit get(context) => BlocProvider.of(context);
  String? flag;
  List<Map<String, dynamic>> flags = [
    {
      "id": 1,
      "flag": 'assets/images/saudia.png',
    },
    {
      "id": 2,
      "flag": 'assets/images/amrica.png',
    }
  ];

  onChangeFlagsSearch(onChange) {
    flag = onChange;
    emit(ChangeFlagsSearchState());
  }

  late GetProvidersModel getProvidersModel;
  bool isProvidersGet = false;

  getAllGuides() {
    isProvidersGet = false;
    emit(GetProviderLoadingState());
    DioHelper.getData(
            url: 'https://murshidguide.com/api/pilgrims/getproviders',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      getProvidersModel = GetProvidersModel.fromJson(value.data);
      emit(GetProviderSuccessState());
      isProvidersGet = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetProviderErrorState(error: error.toString()));
    });
  }

  searchProvider({required String name, required String langId}) {
    isProvidersGet = false;
    emit(SearchProviderLoadingState());
    DioHelper.postData(
        url: 'https://murshidguide.com/api/pilgrims/searchProviders',
        token: token,
        data: {'keyword': name, 'preferred_language': langId}).then((value) {
      print(value.data);
      getProvidersModel = GetProvidersModel.fromJson(value.data);
      emit(SearchProviderSuccessState());
      isProvidersGet = true;
    }).catchError((error) {
      print(error.toString());
      emit(SearchProviderErrorState(error: error.toString()));
    });
  }
}
