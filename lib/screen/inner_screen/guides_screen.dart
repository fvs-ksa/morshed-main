import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/bloc/guides_cubit/state.dart';
import 'package:morshed/component/animation_component.dart';
import 'package:morshed/component/component.dart';
import 'package:morshed/component/guide_escorts_component.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/guides_cubit/cubit.dart';
import '../../constant/const_color.dart';
import '../../tranlations/locale_keys.g.dart';

class GuidesScreen extends StatefulWidget {
  int? index;

  GuidesScreen({this.index});

  @override
  State<GuidesScreen> createState() => _GuidesScreenState();
}

class _GuidesScreenState extends State<GuidesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var guidesCubit = GuidesCubit.get(context);
    return BlocConsumer<GuidesCubit, GuidesState>(
        // bloc: guidesCubit.getAllGuides(),
        listener: (context, state) {},
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              // appBar: AppBar(
              //   leading: backButtonWidget(context: context),
              //   title: const Text('المرشدين'),
              //   centerTitle: true,
              //   actions: [SvgPicture.asset('assets/svg/')],
              //   backgroundColor: whiteColor,
              //   // toolbarHeight: 180.h,
              //   bottom: PreferredSize(
              //       preferredSize: Size.fromHeight(120.h),
              //       child: Padding(
              //         padding:
              //         EdgeInsetsDirectional.only(start: 18.0.w, end: 18.w,bottom: 18.h),
              //         child:  const AutoSizeText('خدمه البحث عن طريق الاسم ورقم الجوال ما زالت تحت التطوير',maxLines: 1,style: TextStyle(
              //             color: Colors.red,
              //            // fontFamily: 'cairo',
              //             fontWeight: FontWeight.bold
              //
              //         )),
              //         // child: Row(
              //         //   children: [
              //         //     Expanded(
              //         //         child: textFormField(
              //         //             labelText: 'البحث عن طريق الاسم او رقم الجواز',
              //         //             context: context)),
              //         //     SizedBox(
              //         //       width: 12.w,
              //         //     ),
              //         //     Padding(
              //         //       padding: EdgeInsetsDirectional.only(bottom: 14.0.h),
              //         //       child: mainButton(
              //         //           width: 73.w,
              //         //           height: 54.h,
              //         //           text: 'بحث',
              //         //           color: darkMainColor,
              //         //           context: context,
              //         //           fct: () {}),
              //         //     )
              //         //   ],
              //         // ),
              //       )),
              // ),
              appBar: headerForGuide(
                  context: context,
                  title: widget.index == 1
                      ?LocaleKeys.videoCall.tr()
                      : LocaleKeys.guides.tr(),
                  searchController: searchController,
                  dropDownWidget: widget.index == 1
                      ? SizedBox()
                      : Container(
                          padding: EdgeInsetsDirectional.only(start: 10.w),
                          height: 90.h,
                          width: 88.w,
                          child: dropDownButton(
                            items: guidesCubit.flags.map((e) {
                              return DropdownMenuItem(
                                child: Image.asset(e["flag"].toString()),
                                value: e['id'].toString(),
                              );
                            }).toList(),
                            value: guidesCubit.flag,
                            isFlag: true,
                            hint: LocaleKeys.country.tr(),
                            fct: (onChange) {
                              guidesCubit.onChangeFlagsSearch(onChange);
                              print(onChange);
                            },
                            context: context,
                            //  validator: () {}
                          ),
                        ),
                  fct: () {
                    searchController.text.isEmpty
                        ? null
                        : guidesCubit.searchProvider(
                            name: searchController.text,
                            langId: guidesCubit.flag ?? '');
                  }),
              backgroundColor: whiteGreyColor,
              body: guidesCubit.isProvidersGet
                  ? guidesCubit.getProvidersModel.providers!.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              LocaleKeys.no_service_provider.tr(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () {
                            return guidesCubit.getAllGuides();
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 10.h, start: 8.w, end: 8.w),
                            child: ListView.builder(
                                itemCount: guidesCubit
                                    .getProvidersModel.providers!.length,
                                itemBuilder: (context, index) {
                                  return itemContainerOfGuidesAndEscorts(
                                      context: context,
                                      image: 'assets/images/profile.png',
                                      name: guidesCubit.getProvidersModel
                                          .providers![index].name!,
                                      phone: guidesCubit.getProvidersModel
                                          .providers![index].phoneNumber!,
                                      contactColumn: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          circleAvtarWidget(
                                              svgImage:
                                                  'assets/svg/end call.svg',
                                              fct: () async {
                                                makePhoneCall(guidesCubit
                                                    .getProvidersModel
                                                    .providers![index]
                                                    .phoneNumber!);
                                              }),
                                          circleAvtarWidget(
                                              svgImage: 'assets/svg/msg.svg',
                                              fct: () {
                                                  showToast(text:LocaleKeys.service_under_development.tr(), state: ToastState.WARNING);
                                                // navigateForward(
                                                //     ChatWithGuidesScreen(
                                                //   channelName: guidesCubit
                                                //       .getProvidersModel
                                                //       .providers![index]
                                                //       .id
                                                //       .toString(),
                                                // ));
                                              })
                                        ],
                                      ));
                                }),
                          ),
                        )
                  : Center(
                      child: CircularProgressIndicator.adaptive(
                      backgroundColor: orangeColor,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        darkMainColor, //<-- SEE HERE
                      ),
                    )),
            ),
          );
        });
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
