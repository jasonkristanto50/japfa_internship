import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/app_theme.dart';
import 'package:japfa_internship/authentication/login.dart';
import 'package:japfa_internship/home_page.dart';

void main() {
  runApp(const ProviderScope(child: Root()));
}

/// Acts as a thin wrapper to initialize ScreenUtil *before* MaterialApp
class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    bool isMobile = screenSize.width < 600; // Determine if it's mobile

    // Set design size based on the device type
    final designSize = isMobile ? const Size(375, 812) : const Size(1920, 1080);

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) =>
          MyApp(isMobile: isMobile), // Pass device type to MyApp
    );
  }
}

class MyApp extends StatelessWidget {
  final bool isMobile;

  const MyApp(
      {super.key, required this.isMobile}); // Constructor to accept device type

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Japfa Internship',
      theme: AppTheme.theme,
      home: isMobile
          ? const LoginScreen()
          : const MyHomePage(), // Return appropriate home page
    );
  }
}
