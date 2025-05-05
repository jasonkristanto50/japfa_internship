import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String appName = "Japfa Internship";
Dio dio = Dio();
Color japfaOrange = const Color.fromARGB(255, 252, 146, 48);
Color lightBlue = const Color.fromARGB(255, 152, 209, 255);
Color darkGrey = const Color.fromARGB(255, 50, 50, 50);

String japfaBuduranImgPath = 'assets/japfa_buduran_landscape.jpg';
String japfaLogoBackgroundImgPath = 'assets/japfa_logo_background.png';

const String montserratFontFamily = 'assets/fonts/Montserrat';

TextStyle regular12 = TextStyle(
  fontFamily: montserratFontFamily,
  fontSize: 12.sp,
);

TextStyle regular14 = TextStyle(
  fontFamily: montserratFontFamily,
  fontSize: 14.sp,
);

TextStyle regular16 = TextStyle(
  fontFamily: montserratFontFamily,
  fontSize: 16.sp,
);

TextStyle regular20 = TextStyle(
  fontFamily: montserratFontFamily,
  fontSize: 20.sp,
);

TextStyle regular24 = TextStyle(
  fontFamily: montserratFontFamily,
  fontSize: 24.sp,
);

TextStyle regular30 = TextStyle(
  fontFamily: montserratFontFamily,
  fontSize: 30.sp,
);

TextStyle regular34 = TextStyle(
  fontFamily: montserratFontFamily,
  fontSize: 34.sp,
);

TextStyle bold12 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 12.sp,
);

TextStyle bold13 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 13.sp,
);

TextStyle bold14 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 14.sp,
);

TextStyle bold16 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 16.sp,
);

TextStyle bold18 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 16.sp,
);

TextStyle bold20 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 20.sp,
);

TextStyle bold24 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 24.sp,
);

TextStyle bold28 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 26.sp,
);

TextStyle bold30 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 30.sp,
);

TextStyle bold34 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.bold,
  fontSize: 34.sp,
);

TextStyle light12 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.normal,
  fontSize: 12.sp,
);

TextStyle light16 = TextStyle(
  fontFamily: montserratFontFamily,
  fontWeight: FontWeight.normal,
  fontSize: 16.sp,
);
