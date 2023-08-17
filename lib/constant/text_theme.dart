import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'const_color.dart';

TextTheme responsiveTextTheme(BuildContext cxt) {
  Size screenWidth = MediaQuery.of(cxt).size;

  // Customize these values to set the base font size for different screen sizes
  double baseFontSize = screenWidth.width < 600 ? 14 : 16;

  return ThemeData.light().textTheme.copyWith(
        displayLarge: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: blackColor,
          height: 1.3,
        ),
        bodySmall: GoogleFonts.cairo(
          fontSize: 20,
          color: greyColor,
          fontWeight: FontWeight.normal,
        ),
        displayMedium: GoogleFonts.cairo(
            fontSize: 24,
            color: whiteColor,
            fontWeight: FontWeight.bold,
            height: 1.3),
        headlineSmall: GoogleFonts.cairo(
          fontSize: 20,
          color: blackColor,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: GoogleFonts.cairo(
            fontSize: 17, color: whiteColor, fontWeight: FontWeight.bold),
        titleMedium: GoogleFonts.cairo(
          fontSize: 20,
          color: whiteColor,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: GoogleFonts.cairo(
          fontSize: 17,
          color: blackColor,
          fontWeight: FontWeight.normal,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 17,
          color: darkMainColor,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.cairo(
          fontSize: 20,
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 20,
          color: blackColor,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: GoogleFonts.cairo(
          fontSize: 14,
          color: whiteColor,
          fontWeight: FontWeight.bold,
        ),
        headlineLarge: GoogleFonts.cairo(
          fontSize: 17,
          color: blackColor,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: GoogleFonts.cairo(
          fontSize: 14,
          color: greyColor,
          fontWeight: FontWeight.normal,
        ),

        titleLarge: GoogleFonts.cairo(
          fontSize: 17,
          color: orangeColor,
          fontWeight: FontWeight.normal,
        ),
        headlineMedium: GoogleFonts.cairo(
            fontSize: 17,
            color: orangeColor,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline),

        // bodySmall: GoogleFonts.cairo(fontSize: baseFontSize * 0.875,color: whiteColor,fontWeight: FontWeight.normal),
        // headlineSmall:GoogleFonts.cairo(fontSize: baseFontSize * 0.875,color: whiteColor,fontWeight: FontWeight.normal),
        // headlineMedium: GoogleFonts.cairo(color: darkMainColor,decoration: TextDecoration.underline,fontWeight: FontWeight.bold),
        //titleSmall:
      );
}
