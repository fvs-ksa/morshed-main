import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/location_cubit/cubit.dart';
import 'package:morshed/bloc/location_cubit/state.dart';
import 'package:morshed/bloc/submitting_report/submit_report_cubit.dart';
import 'package:morshed/bloc/submitting_report/submit_report_state.dart';
import '../../../component/cutom_text_filed.dart';
import '../../../constant/const_color.dart';
import '../../../component/info_profile_component.dart';
import '../../../component/report_Details_widget.dart';
import '../../../tranlations/locale_keys.g.dart';

class ReportedPersonInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var reportCubit = SubmitReportCubit.get(context);
    return BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<SubmitReportCubit, SubmitReportState>(
              listener: (context, state) {},
              builder: (context, state) {
                TextEditingController arabicNameController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.nameAr
                            : "");
                TextEditingController englishNameController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.nameEn
                            : "");
                TextEditingController phoneNumberController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.phoneNumber
                            : "");
                TextEditingController emailController = TextEditingController(
                    text: reportCubit.isGetUserById
                        ? reportCubit.profileModel.data!.email
                        : "");
                TextEditingController passportController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.passportNumber
                            : "");
                TextEditingController visaNumberController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.visaNumber
                            : "");
                TextEditingController borderNumberController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.borderNumber
                            : "");
                //TextEditingController ageController = TextEditingController(text: reportCubit.profileModel.data!.ag);
                TextEditingController nationalityController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.nationality
                            : "");
                TextEditingController arrivalDateController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.arrivalDate
                            : "");
                TextEditingController leaveController = TextEditingController(
                    text: reportCubit.isGetUserById
                        ? reportCubit.profileModel.data!.departureDate
                        : "");
                // TextEditingController residencyController =
                // TextEditingController(text: 'المدينه المنوره');
                TextEditingController touristCompanyController =
                    TextEditingController(
                        text: reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.agentName
                            : "");
                // TextEditingController saudiRepresentativeController =
                // TextEditingController(text: 'وكيل سعودي');
                return Scaffold(
                  appBar: headerInfoPerson(
                      avatarChild: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(reportCubit.isGetUserById
                            ? reportCubit.profileModel.data!.image ??
                                'https://firebasestorage.googleapis.com/v0/b/murshid-5cf3e.appspot.com/o/profile.png?alt=media&token=9e46dec9-ea36-4118-b7d3-c7d298b302d7'
                            : 'https://firebasestorage.googleapis.com/v0/b/murshid-5cf3e.appspot.com/o/profile.png?alt=media&token=9e46dec9-ea36-4118-b7d3-c7d298b302d7'),
                      ),
                      context: context,
                      title: reportCubit.profileModel.data!.accountType ==
                              'pilgrim'
                          ? LocaleKeys.hajjiInfo.tr()
                          : LocaleKeys.moetamerInfo.tr(),
                      isProfile: false),
                  backgroundColor: whiteLightColor,
                  body: reportCubit.isGetUserById
                      ? GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 10.w),
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                          labelText: LocaleKeys
                                              .arabicNamePassport
                                              .tr(),
                                          isEnabled: false,
                                          controller: arabicNameController),
                                      CustomTextField(
                                          labelText: LocaleKeys
                                              .englishNamePassport
                                              .tr(),
                                          isEnabled: false,
                                          controller: englishNameController),
                                      CustomTextField(
                                          labelText:
                                              LocaleKeys.nationality.tr(),
                                          isEnabled: false,
                                          controller: nationalityController),
                                      // CustomTextField(
                                      //     labelText: LocaleKeys.age.tr(),
                                      //     context: context,
                                      //     isEnabled: false,
                                      //     controller: ageController),
                                      CustomTextField(
                                          labelText: LocaleKeys.email.tr(),
                                          isEnabled: false,
                                          controller: emailController),
                                      CustomTextField(
                                          labelText: LocaleKeys.boardNo.tr(),
                                          isEnabled: false,
                                          controller: borderNumberController),
                                      CustomTextField(
                                          labelText: LocaleKeys.visaNo.tr(),
                                          isEnabled: false,
                                          controller: visaNumberController),
                                      CustomTextField(
                                          labelText: LocaleKeys.passportNo.tr(),
                                          isEnabled: false,
                                          controller: passportController),
                                      CustomTextField(
                                          labelText: LocaleKeys.arriveDate.tr(),
                                          isEnabled: false,
                                          controller: arrivalDateController),
                                      CustomTextField(
                                          labelText: LocaleKeys.leaveDate.tr(),
                                          isEnabled: false,
                                          controller: leaveController),
                                      // CustomTextField(
                                      //     labelText: LocaleKeys.residentialAddress.tr(),
                                      //     context: context,
                                      //     isEnabled: false,
                                      //     controller: residencyController),
                                      CustomTextField(
                                          labelText: LocaleKeys
                                              .officialMissionName
                                              .tr(),
                                          isEnabled: false,
                                          controller: touristCompanyController),
                                      // CustomTextField(
                                      //     labelText: LocaleKeys.agentName.tr(),
                                      //     context: context,
                                      //     isEnabled: false,
                                      //     controller: saudiRepresentativeController),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.sp),
                                          topRight: Radius.circular(10.sp))),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 15.h),
                                  child: SingleChildScrollView(
                                    child: ReportDetailsWidget(index: 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator.adaptive(
                          backgroundColor: orangeColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            darkMainColor, //<-- SEE HERE
                          ),
                        )),
                  //bottomSheet: ,
                );
              });
        });
  }
}
