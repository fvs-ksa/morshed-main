import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/general_cubit/general_cubit.dart';
import 'package:morshed/bloc/general_cubit/general_state.dart';
import 'package:morshed/screen/bottom_navigations_screens/widget/resisdance_Widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/cutom_text_filed.dart';
import '../../constant/const_color.dart';
import '../../component/info_profile_component.dart';
import '../../tranlations/locale_keys.g.dart';

class MyResidenceAndTravels extends StatelessWidget {
  const MyResidenceAndTravels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var generalCubit=GeneralCubit.get(context);
    return BlocConsumer<GeneralCubit,GeneralState>(
      listener: (context,state){},
      builder: (context,state) {
        TextEditingController arrivalController=TextEditingController(text: generalCubit.profileModel.data!.arrivalDate!);
        TextEditingController departureController=TextEditingController(text: generalCubit.profileModel.data!.departureDate!);
        TextEditingController mozdalifaLocationController=TextEditingController(text: generalCubit.profileModel.data!.locationMozdalifa??'');
        TextEditingController mennaLocationConroller=TextEditingController(text: generalCubit.profileModel.data!.locationMina??'');
        TextEditingController arafaLocationController=TextEditingController(text: generalCubit.profileModel.data!.locationArfat??'');
        TextEditingController visaNumberController=TextEditingController(text: generalCubit.profileModel.data!.visaNumber!);
        TextEditingController maccaHotelLocationController=TextEditingController(text: generalCubit.profileModel.data!.locationMakkahHotel!);
        TextEditingController madinahHotelNumberController=TextEditingController(text: generalCubit.profileModel.data!.locationMadinahHotel!);
        return Column(
          children: [
            PreferredSize(
                child: Stack(
                  children: [
                    Container(
                      height: 190.h,
                      child: Center(
                          child: FittedBox(
                              child: Text(
                        LocaleKeys.myAccommodationAndTrips.tr(),
                        style: Theme.of(context).textTheme.displayMedium,
                      ))),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/header1.png'),
                              fit: BoxFit.cover)),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 14.w, top: 140.h),
                      child: CircleAvatar(
                        backgroundColor: darkMainColor,
                        child: Image.asset('assets/images/profile.png'),
                        radius: 45.sp,
                      ),
                    )
                  ],
                ),
                preferredSize: Size.fromHeight(220.h)),
            Expanded(
              child:generalCubit.isGetProfile? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Column(
                    children: [
                      // CustomTextField(
                      //   labelText: LocaleKeys.residentialAddress.tr(),
                      //   context: context,
                      // ),
                    accountTypeName=='pilgrimUmrah'?SizedBox():  clikedLocationWidget(controller: mennaLocationConroller, fct: (){
                        launchUrl(Uri.parse(
                            'google.navigation:q='
                                '${generalCubit.profileModel.data!.latitudeMina}, '
                                '${generalCubit.profileModel.data!.longitudeMina}'
                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                      }, context: context, labelText:LocaleKeys.menna_loc.tr()),

                      accountTypeName=='pilgrimUmrah'?SizedBox():   clikedLocationWidget(controller: arafaLocationController, fct: (){
                        launchUrl(Uri.parse(
                            'google.navigation:q='
                                '${generalCubit.profileModel.data!.latitudeArfat}, '
                                '${generalCubit.profileModel.data!.longitudeArfat}'
                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                      }, context: context, labelText: LocaleKeys.arafa_loc.tr()),

                      accountTypeName=='pilgrimUmrah'?SizedBox():  clikedLocationWidget(controller: mozdalifaLocationController, fct: (){
                        launchUrl(Uri.parse(
                            'google.navigation:q='
                                '${generalCubit.profileModel.data!.latitudeMozdalifa}, '
                                '${generalCubit.profileModel.data!.longitudeMozdalifa}'
                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                      }, context: context, labelText: LocaleKeys.mozdalifa_loc.tr()),


                      clikedLocationWidget(controller: maccaHotelLocationController, fct: (){
                        launchUrl(Uri.parse(
                            'google.navigation:q='
                                '${generalCubit.profileModel.data!.latitudeMakkah}, '
                                '${generalCubit.profileModel.data!.longitudeMakkah}'
                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                      }, context: context, labelText: LocaleKeys.macca_hotel_loc.tr()),


                      clikedLocationWidget(controller: madinahHotelNumberController, fct: (){
                        launchUrl(Uri.parse(
                            'google.navigation:q='
                                '${generalCubit.profileModel.data!.latitudeMadinah}, '
                                '${generalCubit.profileModel.data!.longitudeMadinah}'
                                '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                      }, context: context, labelText:  LocaleKeys.madina_hotel_loc.tr()),
                      // GestureDetector(
                      //   onTap: ()async{
                      //     await launchUrl(Uri.parse
                      //       ('google.navigation:q='
                      //         '${generalCubit.profileModel.data!.latitudeMakkah}, '
                      //         '${generalCubit.profileModel.data!.longitudeMakkah}'
                      //         '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                      //
                      //   },
                      //   child: CustomTextField(
                      //       controller: maccaHotelLocationController,
                      //       isEnabled: false,
                      //       labelText: 'عنوان الفندق في مكه المكرمه', ),
                      // ),
                      // GestureDetector(
                      //   onTap: ()async{
                      //     await launchUrl(Uri.parse
                      //       ('google.navigation:q='
                      //         '${generalCubit.profileModel.data!.latitudeMadinah}, '
                      //         '${generalCubit.profileModel.data!.longitudeMadinah}'
                      //         '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                      //
                      //   },
                      //   child: CustomTextField(
                      //       controller: madinahHotelNumberController,
                      //       isEnabled: false,
                      //       labelText: 'عنوان الفندق في المدينه المنوره', ),
                      // ),
                      CustomTextField(
                          isEnabled: false,
                        controller: visaNumberController,
                          labelText: LocaleKeys.visaNo.tr(), ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                isEnabled: false,
                                controller:arrivalController ,
                                labelText:LocaleKeys.arriveDate.tr(),
                               // hintText: '14/2/1966',
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  //  profileCubit.chooseDateTime(context: context);
                                },
                                child: decorationContainerWidget(
                                    radius: 35.sp,
                                    context: context,
                                    child: SvgPicture.asset(
                                        'assets/svg/Calendar.svg'))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomTextField(
                                isEnabled: false,
                                controller: departureController,
                                labelText: LocaleKeys.leaveDate.tr(),
                               // hintText: '14/2/1966',
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  //  profileCubit.chooseDateTime(context: context);
                                },
                                child: decorationContainerWidget(
                                    radius: 35.sp,
                                    context: context,
                                    child: SvgPicture.asset(
                                        'assets/svg/Calendar.svg'))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ):Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: orangeColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      darkMainColor, //<-- SEE HERE
                    ),
                  )),
            ),
          ],
        );
      }
    );
  }
}
