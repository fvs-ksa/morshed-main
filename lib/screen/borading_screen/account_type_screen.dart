import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/account_type_cubit/cubit.dart';
import 'package:morshed/bloc/account_type_cubit/state.dart';
import 'package:morshed/component/auth_header_widget.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/screen/auth_screen/hajji/login_screen.dart';
import '../../component/animation_component.dart';
import '../../component/navigation_functions.dart';
import '../../models/account_type_model.dart';
import '../../tranlations/locale_keys.g.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accountTypeCubit = AccountTypeCubit.get(context);
    return BlocConsumer<AccountTypeCubit, AccountTypeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              // fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/4.png',
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 90.h, bottom: 40.h),
                  child: Column(
                    children: [
                      whiteMorshedLogo(
                        image: 'assets/images/whiteMorshed.png',
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      AutoSizeText(
                        LocaleKeys.chooseAccountType.tr(),
                        presetFontSizes: [24.sp, 20.sp, 15.sp],
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      SizedBox(
                        height: 290.h,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: typeModel.length,
                          itemBuilder: (context, index) {
                            return accountType(
                                fct: (onChange) {
                                  if (index == 0) {
                                    accountTypeCubit.changeMotamer(
                                        value: onChange);
                                  } else {
                                    accountTypeCubit.changeHajji(
                                        value: onChange);
                                  }
                                },
                                context: context,
                                model: typeModel[index],
                                checkBoxValue: index == 0
                                    ? accountTypeCubit.isUmrah
                                    : accountTypeCubit.isHajji);
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox();
                            // return  Padding(
                          },
                        ),
                      ),
                      const Spacer(),
                      floatingButton(
                          fct: () {
                            if (accountTypeCubit.isHajji == false &&
                                accountTypeCubit.isUmrah == false) {
                              showToast(
                                  text: LocaleKeys.pleaseChooseType.tr(),
                                  state: ToastState.WARNING);

                              print(
                                  'hijji: ${accountTypeCubit.isHajji} || Umrah: ${accountTypeCubit.isUmrah}');
                            } else if(accountTypeCubit.isUmrah == true) {
                              navigateForward(LoginScreen(index: 0,));
                              //showToast(text: 'خدمات المعتمرين ما زالت تحت التطوير', state: ToastState.WARNING);
                            }else{
                              navigateForward(LoginScreen(index: 1,));
                              print(
                                  'hijji: ${accountTypeCubit.isHajji} || Umrah: ${accountTypeCubit.isUmrah}');
                            }
                          },
                          iconColor: lightMainColor,
                          backgroundColor: whiteColor)
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
