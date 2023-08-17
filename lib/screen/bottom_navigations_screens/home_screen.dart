import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/general_cubit/general_cubit.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/auth_header_widget.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/component/floating_Container.dart';
import 'package:morshed/component/home_screen_widget.dart';
import 'package:morshed/screen/inner_screen/add_companions_screen.dart';
import 'package:morshed/screen/inner_screen/my_card_screen.dart';
import '../../component/horizontal_dotted_line.dart';
import '../../component/navigation_functions.dart';
import '../../tranlations/locale_keys.g.dart';
import '../inner_screen/another_services_screens/another_services_screen.dart';
import '../inner_screen/submit_report/tab_submit_report.dart';
import '../map_tap_bar_screen/map_tab_bar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 212.4.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/home bg.png',
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    whiteMorshedLogo(
                        image: 'assets/images/whiteMorshed.png',
                        width: 163.w,
                        height: 100.h),
                    // Image.asset(
                    //   'assets/images/whiteMorshed.png',
                    //   height:size.width>600? size.height * 0.2:size.height*0.1,
                    //   width:size.width>600? size.width * 0.4:size.height*0.2,
                    //   fit: BoxFit.contain,
                    // ),
                    GeneralCubit.get(context).isGetProfile
                        ? Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: GestureDetector(
                              onTap: () {
                                navigateForward(MyCardScreen());
                              },
                              child: cardIdWidgetSmallSize(
                                  // height: 115.h,
                                  // width: 178.86.w,
                                  model: GeneralCubit.get(context).profileModel,
                                  context: context),
                              // child: Image.asset(
                              //   'assets/images/card.png',
                              //   height: 115.h,
                              //   width: 178.86.w,
                              //   fit: BoxFit.contain,
                              // ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  EdgeInsetsDirectional.only(top: 14.h, start: 45.w, end: 45.w),
              child: Column(
                children: [
                  Text(
                    LocaleKeys.welcomeToMorshed.tr(),
                    style: Theme.of(context).textTheme.headlineSmall,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.h,
                    //  height: size.width * 0.07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      homeComponentWidget(
                        width: 98.w,
                        height: 151.16.h,
                        style: Theme.of(context).textTheme.displaySmall,
                        context: context,
                        image: 'assets/images/report.png',
                        title: LocaleKeys.reportingCaseOfMentalBreakdown.tr(),
                        fct: () {
                          navigateForward(TabBarSubmitReport());
                        },
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                        child: DashedLine(color: greyColor),
                      ),
                      homeComponentWidget(
                          width: 72.49.w,
                          height: 151.16.h,
                          fct: () {
                            showToast(
                                text: LocaleKeys.service_under_development.tr(),
                                state: ToastState.WARNING);
                            // navigateForward(GuidesScreen(
                            //   index: 1,
                            // ));
                          },
                          context: context,
                          image: 'assets/images/vedio.png',
                          title: LocaleKeys.videoCall.tr()),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.only(bottom: 22.h, top: 11.h),
                    child: MySeparator(color: greyColor),
                  ),
                  homeComponentWidget(
                      width: 102.h,
                      height: 114.02.h,
                      fct: () {
                        navigateForward(AnotherServicesScreen());
                      },
                      context: context,
                      image: 'assets/images/other_services.png',
                      title: LocaleKeys.otherServices.tr()),
                  SizedBox(
                    height: 55.h,
                  ),
                  floatingContainer(
                      fct: () {
                        navigateForward( AddCompanionsScreen());
                      },
                      alignment: AlignmentDirectional.bottomStart,
                      context: context,
                      svgAssets: 'assets/svg/Icon ionic-ios-add.svg',
                      title: LocaleKeys.addCompanion.tr(),
                      width: 161.w,
                      color: darkMainColor),
                  SizedBox(
                    height: 10.h,
                  ),
                  floatingContainer(
                      fct: () {
                        navigateForward(MapTabBarScreen());
                      },
                      alignment: AlignmentDirectional.bottomStart,
                      context: context,
                      svgAssets: 'assets/svg/on map.svg',
                      title: LocaleKeys.counselingOfficesAndCounselors.tr(),
                      width: 247.w,
                      color: orangeColor),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
