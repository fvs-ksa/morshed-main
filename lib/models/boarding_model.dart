import 'package:easy_localization/easy_localization.dart';

import '../tranlations/locale_keys.g.dart';

class BoardingModel {
  String image;
  String title;
  String subTitle;

  BoardingModel(
      {required this.image, required this.title, required this.subTitle});
}

List<BoardingModel> boardingList = [
  BoardingModel(
      image: 'assets/images/i1.png',
      title: LocaleKeys.boardingTitle1.tr(),
      subTitle: LocaleKeys.boardingSubTitle1.tr()),
  BoardingModel(
      image: 'assets/images/i2.png',
      title: LocaleKeys.boardingTitle2.tr(),
      subTitle: LocaleKeys.boardingSubTitle2.tr()),
];
//LocaleKeys.boardingTitle1.tr()
//LocaleKeys.boardingTitle2.tr()
//LocaleKeys.boardingSubTitle1.tr()
//LocaleKeys.boardingSubTitle2.tr()
