import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/component/cutom_text_filed.dart';
import 'package:morshed/component/guide_escorts_component.dart';
import 'package:morshed/constant/const_color.dart';
import '../../bloc/companions_cubit/cubit.dart';
import '../../bloc/companions_cubit/state.dart';
import '../../component/info_profile_component.dart';
import '../../tranlations/locale_keys.g.dart';

class AddCompanionsScreen extends StatelessWidget {
   AddCompanionsScreen({Key? key}) : super(key: key);
  final  _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var addCompanionsCubit = AddCompanionsCubit.get(context);
    TextEditingController passportNoController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();
    return BlocConsumer<AddCompanionsCubit, AddCompanionsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: headerOfTechnicalSupport(
                  context: context, title: LocaleKeys.addCompanion.tr()),
              body: Padding(
                padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 10.w, vertical: 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                          labelText:
                              LocaleKeys.passportIdResidencePermitNumber.tr(),
                          controller: passportNoController,
                        validator: (String val){
                            if(val.isEmpty){
                              return LocaleKeys.enter_id.tr();
                            }
                        },
                          ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                isEnabled: false,
                               // context: context,
                                controller: birthDateController,
                                labelText: LocaleKeys.dateOfBirth.tr(),
                                validator: (String val){
                                  if(val.isEmpty){
                                    return LocaleKeys.enter_date_of_birth.tr();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 19.w,
                            ),
                            GestureDetector(
                              onTap: () async {
                                addCompanionsCubit.chooseDateTime(
                                    context: context, controller: birthDateController);
                              },
                              child: decorationContainerWidget(
                                  context: context,
                                  child: Center(
                                      child: SvgPicture.asset(
                                          'assets/svg/Calendar.svg')),
                                  radius: 35.sp),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                     state is AddCompanionLoadingState?CircularProgressIndicator.adaptive(
                       backgroundColor: orangeColor,
                       valueColor: AlwaysStoppedAnimation<Color>(
                         darkMainColor, //<-- SEE HERE
                       ),
                     ): mainButton(
                          text: LocaleKeys.add.tr(),
                          color: darkMainColor,
                          context: context,
                          fct: () {
                            if(_formKey.currentState!.validate()){
                              addCompanionsCubit.addCompanions(
                                date: birthDateController.text,
                                passportNumber: passportNoController.text,
                              );
                            }

                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
