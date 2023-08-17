import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morshed/bloc/submitting_report/submit_report_state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/models/api_model/assistant_methods.dart';
import 'package:morshed/models/api_model/get_report_model.dart';
import 'package:morshed/models/api_model/profile_model.dart';
import 'package:morshed/tranlations/locale_keys.g.dart';
import 'package:morshed/utiels/dio_helper.dart';
import 'package:morshed/utiels/shared_pref.dart';
import '../../component/animation_component.dart';
import '../../component/navigation_functions.dart';
import '../../screen/bottom_navigations_screens/main_screen.dart';
import '../../screen/inner_screen/submit_report/reported_person_info.dart';
import '../location_cubit/cubit.dart';

class SubmitReportCubit extends Cubit<SubmitReportState> {
  SubmitReportCubit() : super(InitialSubmitReportState());

  static SubmitReportCubit get(context) => BlocProvider.of(context);
  int index = 0;

  changeTabBarIndex({required var value}) {
    index = value;
    emit(ChangeTabBarSubmitReportState());
  }

  ////////////////////////////_submit_report_another_person
 // String? chooseCountry;
  // var country = [
  //   'المملكه العربيه السعوديه',
  //   'جمهوريه مصر العربيه',
  //   'الجزائر',
  //   'اندونسيا',
  //   'الكويت',
  //   'باكستان',
  //   'تونس',
  // ];

  // onChangeCountryName(onChange) {
  //   chooseCountry = onChange;
  //   emit(ChangeNationalityReportState());
  // }

  String? sex;
    var sexList = [LocaleKeys.male.tr(), LocaleKeys.female.tr()];

  onChangeSex(onChange) {
    sex = onChange;
    emit(ChangeNationalityReportState());
  }

  late GetMyReportsModel getMyReportsModel;
  bool isGetMyReport = false;

