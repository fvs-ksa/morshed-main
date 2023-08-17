import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/models/account_type_model.dart';

Widget floatingButton({
  required Function fct,
  Color? backgroundColor,
  Color? iconColor,
}) {
  return GestureDetector(
    onTap: () {
      fct();
    },
    child: Container(
      height: 72.h,
      width: 72.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: backgroundColor ?? darkMainColor),
      child: Icon(
        Icons.arrow_forward,
        color: iconColor ?? whiteColor,
      ),
    ),
  );
}

Widget accountType(
    {required BuildContext context,
    required AccountTypeModel model,
    required Function fct,
    required bool checkBoxValue}) {
  return Padding(
    padding: EdgeInsetsDirectional.only(start: 45.w),
    child: Column(
      children: [
        Container(
          height: 192.h,
          width: 141.w,
          padding: EdgeInsetsDirectional.only(
              start: 20.w, end: 20.w, top: 20.h, bottom: 20.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: lightMainColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Image.asset(
                model.image,
                height: 208.h,
                width: 73.2.w,
                fit: BoxFit.contain,
              )),
              FittedBox(
                child: Text(
                  model.name,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              )
            ],
          ),
        ),
        Checkbox(
          value: checkBoxValue,
          onChanged: (onChanged) {
            fct(onChanged);
          },
          activeColor: whiteColor,
          side: BorderSide(color: whiteColor),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: whiteColor,
            ),
            borderRadius: BorderRadius.circular(10.sp),
          ),
        )
      ],
    ),
  );
}


Widget dropDownButton(
    {required List<DropdownMenuItem> items,
    required var value,
    required String hint,
    required Function fct,
    required BuildContext context,
    bool isFlag = false,
    // Function? validator
    }) {
  return Align(
    alignment: AlignmentDirectional.topStart,
    child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 5.h, top: 10.h),
        child: Container(
            padding:
                EdgeInsetsDirectional.only(start: isFlag ? 0 : 10.w, end: 10.w),
            height: 54.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20.sp),
                border: Border.all(color: greyColor)),
            child: Row(
              children: [
                Expanded(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButtonFormField(

                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: FittedBox(child: Text(hint)),
                      style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: greyColor),
                      iconSize: 0.0,
                      borderRadius: BorderRadius.circular(12.sp),
                      value: value,
                      items: items,
                      onChanged: (v) {
                        fct(v);
                      },
                      // validator: (v) {
                      //   return validator!(v);
                      // },
                    ),
                  ),
                ),
                SvgPicture.asset('assets/svg/dropdown.svg')
              ],
            ))),
  );
}

Widget mainButton(
    {double? width,
    double? height,
    FontWeight? fontWeight,
    required String text,
    required Color color,
    Color? borderColor,
    TextStyle? textStyle,
    required BuildContext context,
    required Function fct}) {
  return InkWell(
    onTap: () {
      fct();
    },
    child: Container(
      height: height ?? 64.h,
      width: width ?? 330.w,
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
          color: color,
          borderRadius: BorderRadius.circular(35.sp)),
      child: Align(
        alignment: Alignment.center,
        child: AutoSizeText(
          presetFontSizes: [15,12,10],
          textAlign: TextAlign.center,
          text,
          style: textStyle ?? Theme.of(context).textTheme.labelLarge,
        ),
      ),
    ),
  );
}
