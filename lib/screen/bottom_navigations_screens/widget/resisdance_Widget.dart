

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../component/cutom_text_filed.dart';
import '../../../component/info_profile_component.dart';
import '../../../constant/const_color.dart';

clikedLocationWidget({required TextEditingController controller,required Function fct,required BuildContext context,required String labelText}){
  return  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: controller,
            isEnabled: false,
            labelText: labelText, ),
        ),
        Padding(
          padding:  EdgeInsetsDirectional.only(end: 8.0,start: 18),
          child: GestureDetector(
            onTap: () async {
              await fct();
              // await launchUrl(Uri.parse(
              //     'google.navigation:q='
              //         '${generalCubit.profileModel.data!.latitudeMina}, '
              //         '${generalCubit.profileModel.data!.longitudeMina}'
              //         '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
            },
            child: decorationContainerWidget(
                context: context,
                radius: 50.sp,
                width: 70.w,
                height: 54.h,
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: FittedBox(
                      child: AutoSizeText(
                        presetFontSizes: [10,8,6],
                        "press_here".tr(),
                        style:
                        TextStyle(color: darkMainColor),
                      ),
                    ))),
          ),
        )
      ],
    ),
  );
}