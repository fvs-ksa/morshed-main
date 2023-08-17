import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/const_color.dart';
import '../models/api_model/profile_model.dart';

void showToast({required String text, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseColor(state),
        textColor: Colors.white,
        fontSize: 16.0.sp);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = orangeColor;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget richText(
    {required Function navigation,
    required String text,
    required String tappedText,
    required BuildContext context}) {
  return Text.rich(TextSpan(
      text: text,
      style: Theme.of(context).textTheme.titleSmall,
      children: [
        TextSpan(
            text: tappedText,
            style: TextStyle(
                fontSize: 17.sp,
                color: darkMainColor,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                navigation();
              })
      ]));
}
cardIdWidget({required ProfileModel model,required BuildContext context,
// double? height,
//   double? width,
}){
 return Padding(
   padding: const EdgeInsets.all(28.0),
   child: Card(
     elevation: 3,
     clipBehavior: Clip.antiAliasWithSaveLayer,
     color: darkMainColor,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
     child: Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 16.h,horizontal: 16.w),

          child: Container(
            height: 200,
            width:double.infinity,
            decoration: BoxDecoration(
              color: darkMainColor,
              borderRadius: BorderRadius.circular(25),

            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Column(
                children: [
                  ListTile(leading:CircleAvatar(backgroundImage: NetworkImage(model.data!.image!),radius: 30,) ,
                    title: Text(model.data!.nameAr!,style: Theme.of(context).textTheme.labelMedium,maxLines: 1,),
                    subtitle: Text(model.data!.id!.toString(),style: Theme.of(context).textTheme.labelMedium,),
                    trailing:
                      Container(
                          height: 60,
                          width: 60,
                          child: FittedBox(child: Image.network(model.data!.qrCode!))),
                  ),
                  // Row(children: [
                  //
                  //
                  //  // SizedBox(width: 10,),
                  //
                  //   // Spacer(),
                  //   // Container(
                  //   //     height: 60,
                  //   //     width: 60,
                  //   //     child: FittedBox(child: Image.network(model.data!.qrCode!)))
                  // ],),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.data!.nationality!,style: Theme.of(context).textTheme.labelMedium,),
                      Text(model.data!.arrivalDate!,style: Theme.of(context).textTheme.labelMedium,)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(model.data!.companyName??'',style: Theme.of(context).textTheme.labelMedium,),
                      Text(model.data!.departureDate!,style: Theme.of(context).textTheme.labelMedium,)
                    ],
                  )

                ],
              ),
            ),
          )
      ),
   ),
 );
}
cardIdWidgetSmallSize({required ProfileModel model,required BuildContext context,
  // double? height,
  // double? width,
}){
  TextStyle style=GoogleFonts.cairo(
    fontSize: 7,
    color: whiteColor,
    fontWeight: FontWeight.normal,
  );
  return Card(
    elevation: 3,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: darkMainColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
    child: Container(
        padding: EdgeInsetsDirectional.symmetric(vertical: 5.h,horizontal: 5.w),

        child: Container(
          height: 130,
          width:178.86.w,
          decoration: BoxDecoration(
            color: darkMainColor,
            borderRadius: BorderRadius.circular(25),

          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      CircleAvatar(backgroundImage: NetworkImage(model.data!.image!),radius: 17,),
                      Container(
                          height: 30,
                          width: 30,
                          child: FittedBox(child: Image.network(model.data!.qrCode!))),
                    ],
                ),
               //  ListTile(leading: ,
               //
               //   // title: Container(height: 25,child: AutoSizeText(model.data!.nameAr!,presetFontSizes: [7,3,1],style: style,softWrap: true)),
               // //   subtitle: AutoSizeText(model.data!.id!.toString(),style: style,),
               //    trailing:
               //
               //  ),
                // Row(children: [
                //
                //
                //  // SizedBox(width: 10,),
                //
                //   // Spacer(),
                //   // Container(
                //   //     height: 60,
                //   //     width: 60,
                //   //     child: FittedBox(child: Image.network(model.data!.qrCode!)))
                // ],),
                SizedBox(height: 7,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(model.data!.nameAr!,style: style,softWrap: true),
                    AutoSizeText(model.data!.id!.toString(),style: style,softWrap: true)
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.data!.nationality??'',style: style,),
                    Text(model.data!.arrivalDate??'',style: style,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.data!.companyName??'',style: style,),
                    Text(model.data!.departureDate??"",style: style,)
                  ],
                )

              ],
            ),
          ),
        )
    ),
  );
}
