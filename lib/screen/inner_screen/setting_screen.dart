import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/setting_cubit/cubit.dart';
import 'package:morshed/bloc/setting_cubit/state.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/component/guide_escorts_component.dart';

import '../../tranlations/locale_keys.g.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var settingCubit = SettingCubit.get(context);
    return BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          {
            return Scaffold(
              appBar: headerOfTechnicalSupport(
                  context: context, title: LocaleKeys.settings.tr()),
              body: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 8.w, vertical: 10.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                      height: 100.h,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(20.sp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.language.tr(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                            children: [
                              Text(
                                'Ar',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Switch.adaptive(
                                  inactiveThumbColor: darkMainColor,
                                  inactiveTrackColor: whiteGreyColor,
                                  activeColor: orangeColor,
                                  activeTrackColor: whiteGreyColor,
                                  value: isEnglish!,
                                  onChanged: (onChange) {
                                    setState(() {
                                      settingCubit.changeLanguage(context);
                                      myLocale = context.locale.languageCode;
                                    });

                                  }),
                              Text(
                                'En',
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        LocaleKeys.deleteAccount.tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
