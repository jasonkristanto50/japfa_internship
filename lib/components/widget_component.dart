import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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

// Custom Dialog Widget for Login if user not login
class CustomLoginDialog extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback? onClearTap;

  const CustomLoginDialog(
      {required this.onLoginPressed, this.onClearTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClearTap == null) {
          onClearTap?.call();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: Colors.black.withOpacity(0.5), // Black transparent background
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent taps on the dialog from closing it
            child: AlertDialog(
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
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Dialog for Respond
class CustomRespondDialog extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const CustomRespondDialog({
    super.key,
    required this.title,
    this.message,
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
              message ?? "",
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

// CustomSearchBar
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

// Custom Confirmation Dialog
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white, // Set background to white
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400), // Set max width
        child: Column(
          mainAxisSize: MainAxisSize.min, // Dynamic height based on content
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: bold28.copyWith(color: japfaOrange),
                textAlign: TextAlign.center, // Center align title
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                message,
                style: regular20,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24), // Space before button
            Center(
              child: RoundedRectangleButton(
                title: "OK",
                backgroundColor: japfaOrange,
                height: 50.h,
                width: 300.w,
                rounded: 5,
                fontColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
            const SizedBox(height: 16), // Space at the bottom
          ],
        ),
      ),
    );
  }
}

// // Custom Alert Dialog
// class CustomAlertDialog extends StatelessWidget {
//   final String title;
//   final String subTitle;
//   final TextEditingController controller;
//   final String label;
//   final VoidCallback onSave;

//   const CustomAlertDialog({
//     super.key,
//     required this.title,
//     required this.subTitle,
//     required this.controller,
//     required this.label,
//     required this.onSave,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       title: Center(
//         child: Text(title, style: bold24),
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Text(
//                 subTitle.toUpperCase(),
//                 style: regular20.copyWith(color: japfaOrange),
//               ),
//             ),
//             const SizedBox(height: 16),
//             _buildTextField(controller, label),
//             const SizedBox(height: 16),
//             Center(
//                 child: RoundedRectangleButton(
//               title: "Simpan",
//               backgroundColor: japfaOrange,
//               fontColor: Colors.white,
//               onPressed: onSave,
//             )),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: regular14.copyWith(color: Colors.black),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: const BorderSide(color: Colors.orange, width: 2),
//           ),
//         ),
//         keyboardType: TextInputType.number,
//         style: const TextStyle(color: Colors.black),
//         cursorColor: Colors.black,
//       ),
//     );
//   }
// }

enum BuildFieldTypeController { text, number, date }

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<TextEditingController> controllers;
  final List<String> labels;
  final List<BuildFieldTypeController> fieldTypes;
  final VoidCallback onSave;
  final int numberOfField;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.subTitle,
    required this.controllers,
    required this.labels,
    required this.fieldTypes,
    required this.onSave,
    required this.numberOfField,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Center(
        child: Text(title, style: bold24),
      ),
      content: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: SingleChildScrollView(
          // Maintain only one scrollable wrapper
          child: Column(
            // Use a Column for building fields
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  subTitle.toUpperCase(),
                  style: regular20.copyWith(color: japfaOrange),
                ),
              ),
              const SizedBox(height: 16),
              // Create fields directly in the Column
              ...List.generate(numberOfField, (index) {
                return _buildField(
                  controllers[index],
                  labels[index],
                  fieldTypes[index],
                  context,
                );
              }),
              const SizedBox(height: 16),
              Center(
                child: RoundedRectangleButton(
                  title: "Simpan",
                  backgroundColor: japfaOrange,
                  fontColor: Colors.white,
                  onPressed: onSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      BuildFieldTypeController fieldType, BuildContext context) {
    switch (fieldType) {
      case BuildFieldTypeController.text:
        return _buildTextField(controller, label);
      case BuildFieldTypeController.number:
        return _buildNumberField(controller, label);
      case BuildFieldTypeController.date:
        return _buildDateField(controller, label, context);
    }
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );
  }

  Widget _buildNumberField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );
  }

  Widget _buildDateField(
      TextEditingController controller, String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true, // Ensures only date picker opens
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (picked != null) {
            controller.text = DateFormat('dd-MM-yyyy').format(picked);
          }
        },
      ),
    );
  }
}
