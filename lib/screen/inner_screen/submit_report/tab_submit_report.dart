import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morshed/bloc/submitting_report/submit_report_cubit.dart';
import 'package:morshed/bloc/submitting_report/submit_report_state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/component/info_profile_component.dart';
import '../../../component/horizontal_dotted_line.dart';
import '../../../tranlations/locale_keys.g.dart';
import 'another_person_submit_report.dart';
import 'my_submit_report.dart';

class TabBarSubmitReport extends StatefulWidget {
  const TabBarSubmitReport({Key? key}) : super(key: key);

  @override
  State<TabBarSubmitReport> createState() => _TabBarSubmitReportState();
}

class _TabBarSubmitReportState extends State<TabBarSubmitReport>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  void setTabActive() {
    SubmitReportCubit.get(context)
        .changeTabBarIndex(value: tabController.index);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: SubmitReportCubit.get(context).index);
    tabController.addListener(setTabActive);
  }

  @override
  Widget build(BuildContext context) {
    var submitReport = SubmitReportCubit.get(context);
    return BlocConsumer<SubmitReportCubit, SubmitReportState>(
        listener: (context, state) {},
        builder: (context, state) {
          {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Scaffold(
                appBar: PreferredSize(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      fit: StackFit.expand,
                      children: [
                        Image.asset('assets/images/header1.png',
                            fit: BoxFit.cover),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              bottom: 40.h, top: 15.h),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: DashedLine(
                                color: whiteColor,
                                height: 10.h,
                                heightContainer: 60.h),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 30.h, bottom: 20.h, start: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    backButtonWidget(context: context),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        LocaleKeys.reporting.tr(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    )
                                  ],
                                ),
                              ),
                              TabBar(controller: tabController, tabs: [
                                Tab(
                                  child: AutoSizeText(
                                    LocaleKeys.iLost.tr(),
                                    presetFontSizes: [15.sp, 13.sp, 9.sp],
                                    style: tabController.index == 0
                                        ? Theme.of(context).textTheme.labelLarge
                                        : GoogleFonts.cairo(
                                            fontSize: 17.sp,
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  icon: SvgPicture.asset(
                                      tabController.index == 1
                                          ? 'assets/svg/iLostActive.svg'
                                          : 'assets/svg/iLostInActive.svg'),
                                  // text: 'انا تائه'
                                ),
                                Tab(
                                  child: AutoSizeText(
                                    LocaleKeys.anotherOneIsLost.tr(),
                                    presetFontSizes: [15.sp, 13.sp, 9.sp],
                                    style: tabController.index == 1
                                        ? Theme.of(context).textTheme.labelLarge
                                        : GoogleFonts.cairo(
                                            fontSize: 17.sp,
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  icon: SvgPicture.asset(
                                      tabController.index == 0
                                          ? 'assets/svg/anotherActive.svg'
                                          : 'assets/svg/anotherInActive.svg'),
                                ),
                              ])
                            ],
                          ),
                        )
                      ],
                    ),
                    preferredSize: Size.fromHeight(180.h)),
                body: TabBarView(

                  controller: tabController,
                  children:  [
                    submitReport.isAssistanceWaysLoading? MySubmitReport():Center(child: CircularProgressIndicator.adaptive(
                      backgroundColor: orangeColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        darkMainColor, //<-- SEE HERE
                      ),
                    )
                    ),
                    SubmitReportAnotherPerson(),
                  ],
                ),
              ),
            );
          }
        });
  }
}
