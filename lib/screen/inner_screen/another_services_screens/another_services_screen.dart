import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/constant/const_color.dart';
import '../../../component/another_services_widget.dart';
import '../../../models/another_services_model.dart';
import '../../../tranlations/locale_keys.g.dart';

class AnotherServicesScreen extends StatelessWidget {
  const AnotherServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteGreyColor,
      appBar: headerAnotherServices(
          context: context, title: LocaleKeys.otherServices.tr()),
      body: ListView.builder(
          itemCount: anotherServicesList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => anotherServicesList[index].fct(),
              child: Container(
                height: 115.h,
                margin: EdgeInsetsDirectional.only(
                    start: 10.w, end: 10.w, top: 20.w),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15.sp)),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: ListTile(
                    title: Text(
                      anotherServicesList[index].title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: Image.asset(anotherServicesList[index].image),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
