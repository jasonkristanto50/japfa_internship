import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/function_variable/variable.dart';
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

  const MyApp({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Japfa Internship',
      theme: ThemeData(
        primaryColor: japfaOrange,
        scaffoldBackgroundColor: Colors.white, // Light background
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: japfaOrange,
          selectionHandleColor: japfaOrange,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: japfaOrange),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: japfaOrange),
          ),
          labelStyle: TextStyle(color: darkGrey),
        ),

        // ============================ DATE PICKER THEME ============================
        datePickerTheme: DatePickerThemeData(
          dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return japfaOrange; // Selected day background
            }
            return null;
          }),
          dayStyle: const TextStyle(
              fontSize: 16, color: Colors.black), // Day text style
          dayShape: WidgetStateProperty.resolveWith<OutlinedBorder?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return const CircleBorder(
                  side: BorderSide(
                    color: Colors.white, // Border for selected days
                  ),
                );
              }
              return const CircleBorder(); // No border for non-selected days
            },
          ),
          todayForegroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return japfaOrange;
          }),
          todayBackgroundColor: WidgetStateProperty.resolveWith<Color?>(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return japfaOrange;
            }
            return Colors.white;
          }),
          todayBorder: BorderSide(color: japfaOrange),

          backgroundColor: Colors.white,
          headerForegroundColor: darkGrey,
          headerBackgroundColor: japfaOrange,
          weekdayStyle: TextStyle(color: japfaOrange),
          yearBackgroundColor: const WidgetStatePropertyAll(Colors.white),
          yearForegroundColor: const WidgetStatePropertyAll(Colors.grey),

          // Style for Cancel button
          cancelButtonStyle: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(70.sp, 30.sp)),
            foregroundColor: WidgetStatePropertyAll(japfaOrange),
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            side: WidgetStatePropertyAll(
              BorderSide(color: japfaOrange),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          // Style for OK button
          confirmButtonStyle: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(70.sp, 30.sp)),
            foregroundColor: const WidgetStatePropertyAll(Colors.white),
            backgroundColor: WidgetStatePropertyAll(japfaOrange),
            side: WidgetStatePropertyAll(
              BorderSide(color: japfaOrange),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
