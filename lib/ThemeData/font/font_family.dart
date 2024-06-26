import 'package:dthlms/ThemeData/FontSize/FontSize.dart';
import 'package:dthlms/ThemeData/color/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontFamily {
  static var font = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorPage.colorblack,
          fontSize: ClsFontsize.Small,
          fontWeight: FontWeight.bold));
  static var fontWhite = GoogleFonts.outfit(
      textStyle: TextStyle(
          color: ColorPage.white,
          fontSize: ClsFontsize.Small,
          fontWeight: FontWeight.bold));
  // used in -->
  //forgetPasswordMobile
  // Mobilelogin
  //signInOtpScreen
  //ForgotScreen
  //HomePage
  //DthLmsLogin
  //OTPScreen
  //Profile

  static var font2 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorPage.white,
          fontSize: ClsFontsize.ExtraSmall,
          fontWeight: FontWeight.bold));
  //used in -->
  //signInOtpScreen
  //OTPScreen
  //MyClassDashboard
  //MyClassContent
  //Profile
  //StudyDashboard
  //StudyMaterialPdf
  //StudyMaterialDashboard
  //Dashboard

  static var mobilefont = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorPage.colorgrey,
          fontSize: ClsFontsize.ExtraSmall,
          fontWeight: FontWeight.bold));
  //used in -->
  //Mobilelogin
  //DthLmsLogin
  //StudyMaterialPdf
  //StudyMaterialDashboard

  static var font3 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: Colors.white, fontSize: ClsFontsize.ExtraSmall));
  //used in -->
  //forgetPasswordMobile
  //signInOtpScreen
  //ForgotScreen
  //OTPScreen
  //ButtonWidget

  static var font4 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorPage.colorblack, fontSize: ClsFontsize.ExtraSmall - 2));
  //used in -->
  //MobileHomepage
  //signInOtpScreen
  //MyClassVideoContent

  static var font5 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: ColorPage.white, fontSize: ClsFontsize.ExtraLarge));
  //used in -->
  //MobileHomepage

  static var font6 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorPage.colorblack, fontSize: ClsFontsize.Large - 2));
  //used in -->
  //MobileHomepage

  static var font7 = GoogleFonts.poppins(
      textStyle:
          TextStyle(color: ColorPage.white, fontSize: ClsFontsize.Large - 2));
  // used in
  // PackageDashboardMobile

  // ignore: non_constant_identifier_names
  static var ResendOtpfont = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorPage.red,
          fontSize: ClsFontsize.ExtraSmall,
          fontWeight: FontWeight.bold));
  //used in -->
  //signInOtpScreen

  static var font8 = GoogleFonts.poppins(
      textStyle: TextStyle(
          color: ColorPage.white, fontSize: ClsFontsize.DoubleExtraSmall - 2));

  static var font9 = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: ColorPage.white,
    fontSize: ClsFontsize.DoubleExtraSmall,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0.0, 0.0),
        blurRadius: 1.0,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      // Shadow(
      //   offset: Offset(2.0, 2.0),
      //   blurRadius: 2.0,
      //   color: Color.fromARGB(255, 255, 255, 255),
      // ),
      // Shadow(
      //   offset: Offset(2.0, 2.0),
      //   blurRadius: 3.0,
      //   color: Color.fromARGB(255, 0, 255, 187),
      // ),
      // Shadow(
      //   offset: Offset(2.0, 2.0),
      //   blurRadius: 4.0,
      //   color: Color.fromARGB(255, 255, 0, 128),
      // ),
      //  Shadow(
      //   offset: Offset(2.0, 2.0),
      //   blurRadius: 5.0,
      //   color: Color.fromARGB(255, 68, 159, 255),
      // ),
      //  Shadow(
      //   offset: Offset(2.0, 2.0),
      //   blurRadius: 6.0,
      //   color: Color.fromARGB(255, 0, 251, 255),
      // ),
    ],
  ));
}
