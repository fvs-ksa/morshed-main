import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/general_cubit/general_cubit.dart';
import 'package:morshed/bloc/general_cubit/general_state.dart';
import 'package:morshed/bloc/login_cubit/login_cubit.dart';
import 'package:morshed/constant/const_color.dart';

import '../../tranlations/locale_keys.g.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var generalCubit=GeneralCubit.get(context);
    return BlocConsumer<GeneralCubit,GeneralState>(
      listener: (context,state){

      },
      builder: (context,state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/qr code bg.png',
                      ),
                      fit: BoxFit.fitWidth)),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 80.h),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.sp,
                    backgroundImage: NetworkImage(generalCubit.profileModel.data!.image!),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    generalCubit.profileModel.data!.nameAr!,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    LocaleKeys.provideYourCodeToAssistYou.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  Container(
                    height: 258.h,
                    width: 258.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        border: Border.all(
                          color: whiteColor,
                        ),
                        image:  DecorationImage(
                          image: NetworkImage(generalCubit.profileModel.data!.qrCode!),
                        )),
                    //child: Image.asset('assets/images/qrCode.png')
                  )
                ],
              ),
            )
          ],
        );
      }
    );
  }
}
