import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morshed/bloc/submitting_report/submit_report_cubit.dart';
import 'package:morshed/bloc/submitting_report/submit_report_state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/component/reports_widgets.dart';
import '../../../component/animation_component.dart';
import '../../../component/guide_escorts_component.dart';
import '../../../component/navigation_functions.dart';
import '../../../tranlations/locale_keys.g.dart';
import 'my_reports_details.dart';

class MyReports extends StatelessWidget {
  const MyReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reportCubit = SubmitReportCubit.get(context);
    return BlocConsumer<SubmitReportCubit, SubmitReportState>(
        listener: (context, state) {},
        // bloc: reportCubit.getMyReports(),
        builder: (context, state) {
          return Scaffold(
            appBar: headerOfTechnicalSupport(
                context: context, title: LocaleKeys.myReports.tr()),
            backgroundColor: whiteGreyColor,
            body: reportCubit.isGetMyReport
                ? reportCubit.getMyReportsModel.reports!.isEmpty
                    ? Center(child: Text(LocaleKeys.no_reports.tr()))
                    : RefreshIndicator(
                        onRefresh: () {
                          return reportCubit.getMyReports();
                        },
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print(reportCubit
                                    .getMyReportsModel.reports![index].status!);
                                navigateForward(MyReportsDetailsScreen(
                                  reportId: reportCubit
                                      .getMyReportsModel.reports![index].id!,
                                  status: reportCubit.getMyReportsModel
                                      .reports![index].status!,
                                  index: index,
                                ));
                              },
                              child: myReportsContainerWidget(
                                context: context,
                                style: reportCubit.getMyReportsModel
                                            .reports![index].status! ==
                                        '3'
                                    ? Theme.of(context).textTheme.bodyLarge
                                    : null,
                                solutionWidget: reportCubit.getMyReportsModel
                                            .reports![index].status! ==
                                        '1'
                                    ? IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                            'assets/svg/delete.svg'))
                                    : reportCubit.getMyReportsModel
                                                .reports![index].status! ==
                                            '2'
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              circleAvtarWidget(
                                                  svgImage:
                                                      'assets/svg/end call.svg',
                                                  fct: () {
                                                    launchCall(
                                                        context: context,
                                                        phoneNumber: reportCubit
                                                            .getMyReportsModel
                                                            .reports![index]
                                                            .receiverMobile);
                                                  }),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              circleAvtarWidget(
                                                  svgImage:
                                                      'assets/svg/msg.svg',
                                                  fct: () {
                                                    showToast(
                                                        text:LocaleKeys.service_under_development.tr(),
                                                        state:
                                                            ToastState.WARNING);
                                                  })
                                            ],
                                          )
                                        : const SizedBox(),
                                reportStatus: reportCubit.getMyReportsModel
                                            .reports![index].status! ==
                                        '1'
                                    ? LocaleKeys.underProcessing.tr()
                                    : reportCubit.getMyReportsModel
                                                .reports![index].status! ==
                                            '2'
                                        ? LocaleKeys.guideOnTheWay.tr()
                                        : LocaleKeys.Resolved.tr(),
                                reportId: reportCubit
                                    .getMyReportsModel.reports![index].id!,
                                backgroundImage: reportCubit.getMyReportsModel
                                            .reports![index].status! ==
                                        '1'
                                    ? 'assets/images/Group 204373.png'
                                    : reportCubit.getMyReportsModel
                                                .reports![index].status! ==
                                            '2'
                                        ? 'assets/images/Group 204372.png'
                                        : 'assets/images/Group 204371.png',
                              ),
                            );
                          },
                          itemCount:
                              reportCubit.getMyReportsModel.reports!.length,
                        ),
                      )
                : Center(
                    child: CircularProgressIndicator.adaptive(
                    backgroundColor: orangeColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      darkMainColor, //<-- SEE HERE
                    ),
                  )),
          );
        });
  }
}
