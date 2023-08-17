import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morshed/bloc/general_cubit/general_cubit.dart';
import 'package:morshed/bloc/general_cubit/general_state.dart';
import 'package:morshed/constant/const_color.dart';

import '../../tranlations/locale_keys.g.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var generalCubit = GeneralCubit.get(context);
    return BlocConsumer<GeneralCubit, GeneralState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: generalCubit.screens[generalCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            selectedItemColor: darkMainColor,
            onTap: (i) {
              generalCubit.changeCurrentScreen(i);
            },
            currentIndex: generalCubit.currentIndex,
            unselectedItemColor: greyColor,
            selectedIconTheme: IconThemeData(color: darkMainColor),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(generalCubit.currentIndex == 0
                      ? 'assets/svg/home_active.svg'
                      : 'assets/svg/home.svg'),
                  label: LocaleKeys.home.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(generalCubit.currentIndex == 1
                      ? 'assets/svg/notifi_active.svg'
                      : 'assets/svg/notifi.svg'),
                  label: LocaleKeys.notifications.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(generalCubit.currentIndex == 2
                      ? 'assets/svg/qr_active.svg'
                      : 'assets/svg/qr.svg'),
                  label: LocaleKeys.myBarcode.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(generalCubit.currentIndex == 3
                      ? 'assets/svg/myTripsActive.svg'
                      : 'assets/svg/myTripsInActive.svg'),
                  label: LocaleKeys.myAccommodationAndTrips.tr()),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(generalCubit.currentIndex == 4
                      ? 'assets/svg/more_active.svg'
                      : 'assets/svg/more.svg'),
                  label: LocaleKeys.more.tr()),
            ],
          ),
        );
      },
    );
  }
}
