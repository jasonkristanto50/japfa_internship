import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:japfa_internship/function_variable/variable.dart';

// Build the Japfa Logo Background
BoxDecoration buildJapfaLogoBackground() {
  return BoxDecoration(
    color: Colors.white, // Fallback background color
    image: DecorationImage(
      image: AssetImage(japfaLogoBackgroundImgPath),
      fit: BoxFit.cover,
    ),
  );
}

// Rounded Rectangle Button
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

// Custom Dialog Widget for Login
class CustomLoginDialog extends StatelessWidget {
  final VoidCallback onLoginPressed;

  const CustomLoginDialog({required this.onLoginPressed, super.key});

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

// Custom Dialog for Respond
class CustomRespondDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const CustomRespondDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5.0,
      child: Container(
        width: 350,
        height: 200,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: japfaOrange,
              ),
            ),
            const SizedBox(height: 16),
            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: regular16,
            ),
            const Spacer(),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reject Button
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Ditolak'),
                ),
                const SizedBox(width: 16),
                // Accept Button
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Diterima'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- CustomSearchBar ----------------
class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final String? labelSearchBar;
  final double? widthValue;
  final bool withSearchButton;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.labelSearchBar,
    this.widthValue,
    this.withSearchButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: widthValue,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // If widthValue is given → use it, otherwise expand
                widthValue != null
                    ? SizedBox(
                        width: widthValue,
                        child: _buildTextField(),
                      )
                    : Expanded(child: _buildTextField()),
                if (withSearchButton) ...[
                  const SizedBox(width: 8), // small gap
                  RoundedRectangleButton(
                    title: 'Search',
                    fontColor: Colors.white,
                    backgroundColor: Colors.orange,
                    height: 45,
                    width: 100,
                    rounded: 5,
                    onPressed: () {},
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() => TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelSearchBar ?? 'Ketikkan pencarian',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
      );
}
