import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:morshed/bloc/notification_cubit/state.dart';
import 'package:morshed/constant/const_color.dart';
import '../../bloc/notification_cubit/cubit.dart';
import '../../tranlations/locale_keys.g.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notificationCubit = NotificationCubit.get(context);
    return BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {},
        bloc: notificationCubit.getNotificationData(),
        builder: (context, state) {
          return notificationCubit.isNotificationGet
              ? notificationCubit.getNotificationModel.notifications!.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/notifications.svg'),
                        SizedBox(
                          height: 2.h,
                        ),
                        Center(
                          child: Text(
                            LocaleKeys.no_notifications.tr(),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        )
                      ],
                    )
                  : Scaffold(
                      body: Column(
                        children: [
                          Card(
                            margin: EdgeInsets.zero,
                            elevation: 3,
                            child: Container(
                              height: 148.h,
                              padding: EdgeInsetsDirectional.only(top: 30.h),
                              child: Center(
                                  child: Text(
                                LocaleKeys.notifications.tr(),
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                          //Divider(),
                          Expanded(
                            child: ListView.separated(
                                padding: EdgeInsetsDirectional.only(top: 10.h),
                                itemBuilder: (context, index) {
                                  DateTime dateTime = DateTime.parse(
                                      notificationCubit.getNotificationModel
                                          .notifications![index].createdAt!);
                                  String date =
                                      "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                                  String time =
                                      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                                  return GestureDetector(
                                    onTap: () {
                                      notificationCubit.markNotificationAsRead(
                                          id: notificationCubit
                                              .getNotificationModel
                                              .notifications![index]
                                              .id!);
                                      //notificationCubit.getNotificationData();
                                    },
                                    child: Container(
                                      color: notificationCubit
                                                  .getNotificationModel
                                                  .notifications![index]
                                                  .read ==
                                              true
                                          ? whiteColor
                                          : whiteGreyColor.withOpacity(0.1),
                                      padding: EdgeInsetsDirectional.only(
                                          start: 20.w, top: 0, bottom: 0),
                                      height: 86.5.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svg/notifications.svg',
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                notificationCubit
                                                    .getNotificationModel
                                                    .notifications![index]
                                                    .title!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge,
                                              ),
                                              const Spacer(),
                                              Text(
                                                date,
                                                style: GoogleFonts.cairo(
                                                    fontSize: 14.sp,
                                                    color: whiteGreyColor,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            notificationCubit
                                                .getNotificationModel
                                                .notifications![index]
                                                .message!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    height: 1,
                                    thickness: 2,
                                    endIndent: 8.w,
                                    indent: 8.w,
                                  );
                                },
                                itemCount: notificationCubit
                                    .getNotificationModel
                                    .notifications!
                                    .length),
                          )
                        ],
                      ),
                    )
              : Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: orangeColor,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      darkMainColor, //<-- SEE HERE
                    ),
                  ),
                );
        });
    //);
  }
}
