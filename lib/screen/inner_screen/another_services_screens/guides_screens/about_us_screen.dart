import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/another_services_cubit/about_us_cubit/cubit.dart';
import 'package:morshed/bloc/another_services_cubit/about_us_cubit/state.dart';
import 'package:morshed/component/guide_for_hajj_widget.dart';
import '../../../../tranlations/locale_keys.g.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var aboutCubit=AboutUsCubit.get(context);
    return BlocConsumer<AboutUsCubit,AboutUsState>(
      listener: (context,state){},
      builder: (context,state) {
        return Scaffold(
          appBar: headerForHijGuides(
              context: context,
              title: LocaleKeys.aboutMorshed.tr(),
              image: 'assets/images/من نحن.png'),
          body:state is GetAboutInfoLoadingState?Center(child: CircularProgressIndicator(),): Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/Path 198320.svg'),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(LocaleKeys.aboutMorshed.tr())
                    ],
                  ),
                  Html(data: aboutCubit.aboutModel.data!.content??'',),
                  // Text(
                  //   aboutCubit.aboutModel.data!.content!,
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
