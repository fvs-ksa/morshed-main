import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'info_profile_component.dart';

PreferredSize headerForHijGuides(
    {required BuildContext context,
    required String title,
    required String image}) {
  return PreferredSize(
      child: Container(
        height: 220.h,
        child: Stack(
          children: [
            Container(
              height: 150.h,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: backButtonWidget(context: context),
              ),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/header1.png'),
                      fit: BoxFit.cover)),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 110.h),
              height: 100.h,
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp)),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: ListTile(
                    title: Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: Image.asset(image),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      preferredSize: Size.fromHeight(200.h));
}
