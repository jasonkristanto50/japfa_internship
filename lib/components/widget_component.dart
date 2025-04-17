import 'package:flutter/material.dart';
import 'package:japfa_internship/function_variable/variable.dart';

BoxDecoration buildJapfaLogoBackground() {
  return BoxDecoration(
    color: Colors.white, // Fallback background color
    image: DecorationImage(
      image: AssetImage(japfaLogoBackgroundImgPath),
      fit: BoxFit.cover,
    ),
  );
}

class RoundedRectangleButton extends StatelessWidget {
  final String title;
  final Color fontColor;
  final Color backgroundColor;
  final Color outlineColor;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? rounded;
  final TextStyle? style;

  const RoundedRectangleButton({
    required this.title,
    this.fontColor = Colors.black,
    required this.backgroundColor,
    this.outlineColor = Colors.transparent, // Default to transparent
    required this.onPressed,
    this.width,
    this.height,
    this.rounded = 10,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: fontColor,
          backgroundColor: backgroundColor,
          // Ensure no outline if the color is intended as transparent
          side: BorderSide(
              color: outlineColor.withOpacity(outlineColor.alpha == 0 ? 0 : 1),
              width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded ?? 10),
          ),
        ),
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

// CustomDialog Widget
class CustomDialog extends StatelessWidget {
  final VoidCallback onLoginPressed;

  const CustomDialog({required this.onLoginPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Please Login",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          const Text("You need to login to apply."),
          const SizedBox(height: 24.0),
          RoundedRectangleButton(
            title: "LOGIN",
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              onLoginPressed(); // Trigger the login navigation
            },
          ),
        ],
      ),
    );
  }
}