  getMyReports() {
    isGetMyReport = false;
    emit(GetMyReportLoadingState());
    DioHelper.getData(
            url: 'https://murshidguide.com/api/pilgrims/getreports',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      getMyReportsModel = GetMyReportsModel.fromJson(value.data);
      print(value.data);
      emit(GetMyReportSuccessState());
      isGetMyReport = true;
    }).catchError((error) {
      print(error.toString());
      emit(GetMyReportErrorState(error: error.toString()));
    });
  }

  late AssistanceMethods assistanceMethods;
  bool isAssistanceWaysLoading = false;

  getAssistanceWays() {
    isAssistanceWaysLoading = false;

    emit(GetAssistanceWaysLoadingState());
    DioHelper.getData(url: 'https://murshidguide.com/api/assistance-methods')
        .then((value) {
      print(value.data);
      assistanceMethods = AssistanceMethods.fromJson(value.data);
      emit(GetAssistanceWaysSuccessState());
      isAssistanceWaysLoading = true;
    }).catchError((error) {
      emit(GetAssistanceWaysErrorState(error: error.toString()));
      print(error.toString());
    });
  }
  String? reportWaySolution;
  bool isChooseMethod=false;
  int selectedMethod=-1;
  changeCheckBox({required int i, bool onchange = false}){
    assistanceMethods.data?.forEach((element) {
       element.status=false;
    });
   // assistanceMethods.data![i].status=false;
   // onchange=true;
    selectedMethod=i;
  //  isChooseMethod=!onchange;
    assistanceMethods.data![selectedMethod].status = onchange;
    reportWaySolution=assistanceMethods.data![selectedMethod].name!;
    print('///////////////////////////$onchange');
    print('///////////////////////////$reportWaySolution');
    emit(ChangeHelpWayReportState());

  }

  selfReport(
      {required String assistanceMethod,
      required String details,
      required BuildContext context}) {
    emit(SelfReportLoadingState());
    DioHelper.postData(
        url: 'https://murshidguide.com/api/pilgrims/reports',
        token: CacheHelper.getData(key: 'token'),
        data: {
          'assistance_method': assistanceMethod,
          'report_details': details,
          'location': reportLocation == ''
              ? LocationCubit.get(context).address
              : reportLocation,
          'latitude': lat,
          'longitude': lng,
        }).then((value) {
      print(value.data);
      emit(SelfReportSuccessState());
      showToast(
          text:LocaleKeys.report_upload_successfully.tr() ,
          state: ToastState.SUCCESS);
      navigateForwardReplace(MainScreen());
    }).catchError((error) {
      print(error.toString());
      emit(SelfReportErrorState(error: error.toString()));
      showToast(
          text:LocaleKeys.report_failed_uploaded.tr() ,
          state: ToastState.ERROR);
    });
  }

  String code = 'Please Scan Qr';
  String error = "Can't scan Qrcode";

  Future ScanBarcode() async {
    try {
      // await BarcodeScanner.scan().t
      await BarcodeScanner.scan().then((barcodeResult) {
        //  print("flutter size:" + barcodeResult?.toString());
        if (barcodeResult != null && barcodeResult.rawContent.isNotEmpty) {
          print(barcodeResult.rawContent);
          getUserById(id: barcodeResult.rawContent);
          //     .then((value) {
          // //  if(state is GetUserByIdSuccessState)
          //     navigateForward(ReportedPersonInfo());
          // });

          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (_) => LabDetails(
          //           labId: barcodeResult.rawContent,
          //         )));
        } else {
          print(error);
          //setState(() {
          code = 'you press back Button before scan any Thing';
          //});
        }
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        print(error);
      } else {
        print(error);
      }
    } on FormatException {
      print(error);
    } catch (e) {
      print(error);
    }
  }

  late ProfileModel profileModel;
  bool isGetUserById = false;

  Future getUserById({required String id}) async {
    isGetUserById = false;
    emit(GetUserByIdLoadingState());
    DioHelper.getData(
            url: 'https://murshidguide.com/api/pilgrims/getPilgrimById/$id',
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      print('user By Id :${value.data}');
      profileModel = ProfileModel.fromJson(value.data);

      emit(GetUserByIdSuccessState());
      navigateForward(ReportedPersonInfo());
      isGetUserById = true;
    }).catchError((error) {
      print(error.toString());
      showToast(text:LocaleKeys.id_not_found.tr(), state: ToastState.ERROR);
      emit(GetUserByIdErrorState(error: error.toString()));
    });
  }
  Future getUserByPhoneNumber({required String phoneNumber}) async {
    isGetUserById = false;
    emit(GetUserByIdLoadingState());
    DioHelper.getData(
        url: 'https://murshidguide.com/api/pilgrims/getPilgrimByNumber/$phoneNumber',
        token: token)
        .then((value) {
      print('user By Phone Number :${value.data}');
      profileModel = ProfileModel.fromJson(value.data);

      emit(GetUserByIdSuccessState());
      navigateForward(ReportedPersonInfo());
      isGetUserById = true;
    }).catchError((error) {
      print(error.toString());
      showToast(text:LocaleKeys.phone_not_found.tr() , state: ToastState.ERROR);
      emit(GetUserByIdErrorState(error: error.toString()));
    });
  }
  Future getUserByVisaNumber({required String visaNumber}) async {
    isGetUserById = false;
    emit(GetUserByIdLoadingState());
    DioHelper.getData(
        url: 'https://murshidguide.com/api/pilgrims/getPilgrimByVisa/$visaNumber',
        token: token)
        .then((value) {
      print('user By Visa Number :${value.data}');
      profileModel = ProfileModel.fromJson(value.data);
      emit(GetUserByIdSuccessState());
      navigateForward(ReportedPersonInfo());
      isGetUserById = true;
    }).catchError((error) {
      print(error.toString());
      showToast(text:LocaleKeys.visa_not_found.tr(), state: ToastState.ERROR);
      emit(GetUserByIdErrorState(error: error.toString()));
    });
  }
  Future getUserByPassportNumber({required String passportNumber}) async {
    isGetUserById = false;
    emit(GetUserByIdLoadingState());
    DioHelper.getData(
        url: 'https://murshidguide.com/api/pilgrims/getPilgrimByPassport/$passportNumber',
        token: token)
        .then((value) {
      print('user By Passport Number :${value.data}');
      profileModel = ProfileModel.fromJson(value.data);
      emit(GetUserByIdSuccessState());
      navigateForward(ReportedPersonInfo());
      isGetUserById = true;
    }).catchError((error) {
      print(error.toString());
      showToast(text:LocaleKeys.passport_not_found.tr(), state: ToastState.ERROR);
      emit(GetUserByIdErrorState(error: error.toString()));
    });
  }
  Future getUserByBorderNumber({required String borderNumber}) async {
    isGetUserById = false;
    emit(GetUserByIdLoadingState());
    DioHelper.getData(
        url: 'https://murshidguide.com/api/pilgrims/getPilgrimByBorder/$borderNumber',
        token: token)
        .then((value) {
      print('user By Border Number :${value.data}');
      profileModel = ProfileModel.fromJson(value.data);
      emit(GetUserByIdSuccessState());
      navigateForward(ReportedPersonInfo());
      isGetUserById = true;
    }).catchError((error) {
      print(error.toString());
      showToast(text:LocaleKeys.border_not_found.tr(), state: ToastState.ERROR);
      emit(GetUserByIdErrorState(error: error.toString()));
    });
  }

  reportAnotherOne({
    required String assistanceMethod,
    required String details,
    required BuildContext context,
  }) {
    emit(SelfReportLoadingState());
    DioHelper.postData(
        url:
            'https://murshidguide.com/api/pilgrims/${profileModel.data!.id}/reportsother',
        token: CacheHelper.getData(key: 'token'),
        data: {
          'assistance_method': assistanceMethod,
          'report_details': details,
          'location': reportLocation2 == ''
              ? LocationCubit.get(context).address
              : reportLocation2,
          'latitude': lat,
          'longitude': lng,
        }).then((value) {
      print(value.data);
      emit(SelfReportSuccessState());
      showToast(
          text:LocaleKeys.report_upload_successfully.tr(),
          state: ToastState.SUCCESS);

      navigateForwardReplace(MainScreen());
    }).catchError((error) {
      print(error.toString());
      emit(SelfReportErrorState(error: error.toString()));
      showToast(
          text:LocaleKeys.report_failed_uploaded.tr(),
          state: ToastState.ERROR);
      print(LocationCubit.get(context).latLn?.longitude);
      print(LocationCubit.get(context).latLn?.latitude);
    });
  }
// scanQr(){
//  DioHelper.postData(url: 'https://murshidguide.com/api/pilgrims/scan-qr-code',
//      token: token).then((value) {}).catchError((error){});
// }
}
