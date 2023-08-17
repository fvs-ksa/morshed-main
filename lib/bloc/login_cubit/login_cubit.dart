
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/login_cubit/login_state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/models/api_model/profile_model.dart';
import 'package:morshed/utiels/dio_helper.dart';
import 'package:morshed/utiels/shared_pref.dart';
import '../../component/navigation_functions.dart';
import '../../models/api_model/login_model.dart';
import '../../screen/bottom_navigations_screens/main_screen.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  bool isVisable=true;
  void changeVisabilityState() {
    isVisable = !isVisable;
    emit(ChangeVisabilityState());
  }
  HajjiLogin({required String email, required String password}) async{
    emit(LoginLoadingState());
    try {
      Response userData = await DioHelper.postData(
          url: 'https://murshidguide.com/api/pilgrims/login',
          data: {
            'email': email,
            'password': password,
          });
      loginModel = LoginModel.fromJson(userData.data);
      token = CacheHelper.saveData(key: 'token', value: loginModel.token!);
      accountTypeName=CacheHelper.saveData(key: 'accountTypeName', value: loginModel.data!.accountType);
      // fcmToken=CacheHelper.saveData(key: 'fcmToken', value: loginModel.user.to)
      emit(LoginSuccessState());
      navigateForwardReplace(MainScreen());
      token=CacheHelper.getData(key: 'token');
      accountTypeName=CacheHelper.getData(key: 'accountTypeName');
      print('<<<<<<<<<<<<<<<<$token>>>>>>>>>>>>>>>>');
      print('<<<<<<<<<<<<<<<<$accountTypeName>>>>>>>>>>>>>>>>');
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
      emit(LoginErrorState(error: e.toString()));
    }
    // DioHelper.postData(
    //     url: 'https://murshidguide.com/api/pilgrims/login',
    //     data: {
    //       'password': password,
    //       'email': email,
    //     }).then((value) {
    //   print(value.data);
    //   loginModel = LoginModel.fromJson(value.data);
    //   token = CacheHelper.saveData(key: 'token', value: loginModel.token!);
    //   accountTypeName=CacheHelper.saveData(key: 'accountTypeName', value: loginModel.data!.accountType);
    //  // fcmToken=CacheHelper.saveData(key: 'fcmToken', value: loginModel.user.to)
    //   emit(LoginSuccessState());
    //   navigateForwardReplace(MainScreen());
    //   token=CacheHelper.getData(key: 'token');
    //   accountTypeName=CacheHelper.getData(key: 'accountTypeName');
    //   print('<<<<<<<<<<<<<<<<$token>>>>>>>>>>>>>>>>');
    //   print('<<<<<<<<<<<<<<<<$accountTypeName>>>>>>>>>>>>>>>>');
    //   sendFcmToken();
    //  // getProfileDate();
    // }).catchError((error) {
    //   print(error.toString());
    //   showToast(text: 'برجاء التأكد من البيانات المدخله', state: ToastState.ERROR);
    //   emit(LoginErrorState(error: error.toString()));
    // });
  }

  late ProfileModel profileModel;
getProfileDate(){
    emit(GetProfileLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/pilgrims/show',token: token).then((value) {
      print(value.data);
      profileModel=ProfileModel.fromJson(value.data);
      emit(GetProfileSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetProfileErrorState(error: error.toString()));
    });
  }
  sendFcmToken() {
    emit(SendFcmTokenLoadingState());
    DioHelper.postData(url: 'https://murshidguide.com/api/pilgrims/fcm-token', data: {
      'fcm_token': fcmToken,
    },
        token: CacheHelper.getData(key: 'token')
    ).then((value) {
      print(value.data);

      emit(SendFcmTokenSuccessState());
    //  getProfileDate();
    }).catchError((error) {
      print(error.toString());
      emit(SendFcmTokenErrorState(error: error.toString()));
    });
  }


  ///moetamer
  moetamerLogin({required String email, required String password})async {
    emit(LoginMoetamerLoadingState());
    try {
      Response userData = await DioHelper.postData(
          url: 'https://murshidguide.com/api/pilgrimsumrah/login',
          data: {
            'email': email,
            'password': password,
          });
      loginModel = LoginModel.fromJson(userData.data);

      token = CacheHelper.saveData(key: 'token', value: loginModel.token!);
      accountTypeName=CacheHelper.saveData(key: 'accountTypeName', value: loginModel.data!.accountType);
      emit(LoginMoetamerSuccessState());
      navigateForwardReplace(MainScreen());
      token=CacheHelper.getData(key: 'token');
      accountTypeName=CacheHelper.getData(key: 'accountTypeName');
      print('<<<<<<<<<<<<<<<<$token>>>>>>>>>>>>>>>>');
      print('<<<<<<<<<<<<<<<<$accountTypeName>>>>>>>>>>>>>>>>');
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
      emit(LoginMoetamerErrorState(error: e.toString()));
    }
    // DioHelper.postData(
    //     url: 'https://murshidguide.com/api/pilgrimsumrah/login',
    //     data: {
    //       'password': password,
    //       'email': email,
    //     }).then((value) {
    //   print(value.data);
    //   loginModel = LoginModel.fromJson(value.data);
    //   token = CacheHelper.saveData(key: 'token', value: loginModel.token!);
    //   accountTypeName=CacheHelper.saveData(key: 'accountTypeName', value: loginModel.data!.accountType);
    //   emit(LoginMoetamerSuccessState());
    //
    //   navigateForwardReplace(MainScreen());
    //   token=CacheHelper.getData(key: 'token');
    //   accountTypeName=CacheHelper.getData(key: 'accountTypeName');
    //   print('<<<<<<<<<<<<<<<<$token>>>>>>>>>>>>>>>>');
    //   print('<<<<<<<<<<<<<<<<$accountTypeName>>>>>>>>>>>>>>>>');
    //   sendFcmToken();
    //   // getProfileDate();
    // }).catchError((error) {
    //   print(error.toString());
    //   showToast(text: 'برجاء التأكد من البيانات المدخله', state: ToastState.ERROR);
    //   emit(LoginMoetamerErrorState(error: error.toString()));
    // });
  }

  sendFcmTokenMoetamer() {
    emit(SendFcmTokenLoadingState());
    DioHelper.postData(url: 'https://murshidguide.com/api/pilgrimsumrah/fcm-token', data: {
      'fcm_token': fcmToken,
    },
        token: CacheHelper.getData(key: 'token')
    ).then((value) {
      print(value.data);

      emit(SendFcmTokenSuccessState());
      //  getProfileDate();
    }).catchError((error) {
      print(error.toString());
      emit(SendFcmTokenErrorState(error: error.toString()));
    });
  }
}
