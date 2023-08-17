import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/constant/const_color.dart';

homeComponentWidget(
    {required BuildContext context,
    required String image,
    required String title,
    TextStyle? style,
    required Function fct,
    required double width,
    required double height,
    bool isWide = true,
    bool isTall = true}) {
  return GestureDetector(
    onTap: () {
      fct();
    },
    child: Container(
      padding: EdgeInsets.zero,
      height: height,
      width: width,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 8.h),
            child: Image.asset(
              image,
              width: 68.53.w,
            ),
          ),
          FittedBox(
            child: Text(
              title,
              style: style ?? Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              // softWrap: true,
              textAlign: myLocale == 'en' ? TextAlign.start : TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    ),
  );
}
