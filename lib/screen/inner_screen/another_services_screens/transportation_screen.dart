import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/another_services_cubit/another_service/cubit.dart';
import 'package:morshed/bloc/another_services_cubit/another_service/state.dart';
import 'package:morshed/component/info_profile_component.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/const_color.dart';
import '../../../tranlations/locale_keys.g.dart';

class TransportationScreen extends StatelessWidget {
  const TransportationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var transportationCubit=AnotherServicesCubit.get(context);
    return BlocConsumer<AnotherServicesCubit,AnotherServicesState>(
      listener: (context,state){},
      builder: (context,state) {
        return Scaffold(
          appBar: headerInfoPerson(
              context: context,
              title: LocaleKeys.transports.tr(),
              avatarChild: Image.asset('assets/images/trasportation.png'),
              isProfile: true),
          body:transportationCubit.isGetTransportation? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: GridView.builder(
                itemCount: transportationCubit.transportationModel.data?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.w,
                    crossAxisSpacing: 10.w),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      launchUrl(Uri.parse(
                          'google.navigation:q='
                              '${transportationCubit.transportationModel.data![index].lat}, '
                              '${transportationCubit.transportationModel.data![index].long}'
                              '&key=AIzaSyBVgpiuFIJ2AMh5ZwbgkAu3E47jmyx7_is'));
                    },
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.sp)),
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                                child: Image.network(
                                  transportationCubit.transportationModel.data![index].imagepath??'',
                              // height: 60.03.h,
                              // width: 68.53.w,
                            )),
                            AutoSizeText(
                                transportationCubit.transportationModel.data![index].name??'',
                              presetFontSizes: [12,10,8],
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              softWrap: true,
                            ),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
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
