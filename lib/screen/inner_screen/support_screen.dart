import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:morshed/bloc/chat_cubit/chat_with_support_cubit/chat_support_state.dart';
import '../../bloc/chat_cubit/chat_with_support_cubit/chat_support_cubit.dart';
import '../../constant/const_color.dart';
import '../../component/guide_escorts_component.dart';
import '../../tranlations/locale_keys.g.dart';

class SupportScreen extends StatefulWidget {
  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  TextEditingController messageController = TextEditingController();
  EdgeInsets _viewInsets = EdgeInsets.zero;
  SingletonFlutterWindow? window;

  @override
  void initState() {
    super.initState();
    window = WidgetsBinding.instance.window;
    window?.onMetricsChanged = () {
      setState(() {
        final window = this.window;
        if (window != null) {
          _viewInsets = EdgeInsets.fromWindowPadding(
            window.viewInsets,
            window.devicePixelRatio,
          ).add(EdgeInsets.fromWindowPadding(
            window.padding,
            window.devicePixelRatio,
          )) as EdgeInsets;
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    var chatWithSupportCubit = ChatWithSupportCubit.get(context);
    return BlocConsumer<ChatWithSupportCubit, ChatWithSupportState>(
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              appBar: headerOfTechnicalSupport(
                  context: context, title: LocaleKeys.technicalSupport.tr()),
              backgroundColor: whiteGreyColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(15.sp),
                                topEnd: Radius.circular(15.sp),
                                topStart: Radius.circular(15.sp),
                              ),
                            ),
                            child: Text(
                              chatWithSupportCubit.messages[index],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5.h,
                        );
                      },
                      itemCount: chatWithSupportCubit.messages.length),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: _viewInsets.bottom,
                  top: 6.h,
                  start: 7.w,
                  end: 7.w,
                ),
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 15.h),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    height: 64.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.sp),
                        color: whiteColor),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap: () {
                              chatWithSupportCubit.arabicTextField(
                                  controller: messageController);
                            },
                            controller: messageController,
                            style: Theme.of(context).textTheme.bodySmall,
                            decoration: InputDecoration(
                                hintText: LocaleKeys.sendMessage.tr(),
                                focusColor: greyColor,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteColor),
                                  borderRadius: BorderRadius.circular(20.sp),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteColor),
                                  borderRadius: BorderRadius.circular(20.sp),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: whiteColor),
                                  borderRadius: BorderRadius.circular(20.sp),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            messageController.text.isEmpty
                                ? debugPrint('galal')
                                : chatWithSupportCubit
                                    .sendTextMessage(messageController.text);
                            messageController.clear();
                          },
                          child: CircleAvatar(
                              child: SvgPicture.asset(
                            'assets/svg/Icon ionic-ios-send.svg',
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
