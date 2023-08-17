import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morshed/component/auth_header_widget.dart';
import 'package:morshed/constant/const_color.dart';
import '../../bloc/profile_cubit/cubit.dart';
import '../../bloc/profile_cubit/state.dart';
import '../../models/more_screen_model.dart';
import '../../tranlations/locale_keys.g.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileCubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: 190.h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/header1.png',
                      fit: BoxFit.fitHeight,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          whiteMorshedLogo(
                              image: 'assets/images/whiteMorshed.png'),
                          // GestureDetector(
                          //   onTap: () => navigateForward(const SubscriptionScreen()),
                          //   child: Stack(
                          //     alignment: Alignment.center,
                          //     children: [
                          //       FittedBox(
                          //         child: Container(
                          //           padding: EdgeInsetsDirectional.only(
                          //               end: 6.w, start: 6.w),
                          //           height: 61.h,
                          //           width: 144.w,
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(15.sp),
                          //               image: const DecorationImage(
                          //                   image: AssetImage(
                          //                       'assets/images/supscription.png'),
                          //                   fit: BoxFit.cover)),
                          //           child: FittedBox(
                          //               child: Center(
                          //                   child: AutoSizeText(
                          //                       LocaleKeys.morshedSubscription.tr(),
                          //                       presetFontSizes: [
                          //                         17.sp,
                          //                         13.sp,
                          //                         10.sp
                          //                       ],
                          //                       textAlign: TextAlign.center,
                          //                       style: GoogleFonts.cairo(
                          //                           color: whiteColor,
                          //                           fontSize: 17.sp,
                          //                           fontWeight: FontWeight.w500)))),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  //physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                   // print('<<<<<<<<<<<<<<<<<<$myLocale>>>>>>>>>>>>>>>>>>');
                    return GestureDetector(
                      onTap: () => moreList[index].onTap(),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: Container(
                          height: 64.h,
                          padding: EdgeInsetsDirectional.only(
                              start: 24.w, top: 3.h, bottom: 3.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp)),
                          child: Row(
                            children: [
                              SvgPicture.asset(moreList[index].svgImage),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                      moreList[index].title.tr(),
                                      style: GoogleFonts.cairo(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                          color: blackColor),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: moreList.length,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              state is LogOutLoadingState
                  ? CircularProgressIndicator.adaptive(
                      backgroundColor: orangeColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        darkMainColor, //<-- SEE HERE
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        profileCubit.logOut();
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 8.h),
                        child: Text(
                          LocaleKeys.logOut.tr(),
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
              SizedBox(
                height: 20.h,
              ),
            ],
          );
        });
  }
}
