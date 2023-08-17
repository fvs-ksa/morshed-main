import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/another_services_cubit/about_us_cubit/state.dart';
import 'package:morshed/models/api_model/about_Model.dart';
import 'package:morshed/utiels/dio_helper.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(InitialAboutUsState());

  static AboutUsCubit get(context) => BlocProvider.of(context);
late AboutModel aboutModel;
  getAboutUsInfo() {
    emit(GetAboutInfoLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/about')
        .then((value) {
          print(value.data);
          aboutModel=AboutModel.fromJson(value.data);
          emit(GetAboutInfoSuccessState());
    })
        .catchError((error) {
          print(error.toString());
          emit(GetAboutInfoErrorState(error: error.toString()));
    });
  }
}
