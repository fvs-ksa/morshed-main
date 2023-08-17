import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/notification_cubit/state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/models/api_model/notification_model.dart';
import 'package:morshed/utiels/dio_helper.dart';

import '../../constant/const_color.dart';
import '../../utiels/shared_pref.dart';

class NotificationCubit extends Cubit<NotificationState>{
  NotificationCubit():super(InitialNotificationState());
  static NotificationCubit get(context)=>BlocProvider.of(context);
  late GetNotificationModel getNotificationModel;
  bool isNotificationGet=false;
  getNotificationData(){
    isNotificationGet=false;
    emit(GetNotificationLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/pilgrims/getnotifications',
        token: CacheHelper.getData(key: 'token')).then((value) {
          getNotificationModel=GetNotificationModel.fromJson(value.data);
          emit(GetNotificationSuccessState());
          isNotificationGet=true;
        //  changeNotificationStatus();
    }).catchError((error){
      emit(GetNotificationErrorState(error: error.toString()));
    });
  }
  markNotificationAsRead({required int id}){
    DioHelper.postData(url: 'https://murshidguide.com/api/pilgrims/notifications/$id/mark-as-read',token: token).then((value) {
      print(value.data);
      showToast(text: value.data['message'], state: ToastState.SUCCESS);
    }).catchError((error){
      print(error.toString());
    });
  }
  // changeNotificationStatus(){
  // DioHelper.postData(url: 'https://murshidguide.com/api/')
  // }
}