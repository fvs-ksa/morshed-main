import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/submitting_report/submit_report_cubit.dart';
import 'package:morshed/bloc/submitting_report/submit_report_state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/component/cutom_text_filed.dart';
import '../../../constant/const_color.dart';
import '../../../tranlations/locale_keys.g.dart';

class SubmitReportAnotherPerson extends StatelessWidget {
  const SubmitReportAnotherPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var submitReport = SubmitReportCubit.get(context);
    TextEditingController idController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController visaNumberController = TextEditingController();
    TextEditingController passportNumberController = TextEditingController();
    TextEditingController borderNumberController = TextEditingController();
    return BlocConsumer<SubmitReportCubit, SubmitReportState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 30.w, vertical: 8.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          submitReport.ScanBarcode();
                        },
                        child: CustomTextField(
                            suffixIcon: SvgPicture.asset(
                                'assets/svg/scanQR.svg',
                                fit: BoxFit.none),
                            labelText: LocaleKeys
                                .findingInformationByScanningQrCode
                                .tr(),
                            onTap: () {
                              print('object');
                            },
                            isEnabled: false),
                      ),
                      // textFormField(
                      //     labelText: LocaleKeys
                      //         .findingInformationUsingPassportNumber
                      //         .tr(),
                      //     context: context,
                      //     keyboardType: TextInputType.phone),
                      CustomTextField(
                        labelText: LocaleKeys.findingInformationUsingId.tr(),
                        controller: idController,
                        keyboardType: TextInputType.phone,
                      ),
                      CustomTextField(
                        labelText:LocaleKeys.finidingInfoByPhone.tr(),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      CustomTextField(
                        labelText: LocaleKeys
                            .findingInformationUsingPassportNumber
                            .tr(),
                        controller: passportNumberController,
                        // keyboardType: TextInputType.phone,
                      ),
                      CustomTextField(
                        labelText:
                            LocaleKeys.findingInformationUsingVisaNumber.tr(),
                        controller: visaNumberController,
                        // keyboardType: TextInputType.phone,
                      ),
                      CustomTextField(
                        labelText:LocaleKeys.finidingInfoByBorderNo.tr() ,
                        controller: borderNumberController,
                        //   keyboardType: TextInputType.phone,
                      ),

                      // textFormField(
                      //     labelText:
                      //         LocaleKeys.findingInformationUsingHotelName.tr(),
                      //     context: context),
                      // textFormField(
                      //     labelText:
                      //         LocaleKeys.findingInformationUsingVisaNumber.tr(),
                      //     context: context,
                      //     keyboardType: TextInputType.phone),
                      // dropDownButton(
                      //     items: submitReport.country.map((e) {
                      //       return DropdownMenuItem(
                      //         child: Text(
                      //           e,
                      //           style: Theme.of(context).textTheme.labelSmall,
                      //         ),
                      //         value: e,
                      //       );
                      //     }).toList(),
                      //     value: submitReport.chooseCountry,
                      //     hint: LocaleKeys.country.tr(),
                      //     fct: (onChange) {
                      //       submitReport.onChangeCountryName(onChange);
                      //     },
                      //     context: context,
                      //     validator: () {}),
                      // dropDownButton(
                      //     items: submitReport.sexList.map((e) {
                      //       return DropdownMenuItem(
                      //         child: Text(
                      //           e,
                      //           style: Theme.of(context).textTheme.labelSmall,
                      //         ),
                      //         value: e,
                      //       );
                      //     }).toList(),
                      //     value: submitReport.sex,
                      //     hint: LocaleKeys.sex.tr(),
                      //     fct: (onChange) {
                      //       submitReport.onChangeSex(onChange);
                      //     },
                      //     context: context,
                      //     validator: () {}),
                      SizedBox(
                        height: 10.h,
                      ),
                      //  locationWidget(context: context,controller: reportLocationController,fct: (){navigateForward(MapScreenForSetLocation(i: 3));}),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            top: 10.h, bottom: 8.h, start: 10.w, end: 10.w),
                        child: Align(
                            alignment: Alignment.center,
                            child: state is GetUserByIdLoadingState
                                ? CircularProgressIndicator.adaptive(
                                    backgroundColor: orangeColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      darkMainColor, //<-- SEE HERE
                                    ),
                                  )
                                : mainButton(
                                    text: LocaleKeys.search.tr(),
                                    color: darkMainColor,
                                    context: context,
                                    fct: () {
                                      if (phoneController.text.isNotEmpty) {
                                        submitReport.getUserByPhoneNumber(
                                            phoneNumber: phoneController.text);
                                      } else if (visaNumberController
                                          .text.isNotEmpty) {
                                        submitReport.getUserByVisaNumber(
                                            visaNumber:
                                                visaNumberController.text);
                                      } else if (passportNumberController
                                          .text.isNotEmpty) {
                                        submitReport.getUserByPassportNumber(
                                            passportNumber:
                                                passportNumberController.text);
                                      } else if (borderNumberController
                                          .text.isNotEmpty) {
                                        submitReport.getUserByBorderNumber(
                                            borderNumber:
                                                borderNumberController.text);
                                      } else if (idController.text.isEmpty) {
                                        showToast(
                                            text: LocaleKeys.id_not_found.tr(),
                                            state: ToastState.ERROR);
                                      } else {
                                        submitReport.getUserById(
                                            id: idController.text);
                                      }

                                      // if(state is GetUserByIdSuccessState){
                                      //
                                      // }
                                    }
                                    )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}


