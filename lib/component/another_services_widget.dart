import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'info_profile_component.dart';

headerAnotherServices(
    {required BuildContext context,
    bool isProfile = false,
    required String title,
    bool isHeaderProfile = true}) {
  return PreferredSize(
      child: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              'assets/images/header1.png',
              fit: BoxFit.cover,
            )),
            FlexibleSpaceBar.createSettings(
              currentExtent: 10,
              child: Align(
                alignment: context.locale.languageCode == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 15.w),
                  child: backButtonWidget(context: context),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 10.h),
              child: FlexibleSpaceBar(
                title: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                centerTitle: true,
              ),
            ),
          ],
        ),
      ),
      preferredSize: Size.fromHeight(150.h));
}
