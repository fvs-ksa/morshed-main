import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/component/auth_header_widget.dart';
import 'package:morshed/component/info_profile_component.dart';
import 'package:morshed/models/guides_for_hajji_model.dart';
import '../../../../constant/const_color.dart';
import '../../../../tranlations/locale_keys.g.dart';

class GuidesForHajjiScreen extends StatelessWidget {
  const GuidesForHajjiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: 30.h),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: context.locale.languageCode == 'ar'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: backButtonWidget(context: context),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 8.0.h),
                            child: Text(
                              LocaleKeys.Instructions.tr(),
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 30.h, end: 10.w),
                  child: FlexibleSpaceBar(
                    title: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: whiteMorshedLogo(
                          image: 'assets/images/whiteMorshed.png',
                          width: 99.w,
                          height: 60.h),
                    ),
                    centerTitle: true,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(150.h)),
      backgroundColor: whiteGreyColor,
      body: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: ListView.builder(
            itemCount: guidesForHajjiList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => guidesForHajjiList[index].fct(),
                child: Container(
                  height: 115.h,
                  margin: EdgeInsetsDirectional.only(
                      start: 10.w, end: 10.w, top: 10.w),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(15.sp)),
                  child: Align(
                    alignment: AlignmentDirectional.center,
                    child: ListTile(
                      title: Text(
                        guidesForHajjiList[index].title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: Image.asset(guidesForHajjiList[index].image),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
