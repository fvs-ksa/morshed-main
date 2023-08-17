import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/const_color.dart';
import '../tranlations/locale_keys.g.dart';
import 'cutom_text_filed.dart';
import 'info_profile_component.dart';

Widget myReportsContainerWidget(
    {required BuildContext context,
    required String reportStatus,
    required int reportId,
    Widget? solutionWidget,
    TextStyle? style,
    required String backgroundImage}) {
  return Container(
    margin: EdgeInsetsDirectional.symmetric(vertical: 5.h, horizontal: 5.w),
    height: 173,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.sp), color: whiteColor),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(start: 15.w, top: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${LocaleKeys.report_no.tr()} #$reportId".tr(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                LocaleKeys.note_for_report.tr(),
                style: GoogleFonts.cairo(
                    fontSize: 12.spMax,
                    color: blackColor,
                    fontWeight: FontWeight.normal),
              ),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: solutionWidget,
              )
            ],
          ),
        ),
        const Spacer(),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          clipBehavior: Clip.antiAlias,
          children: [
            Container(
              padding: EdgeInsetsDirectional.only(end: 15.w),
              height: 35,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.sp),
                      bottomLeft: Radius.circular(15.sp)),
                  image: DecorationImage(
                      image: AssetImage(backgroundImage), fit: BoxFit.cover)),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 20.w),
              child: Text(
                reportStatus,
                style: style ?? Theme.of(context).textTheme.labelLarge,
              ),
            )
          ],
        ),
      ],
    ),
  );
}

locationWidget({required BuildContext context,required Function fct,required TextEditingController controller}) {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomTextField(
              labelText: LocaleKeys.reportLocation.tr(),
              controller: controller,
              //  hintText: 'hintText',

              isEnabled: false,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          decorationContainerWidget(
              context: context,
              radius: 20.sp,
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
                color: darkMainColor, decoration: TextDecoration.underline),
            textAlign: TextAlign.center,
          ),
        ),
        onPressed: () {fct();},
      ),
    ],
  );
}
