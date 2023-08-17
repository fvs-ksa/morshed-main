import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/companions_cubit/state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/navigation_functions.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/models/api_model/companions_model.dart';
import 'package:morshed/screen/bottom_navigations_screens/main_screen.dart';
import 'package:morshed/utiels/dio_helper.dart';
import 'package:morshed/utiels/shared_pref.dart';

import '../../tranlations/locale_keys.g.dart';

class AddCompanionsCubit extends Cubit<AddCompanionsState> {
  AddCompanionsCubit() : super(InitialAddCompanionsState());

  static AddCompanionsCubit get(context) => BlocProvider.of(context);
 // String? convertedDateTime;
var dateBirth;
  chooseDateTime({required BuildContext context,required TextEditingController controller}) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: DateTime(1900),
        lastDate: DateTime(3100));
    if (date != null) {
      print(date);
      dateBirth=date;
    }
    controller.text =
        "${date?.year.toString()}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}";
    print(controller.text);

    emit(ChooseDateOfBirthState());
  }
  late GetMyCompanions getCompanions;
  TextEditingController searchController = TextEditingController();
  getMyCompanions(){
    emit(GetCompanionLoadingState());
    DioHelper.getData(
        url: 'https://murshidguide.com/api/pilgrims/companions',
        token: CacheHelper.getData(key: 'token'),
    search: searchController.text,
    ).then((value) {
      print(value.data);
      getCompanions=GetMyCompanions.fromJson(value.data);
      emit(GetCompanionSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetCompanionErrorState(error: error.toString()));
    });
  }

  addCompanions({required String passportNumber,required String date}) {
    emit(AddCompanionLoadingState());
    DioHelper.postData(
            url: 'https://murshidguide.com/api/pilgrims/addcompanions',
            data: {'passport_number': passportNumber,
              'birthdate':date},
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print(value.data);
      emit(AddCompanionSuccessState());
      navigateForwardPop(MainScreen());
      showToast(text:LocaleKeys.companions_Added_Successfully.tr(), state: ToastState.SUCCESS);
    }).catchError((e) {
      emit(AddCompanionErrorState(error: e.toString()));
      showToast(text:LocaleKeys.please_verify_date.tr() , state: ToastState.ERROR);
      print(e.toString());
    });
  }

}
