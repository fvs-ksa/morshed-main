import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/another_services_cubit/terms_cubit/terms_cubit.dart';
import 'package:morshed/bloc/another_services_cubit/terms_cubit/terms_state.dart';
import 'package:morshed/component/guide_for_hajj_widget.dart';
import '../../constant/const_color.dart';
import '../../tranlations/locale_keys.g.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var termsCubit=TermsCubit.get(context);
    return BlocConsumer<TermsCubit,TermsState>(
        listener: (context,state){},
        builder: (context,state) {
          return Scaffold(
            appBar: headerForHijGuides(
                context: context,
                title: LocaleKeys.privacyPolicy.tr(),
                image: 'assets/images/من نحن.png'),
            body:state is GetTermsLoadingState?Center(child: CircularProgressIndicator.adaptive(
              backgroundColor: orangeColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                darkMainColor, //<-- SEE HERE
              ),
            ),): Padding(
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
                        Text(LocaleKeys.privacyPolicy.tr())
                      ],
                    ),
                    Html(data: termsCubit.getTermsModel.data![0].content??'',)
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
