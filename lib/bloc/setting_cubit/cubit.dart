import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/setting_cubit/state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/utiels/shared_pref.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(InitialSettingState());

  static SettingCubit get(context) => BlocProvider.of(context);

  // bool isEnglish=false;
  changeLanguage(BuildContext context) {
    if (isEnglish == false) {
      isEnglish = !isEnglish!;
      context.setLocale(const Locale('en'));
      myLocale = context.locale.languageCode;
      CacheHelper.saveData(key: 'isEnglish', value: isEnglish);

      print('ISENGLISH :$isEnglish ');
      print('myLocale $myLocale');
      emit(SetLanguageENState());
     // Phoenix.rebirth(context);
     // navigateForwardReplace(SecondSplash());
    } else {
      isEnglish = !isEnglish!;
      context.setLocale(const Locale('ar'));
      myLocale = context.locale.languageCode;
      CacheHelper.saveData(key: 'isEnglish', value: isEnglish);
      print('ISArabic :$isEnglish ');
      print('myLocale $myLocale');
      emit(SetLanguageARState());

     // navigateForwardReplace(SecondSplash());
    }

  }
}
