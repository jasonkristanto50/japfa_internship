import 'package:flutter/material.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primarySwatch: Colors.orange, // Change this to your desired primary color
      // You can customize other theme properties as needed.
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black54),
      ),
      // Customize button theme, input decoration, etc., as required.
      buttonTheme: ButtonThemeData(
        buttonColor: japfaOrange, // Default button color
      ),
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: japfaOrange, width: 2.0), // Focused border color
        ),
        labelStyle: const TextStyle(color: Colors.black54),
      ),
    );
  }
}
