import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../tranlations/locale_keys.g.dart';
import 'component.dart';
import '../constant/const_color.dart';
import 'cutom_text_filed.dart';
import 'info_profile_component.dart';

Widget circleAvtarWidget({
  required String svgImage,
  required Function fct,
}) {
  return GestureDetector(
    onTap: () {
      fct();
    },
    child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.sp)),
        elevation: 3,
        child: CircleAvatar(
            backgroundColor: whiteColor, child: SvgPicture.asset(svgImage))),
  );
}

headerOfTechnicalSupport(
    {required BuildContext context,
    required String title,
    List<Widget>? child}) {
  return AppBar(
    elevation: 1,
    backgroundColor: whiteColor,
    toolbarHeight: 148.h,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
    centerTitle: true,
    actions: child,
    leading: Container(
      height: 12.h,
      child: FittedBox(
        child: backButtonWidget(context: context),
      ),
    ),
  );
}

headerForGuide(
    {required BuildContext context,
    required String title,
    Widget? dropDownWidget,
    TextEditingController? searchController,
    Function? fct}) {
  return AppBar(
    elevation: 1,
    backgroundColor: whiteColor,
    toolbarHeight: 100.h,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
    centerTitle: true,
    leading: Container(
      height: 115.h,
      child: FittedBox(
        child: backButtonWidget(context: context),
      ),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(100.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: CustomTextField(
                    controller: searchController,
                    labelText: LocaleKeys.findingInfoByNamePHoneOrLang.tr(),
                    // hintText: 'بحث بالأسم أو رقم الجوال',
                    )),
            dropDownWidget ?? SizedBox(),
            SizedBox(
              width: 8.w,
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(bottom: 15.h),
                child: mainButton(
                    height: 54.h,
                    width: 73.w,

                    // width: screenSize.width * 0.2,
                    // height: screenSize.height * 0.06,
                    text: LocaleKeys.search.tr(),
                    color: darkMainColor,
                    context: context,
                    fct: () {
                      fct!();
                    }))
          ],
        ),
      ),
    ),
  );
}

Widget itemContainerOfGuidesAndEscorts(
    {required BuildContext context,
    Widget? contactColumn,
    required String image,
    required String name,
    required String phone}) {
  return Container(
    margin: EdgeInsetsDirectional.only(bottom: 5.h),
    padding: EdgeInsetsDirectional.only(end: 8.w),
    height: 132.h,
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(20.sp)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListTile(
            title: Text(
              name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            subtitle: RichText(
              text: TextSpan(
                  text: '${LocaleKeys.phoneNumber.tr()} : ',
                  style: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: greyColor),
                  children: [
                    TextSpan(
                        text: phone,
                        style: GoogleFonts.cairo(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.sp,
                            color: blackColor))
                  ]),
            ),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: darkMainColor,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
        ),
        contactColumn ?? const SizedBox()
      ],
    ),
  );
}
