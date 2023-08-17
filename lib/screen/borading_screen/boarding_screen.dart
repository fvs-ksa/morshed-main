import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/boarding_cubit/cubit.dart';
import 'package:morshed/bloc/boarding_cubit/state.dart';
import 'package:morshed/component/auth_header_widget.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/constant/const_color.dart';
import 'package:morshed/models/boarding_model.dart';
import 'package:morshed/screen/borading_screen/no_internet.dart';
import 'package:morshed/screen/bottom_navigations_screens/main_screen.dart';
import 'package:morshed/utiels/shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'account_type_screen.dart';

class BoardingScreen extends StatefulWidget {
  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  var pageController = PageController();
  StreamSubscription? connection;
  bool? isOffline;
  @override
  void initState() {
    connection = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if(result == ConnectivityResult.none){
        print('ConnectivityResult.none');
        //there is no any connection
        setState(() {
          isOffline = true;
        });
      }else if(result == ConnectivityResult.mobile){
        //connection is mobile data network
        print(' ConnectivityResult.mobile');
        setState(() {
          isOffline = false;
        });
      }else if(result == ConnectivityResult.wifi){
        //connection is from wifi
        print(' ConnectivityResult.wifi');
        setState(() {
          isOffline = false;
        });
      }else if(result == ConnectivityResult.ethernet){
        print('ConnectivityResult.ethernet');
        //connection is from wired connection
        setState(() {
          isOffline = false;
        });
      }
      // else if(result == ConnectivityResult.bluetooth){
      //   //connection is from bluetooth threatening
      //   setState(() {
      //     isOffline = false;
      //   });
      // }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var boardingCubit = BoardingCubit.get(context);
    return BlocConsumer<BoardingCubit, BoardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: isOffline==false?Padding(
              padding: EdgeInsetsDirectional.only(
                  top: 100.h, end: 30.w, start: 30.w),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: whiteMorshedLogo(image: 'assets/images/مرشد.png'),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Expanded(
                    child: PageView.builder(
                      itemCount: boardingList.length,
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return boardingWidget(boardingList[index], context);
                      },
                      onPageChanged: (int i) {
                        if (i == boardingList.length - 1) {
                          print('last');
                          boardingCubit.changeLastBoarding();
                        } else {
                          boardingCubit.isLastBoarding =
                              !boardingCubit.isLastBoarding;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(bottom: 50.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmoothPageIndicator(
                          controller: pageController,
                          count: boardingList.length,
                          effect: SlideEffect(
                              activeDotColor: lightMainColor,
                              dotColor: greyColor,
                              dotWidth: 104.w,
                              dotHeight: 4.h),
                        ),
                        // SizedBox(width: size.width*0.04,),
                        floatingButton(fct: () {
                          if (boardingCubit.isLastBoarding == true) {
                            print('object');
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AccountTypeScreen()),
                            );
                            //navigateForward(AccountTypeScreen());
                            // Get.to(const AccountTypeScreen());
                          } else {
                            pageController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ):NoInternetScreen(child: CacheHelper.getData(key: 'token')==null?BoardingScreen():MainScreen()),
          );
        });
  }
}

Widget boardingWidget(BoardingModel model, BuildContext context) {
  return Column(
    children: [
      Container(
        decoration: const BoxDecoration(shape: BoxShape.circle),
      ),
      Align(
          alignment: Alignment.center,
          child: Image.asset(
            model.image,
          )),
      SizedBox(
        // height: size.height * 0.05,
        height: 45.h,
      ),
      AutoSizeText(
        model.title,
        presetFontSizes: [22.sp, 15.sp, 10.sp],
        style: Theme.of(context).textTheme.displayLarge,
      ),
      SizedBox(
        height: 10.h,
      ),
      AutoSizeText(
        model.subTitle,
        presetFontSizes: [15.sp, 12.sp, 10.sp],
        style: Theme.of(context).textTheme.bodySmall,
      )
    ],
  );
}
