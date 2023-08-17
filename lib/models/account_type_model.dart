import 'package:easy_localization/easy_localization.dart';

import '../tranlations/locale_keys.g.dart';

class AccountTypeModel {
  int id;
  bool isTabbed;
  String name;
  String image;

  AccountTypeModel(
      {required this.image,
      required this.id,
      required this.name,
      required this.isTabbed});
}

List<AccountTypeModel> typeModel = [
  AccountTypeModel(
      image: 'assets/images/umrah.png',
      id: 0,
      name: LocaleKeys.moetmer.tr(),
      isTabbed: false),
  AccountTypeModel(
      image: 'assets/images/hajj.png',
      id: 1,
      name: LocaleKeys.hajji.tr(),
      isTabbed: false),
];
