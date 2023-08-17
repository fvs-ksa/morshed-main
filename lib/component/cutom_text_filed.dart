import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/const_color.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onTap;
  final int? length;
  final int? lines;
  final double? maxHeight;
  final double? minHeight;
  final double? maxWidth;
  final double? minWidth;
  final Function? validator;
  final bool? secure;
  bool isBig = false;
  bool isEnabled = true;

  CustomTextField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.secure,
    this.prefixIcon,
    this.isBig = false,
    this.isEnabled = true,
    this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.length,
    this.lines,
    this.validator,
    this.maxHeight,
    this.minHeight,
    this.maxWidth,
    this.minWidth,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: TextFormField(

        controller: widget.controller,
        style: GoogleFonts.cairo(
            fontSize: 14.sp, fontWeight: FontWeight.w600, color: blackColor),
        onTap: () {
          widget.onTap==null?setState((){
            widget.controller?.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller!.text.length));
          }): print('');
        },
        maxLines: widget.lines ?? 1,
        maxLength: widget.length,
        decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.only(
                start: 10.w, top: widget.isBig ? 20.h : 0.0),
            constraints: BoxConstraints(
                minHeight: widget.minHeight ?? 54.h,
                minWidth: widget.minWidth ?? 330.w,
                maxHeight: widget.maxHeight ?? 54.h,
                maxWidth: widget.maxWidth ?? 360.w),
            suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
            labelText: widget.labelText,
            labelStyle: GoogleFonts.cairo(
                fontSize: 14.sp, fontWeight: FontWeight.w600, color: greyColor),
            hintText: widget.hintText,
            errorStyle: GoogleFonts.cairo(fontSize: 8, color: Colors.red),
            hintStyle: GoogleFonts.cairo(
                fontSize: 14.sp, fontWeight: FontWeight.w600, color: greyColor),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.sp))),
        validator: (val) {
          return widget.validator!(val);
        },
        keyboardType: widget.keyboardType,
        obscureText: widget.secure ?? false,
        enabled: widget.isEnabled,
      ),
    );
  }
}
