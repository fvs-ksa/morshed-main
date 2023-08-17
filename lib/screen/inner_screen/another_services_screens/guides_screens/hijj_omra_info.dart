import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/another_services_cubit/another_service/cubit.dart';
import 'package:morshed/bloc/another_services_cubit/another_service/state.dart';
import 'package:morshed/component/guide_for_hajj_widget.dart';
import '../../../../constant/const_color.dart';
import '../../../../tranlations/locale_keys.g.dart';

class HijAndOmraInfoScreen extends StatelessWidget {
  const HijAndOmraInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var higInfoCubit=AnotherServicesCubit.get(context);
    return BlocConsumer<AnotherServicesCubit,AnotherServicesState>(
      listener: (context,index){},
      builder: (context,index) {
        return Scaffold(
          appBar: headerForHijGuides(
              context: context,
              title: LocaleKeys.umrahAndHajjInformation.tr(),
              image: 'assets/images/umrah.png'),
          body:higInfoCubit.isGetinfoHajji? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ListView.separated(itemBuilder: (context,index){return Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/svg/Path 198320.svg'),
                    SizedBox(
                      width: 15.w,
                    ),
                    Text(higInfoCubit.infoHajjiModel.data![index].title??'')
                  ],
                ),
                Text(
                  higInfoCubit.infoHajjiModel.data![index].content??'',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            );}, separatorBuilder: (context,index){
              return SizedBox(height: 10,);
            }, itemCount: higInfoCubit.infoHajjiModel.data!.length),
          ):Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: orangeColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                darkMainColor, //<-- SEE HERE
              ),
            ),
          ),
        );
      }
    );
  }
}
