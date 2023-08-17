import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/component/cutom_text_filed.dart';
import 'package:morshed/component/info_profile_component.dart';
import '../../component/navigation_functions.dart';
import '../../tranlations/locale_keys.g.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller=TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/contact_header.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 30.w, top: 70.h,end: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      backButtonWidget(context: context),
                      SizedBox(
                        height: 64.h,
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text(
                          LocaleKeys.contactUs.tr(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            preferredSize: Size.fromHeight(220.h)),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsetsDirectional.only(top: 19.h, start: 19.h, end: 19.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.contactViaWhatsApp.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                    onTap: () {
                      launchWhatsapp(context);
                    },
                    child: CustomTextField(
                      labelText: '9660501342728+',
                      isEnabled: false,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  LocaleKeys.contactViaEmail.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                    onTap: () {
                      navigateToMail(context);
                    },
                    child: CustomTextField(
                        labelText: 'info@guide.com',
                        isEnabled: false,)),
                // SizedBox(
                //   height: 10.h,
                // ),
                // Text(
                //   LocaleKeys.weArePleasedToAnswerYourInquiry.tr(),
                //   style: Theme.of(context).textTheme.bodyMedium,
                // ),
                // bigTextFieldForNotes(
                //   controller:controller ,
                //     context: context, hint: LocaleKeys.writeHere.tr()),
                // Padding(
                //   padding: EdgeInsetsDirectional.only(
                //       top: 20.h, bottom: 10.h, start: 15.w, end: 15.w),
                //   child: Align(
                //       alignment: Alignment.center,
                //       child: mainButton(
                //           text: LocaleKeys.sendInquiry.tr(),
                //           color: darkMainColor,
                //           context: context,
                //           fct: () {})),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
