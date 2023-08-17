import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/another_services_cubit/terms_cubit/terms_state.dart';
import 'package:morshed/models/api_model/terms_model.dart';
import 'package:morshed/utiels/dio_helper.dart';

class TermsCubit extends Cubit<TermsState>{
  TermsCubit():super(InitialTermsState());
 static TermsCubit get(context)=>BlocProvider.of(context);
 late GetTermsModel getTermsModel;
 getTermsData(){
   emit(GetTermsLoadingState());
   DioHelper.getData(url: 'https://murshidguide.com/api/terms').then((value) {
     print(value.data);
     getTermsModel=GetTermsModel.fromJson(value.data);
     emit(GetTermsSuccessState());
   }).catchError((error){
     emit(GetTermsErrorState(error: error.toString()));
   });
 }
}