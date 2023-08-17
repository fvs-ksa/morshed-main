import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/location_cubit/cubit.dart';
import 'package:morshed/bloc/location_cubit/state.dart';
import 'package:morshed/bloc/submitting_report/submit_report_cubit.dart';
import 'package:morshed/bloc/submitting_report/submit_report_state.dart';
import 'package:morshed/component/navigation_functions.dart';
import 'package:morshed/screen/inner_screen/locations/set_location_on_map.dart';
import '../tranlations/locale_keys.g.dart';
import 'component.dart';
import '../constant/const_color.dart';
import 'cutom_text_filed.dart';
import 'info_profile_component.dart';

class ReportDetailsWidget extends StatefulWidget {
  int? index;

  ReportDetailsWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<ReportDetailsWidget> createState() => _ReportDetailsWidgetState();
}

class _ReportDetailsWidgetState extends State<ReportDetailsWidget> {
  @override
  void initState() {
    reportLocation == '' ? LocationCubit.get(context).address : reportLocation;
   // print(object)
    super.initState();
  }
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController reportDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var reportCubit = SubmitReportCubit.get(context);
    var locationCubit = LocationCubit.get(context);
    //var formKey=GlobalKey<FormState>();
    return BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {},
        builder: (context, state) {
          TextEditingController reportLocationAnotherPerson = TextEditingController(text: LocationCubit.get(context).address);
          TextEditingController reportLocationController = TextEditingController(text: LocationCubit.get(context).address);
          return BlocConsumer<SubmitReportCubit, SubmitReportState>(
            listener: (context, state) {
              // TextEditingController reportLocationAnotherPerson = TextEditingController(text: LocationCubit.get(context).address);
              // TextEditingController reportLocationController = TextEditingController(text: LocationCubit.get(context).address);
              // if(state is ChangeAddressState){
              //   TextEditingController reportLocationController=TextEditingController(text:reportLocation==''? locationCubit.address:reportLocation);
              // }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.index == 0
                      ? Text(
                          LocaleKeys.WhatCanWeDoToAssistHim.tr(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      : Container(),
                  widget.index == 0
                      ? Container(
                         // height: 225.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: reportCubit.assistanceMethods.data!.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  checkboxShape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(5.sp)),
                                  contentPadding:
                                      EdgeInsetsDirectional.symmetric(
                                          horizontal: 5.w, vertical: 0),
                                  value: reportCubit.assistanceMethods.data![index].status,
                                  title: Text(
                                    reportCubit.assistanceMethods.data![index].name!,

                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  onChanged: (bool ?onChange) {
                                    reportCubit.changeCheckBox(i:index,onchange: onChange!);
                                  },
                                );
                              }),
                        )
                      : Container(),
                  widget.index == 1
                      ? Text(
                          LocaleKeys.WhatCanWeDoToAssistYou.tr(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      : Container(),
                  widget.index == 1
                      ? Container(
                          height: 225.h,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  reportCubit.assistanceMethods.data!.length,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  checkboxShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  contentPadding:
                                      EdgeInsetsDirectional.symmetric(
                                          horizontal: 5.w, vertical: 0),
                                  value: reportCubit.assistanceMethods.data![index].status,
                                  title: Text(
                                    reportCubit.assistanceMethods
                                        .data![index].name!,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  onChanged: (bool? onChange) {
                                    reportCubit.changeCheckBox(i:index,onchange: onChange!);
                                    print(
                                        'reportWaySolution! :${reportCubit.reportWaySolution}');
                                    print(reportDetailsController.text);
                                  },
                                );
                              }),
                        )
                      : Container(),
                  Text(
                    LocaleKeys.reportDetails.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  bigTextFieldForNotes(
                      controller: reportDetailsController,
                      context: context,

                      hint: LocaleKeys.commentsAndAssistance.tr()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  widget.index==0?  Expanded(
                          child: CustomTextField(
                              controller:reportLocationAnotherPerson,
                              labelText: LocaleKeys.reportLocation.tr(),
                              lines: 1,
                              isEnabled: false)):
                      Expanded(
                          child: CustomTextField(
                              controller: reportLocationController,
                              labelText: LocaleKeys.reportLocation.tr(),
                              lines: 1,
                              isEnabled: false)),
                      SizedBox(
                        width: 12.w,
                      ),
                      decorationContainerWidget(
                          context: context,
                          radius: 30.sp,
                          width: 54.w,
                          height: 54.h,
                          child: SvgPicture.asset('assets/svg/loc.svg')),
                    ],
                  ),
                  TextButton(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.changeLocation.tr(),
                        style: TextStyle(
                            color: darkMainColor,
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () {
                      navigateForward(MapScreenForSetLocation(i: 3,locationName:widget.index==0?reportLocationAnotherPerson: reportLocationController,));
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 15.h, bottom: 8.h, start: 5.w, end: 5.w),
                    child: Align(
                        alignment: Alignment.center,
                        child: state is SelfReportLoadingState
                            ? CircularProgressIndicator.adaptive(
                          backgroundColor: orangeColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            darkMainColor, //<-- SEE HERE
                          ),
                        )
                            : mainButton(
                                text: LocaleKeys.reporting.tr(),
                                color: darkMainColor,
                                context: context,
                                fct: () {
                                 widget.index == 1
                                      ? reportCubit.selfReport(
                                      assistanceMethod:
                                      reportCubit.reportWaySolution ??
                                          "dds",
                                      context: context,
                                      details: reportDetailsController.text)
                                      : reportCubit.reportAnotherOne(
                                      assistanceMethod:
                                      reportCubit.reportWaySolution ??
                                          "dds",
                                      details: reportDetailsController.text,
                                      context: context);


                                })),
                  )
                ],
              );
            },
          );
        });
  }
}
