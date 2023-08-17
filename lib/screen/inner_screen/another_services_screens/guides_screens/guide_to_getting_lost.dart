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

class GuideToGettingLostScreen extends StatelessWidget {
  const GuideToGettingLostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var infoGuideCubit=AnotherServicesCubit.get(context);
    return BlocConsumer<AnotherServicesCubit,AnotherServicesState>(
      listener: (context,state){},
      builder: (context,state) {
        return Scaffold(
          appBar: headerForHijGuides(
              context: context,
              title: LocaleKeys.GuidebookForLostPersons.tr(),
              image: 'assets/images/lost.png'),
          body:infoGuideCubit.isGetinfoGuide? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ListView.separated(itemBuilder: (context,index){
              return Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/Path 198320.svg'),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(infoGuideCubit.infoGuideModel.data![index].name??'')
                    ],
                  ),
                  Text(
                    infoGuideCubit.infoGuideModel.data![index].content??'',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              );
            }, separatorBuilder: (context,index){
              return SizedBox(height: 10,);
            }, itemCount: infoGuideCubit.infoGuideModel.data!.length),
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
