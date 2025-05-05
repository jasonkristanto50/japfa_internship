import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/app_theme.dart';
import 'package:japfa_internship/home_page.dart';

void main() {
  runApp(const ProviderScope(child: Root()));
}

/// Acts as a thin wrapper so we can initialise ScreenUtil *before* MaterialApp
class Root extends StatelessWidget {
  const Root({super.key});

  // Full-HD desktop baseline ───────────────┐
  static const _desktopDesign = Size(1920, 1080);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _desktopDesign, // <── baseline for all .h / .w / .sp / .r
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Japfa Internship',
      theme: AppTheme.theme,
      home: const MyHomePage(),
    );
  }
}
