import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:url_launcher/url_launcher.dart';

void fadeNavigation(BuildContext context,
    {required Widget targetNavigation, int? time}) {
  final fadeDuration = time != null
      ? Duration(milliseconds: time)
      : const Duration(milliseconds: 500);

  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => targetNavigation,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: fadeDuration,
    ),
  );
}

Widget buildTextField(String label, TextEditingController controller,
    {bool isPassword = false}) {
  return TextField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
    cursorColor: const Color.fromARGB(255, 48, 48, 48),
  );
}

Widget buildFileButton(String title, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:', style: bold14),
        const SizedBox(height: 5), // Space between label and button
        RoundedRectangleButton(
          title: "Tampilkan",
          style: regular14,
          fontColor: Colors.white,
          backgroundColor: japfaOrange,
          width: 150,
          height: 35,
          rounded: 5,
          onPressed: onPressed,
        ),
      ],
    ),
  );
}

Widget buildDataInfoField(
    {required String label,
    required String value,
    double verticalPadding = 10}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: bold16,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: japfaOrange),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Text(value, style: regular16),
          ),
        ),
      ],
    ),
  );
}

enum FieldType {
  name,
  school,
  email,
  phone,
  jumlahAnakKunjungan,
  angkatan,
  score,
  jurusan,
  password,
  confirmPassword,
  elseMustFill
}

// Global validation function
bool validateField({
  required TextEditingController controller,
  required String fieldName,
  required FieldType fieldType,
  BuildContext? context,
}) {
  // Validate based on field type (name, email, phone, etc.)
  switch (fieldType) {
    case FieldType.name:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      // Name must alphabet
      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(controller.text)) {
        showSnackBar(context, '$fieldName hanya boleh mengandung huruf');
        return false;
      }
      break;

    case FieldType.school:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      break;

    case FieldType.email:
      if (controller.text.isEmpty ||
          !controller.text.contains('@') ||
          !controller.text.endsWith('.com')) {
        showSnackBar(context, 'Tolong isi $fieldName dengan benar');
        return false;
      }
      break;

    case FieldType.phone:
      if (controller.text.isEmpty ||
          !RegExp(r'^\d+$').hasMatch(controller.text)) {
        showSnackBar(context, '$fieldName harus diisi dan harus angka');
        return false;
      }
      break;

    case FieldType.jumlahAnakKunjungan:
      if (controller.text.isEmpty ||
          !RegExp(r'^\d+$').hasMatch(controller.text)) {
        showSnackBar(context, '$fieldName harus diisi dan harus angka');
        return false;
      }
      // Jumlah maksimal anak = 55
      int value = int.parse(controller.text);
      if (value > jumlahMaksimalPeserta) {
        showSnackBar(context,
            '$fieldName tidak boleh lebih dari $jumlahMaksimalPeserta');
        return false;
      }

    case FieldType.angkatan:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      // Optionally, validate angkatan if needed
      // For example: validate it as a number and within a specific range
      if (!RegExp(r'^\d+$').hasMatch(controller.text)) {
        showSnackBar(context, '$fieldName harus berupa angka');
        return false;
      }
      break;

    case FieldType.score:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      // Validate that the score is a number between 0 and 100
      double score = double.parse(controller.text);
      if (score < 0 || score > 100) {
        showSnackBar(context, '$fieldName harus diantara 0 dan 100');
        return false;
      }
      break;

    case FieldType.jurusan:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      break;

    case FieldType.password:
      if (controller.text.isEmpty || controller.text.length < 8) {
        showSnackBar(context, '$fieldName harus diisi dan minimal 8 digit');
        return false;
      }
      break;

    case FieldType.confirmPassword:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      break;
    case FieldType.elseMustFill:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      break;
  }

  return true; // If all validation checks passed
}

// Global file validation function
Future<File?> validateFileUpload(BuildContext context) async {
  // Pick a file
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result == null) {
    // User canceled the picker
    showSnackBar(context, 'No file selected');
    return null;
  }

  // Get the file path
  File file = File(result.files.single.path!);

  // Check file size (example: max 10MB)
  int fileSizeInMB = file.lengthSync() ~/ (1024 * 1024);
  if (fileSizeInMB > 10) {
    showSnackBar(context, 'File size cannot be more than 10MB');
    return null;
  }

  // Check file type (example: only images and PDFs are allowed)
  String fileExtension = result.files.single.extension!;
  if (fileExtension != 'jpg' &&
      fileExtension != 'jpeg' &&
      fileExtension != 'png' &&
      fileExtension != 'pdf') {
    showSnackBar(
        context, 'Invalid file type. Only JPG, JPEG, PNG, and PDF are allowed');
    return null;
  }

  // Return the valid file
  return file;
}

// Helper function to show snack bar
void showSnackBar(BuildContext? context, String message) {
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}

// Launch Image URL
void launchURLImagePath(String path) async {
  final String fullPath = '$baseUrl$path';
  final Uri finalPath = Uri.parse(fullPath);
  if (await canLaunchUrl(finalPath)) {
    await launchUrl(finalPath);
  } else {
    throw 'Could not launch $path';
  }
}
