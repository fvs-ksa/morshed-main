import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morshed/bloc/profile_cubit/cubit.dart';
import 'package:morshed/bloc/profile_cubit/state.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/constant/const_color.dart';
import '../../component/cutom_text_filed.dart';
import '../../component/info_profile_component.dart';
import '../../tranlations/locale_keys.g.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {},
     //   bloc: profileCubit.getProfileDate(),
        builder: (context, state) {
          TextEditingController arNameController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.nameAr : '');
          TextEditingController enNameController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.nameEn : '');
          TextEditingController phoneController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.phoneNumber : '');
          TextEditingController birthDateController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.convertedDateTime ??
                  profileCubit.profileModel.data!.birthdate : '');
          TextEditingController emailController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.email : '');
          TextEditingController passportNoController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.passportNumber : '');
          TextEditingController visaNoController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.visaNumber : '');
          TextEditingController groupNoController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.companyName ?? '' : '');
          TextEditingController agentController = TextEditingController(
              text: profileCubit.isLoading
                  ?
              profileCubit.profileModel.data!.companyName ?? LocaleKeys.no_company_found.tr()
                  : '');
          TextEditingController borderController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.borderNumber : '');
          TextEditingController disabilityController = TextEditingController(
              text: profileCubit.isLoading ?
              profileCubit.profileModel.data!.typeOfDisability : '');

          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: headerInfoPerson(
                  context: context,
                  title: LocaleKeys.profile.tr(),
                  isProfile: true,
                  avatarChild: CircleAvatar(
                    radius: 40.sp,
                    backgroundImage: NetworkImage(
                        profileCubit.isLoading&&profileCubit.isGetNationality ? profileCubit.profileModel.data!
                            .image!
                            : 'https://firebasestorage.googleapis.com/v0/b/murshid-5cf3e.appspot.com/o/profile.png?alt=media&token=9e46dec9-ea36-4118-b7d3-c7d298b302d7'),)),
              body: profileCubit.isLoading?  RefreshIndicator(
                onRefresh: () {return profileCubit.getProfileDate(); },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 40.w, end: 20.w, top: 30),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: arNameController,
                          labelText: LocaleKeys.arabicNamePassport.tr(),

                        ),
                        CustomTextField(
                            controller: enNameController,
                            labelText: LocaleKeys.englishNamePassport.tr(),
                           ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: CustomTextField(
                                    controller: phoneController,
                                    labelText: LocaleKeys.phoneNumber.tr(),
                                    keyboardType: TextInputType.number)),
                            SizedBox(
                              width: 10.w,
                            ),
                            decorationContainerWidget(
                                radius: 35.sp,
                                context: context,
                                child: Text(
                                  '+966',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyLarge,
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                        Theme(
                          data: ThemeData(
                              fontFamily: 'Cairo',

                              textTheme:  TextTheme(subtitle1: GoogleFonts.cairo(fontSize: 12.sp,color: greyColor,))
                          ),
                          child: Container(
                            padding: EdgeInsets.zero,
                            height: 69.h,
                            child: DropdownSearch(
                              popupProps: PopupProps.menu(
                                  searchFieldProps: TextFieldProps(
                                    enableSuggestions: true,
                                    decoration: InputDecoration(

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: darkMainColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: darkMainColor),
                                      ),
                                    ),
                                    style: TextStyle(color: greyColor),
                                  ),
                                  showSearchBox: true
                              ),
                              dropdownButtonProps: DropdownButtonProps(color: greyColor),
                              items: profileCubit.nationalityModel.data!.map((e) => e.name).toList(growable: true),
                              dropdownDecoratorProps:  DropDownDecoratorProps(

                                baseStyle: TextStyle(color: greyColor,fontSize: 12.sp),

                                dropdownSearchDecoration: InputDecoration(

                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: darkMainColor),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(color: darkMainColor),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    helperStyle: TextStyle(color: greyColor),
                                    fillColor: Colors.deepOrangeAccent,
                                    labelText: LocaleKeys.nationality.tr(),
                                    hintText: "",
                                    labelStyle: GoogleFonts.cairo(color: greyColor)
                                ),
                              ),

                              onChanged: (onChange){
                                profileCubit.onChangeNationalityName(onChange);
                                print(onChange);
                              },
                              selectedItem: profileCubit.chooseNationality??profileCubit.profileModel.data!.nationality,
                            ),
                          ),
                        ),
                        // dropDownButton(
                        //   items: profileCubit.nationality.map((e) {
                        //     return DropdownMenuItem(
                        //       child: FittedBox(
                        //         child: Text(
                        //           e.toString(),
                        //           style: Theme
                        //               .of(context)
                        //               .textTheme
                        //               .titleSmall,
                        //         ),
                        //       ),
                        //       value: e.toString(),
                        //     );
                        //   }).toList(),
                        //   value: profileCubit.chooseNationality,
                        //   hint: profileCubit.chooseNationality == null
                        //       ? profileCubit.profileModel.data!.nationality!
                        //       : LocaleKeys.nationality.tr(),
                        //   fct: (onChange) {
                        //     profileCubit.onChangeCountryName(onChange);
                        //   },
                        //   context: context,
                        //   //  validator: () {}
                        // ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                isEnabled: false,
                                controller: birthDateController,
                                labelText:
                                LocaleKeys.dateOfBirth.tr(),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  profileCubit.chooseDateTime(context: context);
                                },
                                child: decorationContainerWidget(
                                    radius: 35.sp,
                                    context: context,
                                    child: SvgPicture.asset(
                                        'assets/svg/Calendar.svg'))),
                          ],
                        ),
                        CustomTextField(
                            labelText: LocaleKeys.email.tr(),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress),
                        CustomTextField(
                            labelText: LocaleKeys.passportNo.tr(),
                            controller: passportNoController,

                        ),
                        CustomTextField(
                            labelText: LocaleKeys.visaNo.tr(),
                            controller: visaNoController,

                        ),
                        CustomTextField(
                            labelText: LocaleKeys.boardNo.tr(),
                            controller: borderController,
                        ),
                        profileCubit.profileModel.data!.disability!
                            ? dropDownButton
                          (items: profileCubit.disabilities.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.toString()), value: e.toString(),);
                        }).toList(),
                            value: profileCubit.chooseDisability,
                            hint: profileCubit.profileModel.data!.typeOfDisability??'',
                            fct: (onChange) {
                              profileCubit.onChangeDisability(onChange);
                            },
                            context: context)
                            : SizedBox(),
                       profileCubit.profileModel.data!.disability!?  SizedBox(height: 30,):SizedBox(),
                        CustomTextField(
                            labelText: LocaleKeys.officialMissionName.tr(),
                            controller: groupNoController,
                            isEnabled: false,
                        ),
                        CustomTextField(
                            controller: agentController,
                            isEnabled: false,
                            labelText: LocaleKeys.agentName.tr(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 8.w),
                          child: state is UpdateProfileLoadingState
                              ? CircularProgressIndicator.adaptive(
                            backgroundColor: orangeColor,)
                              : mainButton(
                              text: LocaleKeys.edit.tr(),
                              color: orangeColor,
                              context: context,
                              fct: () {
                                profileCubit.updateUserInfo
                                  (nameAr: arNameController.text,
                                  nameEn: enNameController.text,
                                  phone: phoneController.text,
                                  context: context,
                                  email: emailController.text,
                                  passport: passportNoController.text,
                                  visaNo: visaNoController.text,
                                  borderNo: borderController.text,
                                  agentName: agentController.text,
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ):Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: orangeColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      darkMainColor, //<-- SEE HERE
                    ),
                  )) ,
            ),
          );
        });
  }
}
