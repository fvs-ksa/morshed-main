import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/screen/inner_screen/companions_screen.dart';
import 'package:morshed/screen/inner_screen/guides_screen.dart';
import 'package:morshed/screen/inner_screen/my_card_screen.dart';
import 'package:morshed/screen/inner_screen/profile_screen.dart';
import 'package:morshed/screen/inner_screen/setting_screen.dart';

import '../component/navigation_functions.dart';
import '../screen/inner_screen/contact_us.dart';
import '../screen/inner_screen/my_reports/my_reports.dart';
import '../screen/inner_screen/privacy_policy.dart';
import '../screen/inner_screen/support_screen.dart';
import '../tranlations/locale_keys.g.dart';

class MoreScreenModel {
  String title;
  Function onTap;
  String svgImage;

  MoreScreenModel(
      { required this.onTap, required this.svgImage,required this.title,
      });
}

List<MoreScreenModel> moreList = [
  MoreScreenModel(
      title:LocaleKeys.profile,
      onTap: () {
        navigateForward(const ProfileScreen());
      },
      svgImage: 'assets/svg/profile.svg'),
  MoreScreenModel(

      title:LocaleKeys.guides,
      onTap: () {
        navigateForward(GuidesScreen());
      },
      svgImage: 'assets/svg/file (-1.svg'),
  MoreScreenModel(
      title: LocaleKeys.Companions,
      onTap: () {
        navigateForward(EscortsScreen());
      },
      svgImage: 'assets/svg/Group -1.svg'),
  MoreScreenModel(
      title:LocaleKeys.myReports,
      onTap: () {
        navigateForward(const MyReports());
      },
      svgImage: 'assets/svg/file (1).svg'),
  MoreScreenModel(
    title: LocaleKeys.myCard,
      onTap: () {
        navigateForward(const MyCardScreen());
      },
      svgImage: 'assets/svg/Icon awesome-id-card.svg'),
  MoreScreenModel(
    title: LocaleKeys.technicalSupport,
      onTap: () {
        showToast(text: LocaleKeys.service_under_development.tr(), state: ToastState.WARNING);
       // navigateForward(SupportScreen());
      },
      svgImage: 'assets/svg/support.svg'),
  MoreScreenModel(
    title: LocaleKeys.contactUs,
      onTap: () {
        navigateForward(const ContactUs());
      },
      svgImage: 'assets/svg/end call-1.svg'),
  MoreScreenModel(
    title: LocaleKeys.privacyPolicy,
      onTap: () {navigateForward(const TermsScreen());},
      svgImage: 'assets/svg/file (1).svg'),
  MoreScreenModel(
    title:  LocaleKeys.settings,
      onTap: () {
       // showToast(text: 'الخدمه تحت التطوير', state: ToastState.WARNING);
        navigateForward(const SettingScreen());
      },
      svgImage: 'assets/svg/settings.svg'),
  MoreScreenModel(
    title: LocaleKeys.shareMorshed,
      onTap: () {
        showToast(text: LocaleKeys.service_under_development.tr(), state: ToastState.WARNING);
      },
      svgImage: 'assets/svg/share.svg'),
];
