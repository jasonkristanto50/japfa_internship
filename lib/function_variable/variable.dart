import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

String appName = "Japfa Internship";
const String baseUrl = 'http://localhost:3000';
Dio dio = Dio();
int jumlahMaksimalPeserta = 55;

// pendaftar magang & kunjungan yg blm diterima
String rolePendaftarValue = "pendaftar";
String rolePesertaMagangValue = "peserta magang";

String statusMagangDiterima = 'Diterima';
String statusMagangDitolak = 'Ditolak';
String statusMagangMenunggu = 'On Process';
String statusMagangBerlangsung = 'Sedang Berlangsung';
String statusMagangSelesai = 'Selesai';

String statusKunjunganDiterima = 'Diterima';
String statusKunjunganDitolak = 'Ditolak';
String statusKunjunganMenunggu = 'Menunggu';

String durasiSesi1 = '08.30 - 12.00';
String durasiSesi2 = '13.00 - 16.00';

var pilihanJamKunjunganStudi = [
  DropdownMenuItem<String>(
    value: 'sesi1',
    child: Text('Sesi 1 ($durasiSesi1)'),
  ),
  DropdownMenuItem<String>(
    value: 'sesi2',
    child: Text('Sesi 2 ($durasiSesi2)'),
  ),
];

// Colors
Color japfaOrange = const Color.fromARGB(255, 252, 146, 48);
Color lightOrange = const Color(0xFFF7D39F);
Color lightBlue = const Color.fromARGB(255, 152, 209, 255);
Color darkGrey = const Color.fromARGB(255, 50, 50, 50);

// Image path
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
