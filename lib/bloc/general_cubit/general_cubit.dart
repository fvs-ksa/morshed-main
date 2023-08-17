import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:morshed/bloc/general_cubit/general_state.dart';
import 'package:morshed/models/api_model/profile_model.dart';
import 'package:morshed/screen/bottom_navigations_screens/home_screen.dart';
import 'package:morshed/screen/bottom_navigations_screens/more_screen.dart';
import 'package:morshed/screen/bottom_navigations_screens/notification_screen.dart';
import 'package:morshed/screen/bottom_navigations_screens/qr_screen.dart';
import 'package:morshed/utiels/dio_helper.dart';
import 'package:morshed/utiels/shared_pref.dart';
import '../../constant/const_color.dart';
import '../../screen/bottom_navigations_screens/my_residence_and_travels.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(InitialGeneralState());

  static GeneralCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const HomeScreen(),
    const NotificationsScreen(),
    const QrScreen(),
    const MyResidenceAndTravels(),
    //SupportScreen(),
    const MoreScreen(),
  ];
  int currentIndex = 0;

  changeCurrentScreen(int i) {
    currentIndex = i;
    emit(ChangeBottomNavigationBarState());

  }
  void initialization() async {
    await Future.delayed(const Duration(milliseconds: 300));
    FlutterNativeSplash.remove();
    // token==null?navigateForward(BoardingScreen()):navigateForward(MainScreen());
    emit(RemoveNativeSplashState());
    getProfileDate();

  }
  late ProfileModel profileModel;
  bool isGetProfile=false;
  getProfileDate()async{
    isGetProfile=false;
    emit(GetProfileLoadingState());
  await  DioHelper.getData(url: 'https://murshidguide.com/api/pilgrims/show',
      token: CacheHelper.getData(key: 'token')).then((value) {
      print(value.data);
      profileModel=ProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
      isGetProfile=true;
    }).catchError((error){
      print(error.toString());
      emit(GetProfileErrorState(error: error.toString()));
    });
  }
}
