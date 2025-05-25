import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:url_launcher/url_launcher.dart';

void fadeNavigation(
  BuildContext context, {
  required Widget targetNavigation,
  int? time,
}) {
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

Widget buildTextField(
  String label,
  TextEditingController controller, {
  bool isPassword = false,
}) {
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
    bool peringatan = false,
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
              border: Border.all(
                color: peringatan == false ? japfaOrange : Colors.red,
              ),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Text(
              value,
              style: peringatan == false
                  ? regular16
                  : regular16.copyWith(
                      color: Colors.red,
                    ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildLikertScale(
  String text,
  double likertValue,
  ValueChanged<double> onChanged,
) {
  return Column(
    children: [
      Text(text, style: regular20),
      Slider(
        activeColor: japfaOrange,
        value: likertValue,
        min: 1.0,
        max: 5.0,
        divisions: 4,
        label: likertValue.round().toString(),
        onChanged: onChanged,
      ),
    ],
  );
}

Future<String?> showCustomConfirmRejectDialogWithNote({
  required BuildContext context,
  required String title,
  required String message,
  required bool withNote,
  String? acceptText,
  String? rejectText,
  required VoidCallback onAccept,
  required Function(String? note) onReject,
}) {
  final TextEditingController noteController = TextEditingController();

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5.0,
        child: Container(
          width: 350,
          height: 350,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(title, style: bold24.copyWith(color: japfaOrange)),
              const SizedBox(height: 16),
              // Message
              Text(
                message,
                textAlign: TextAlign.center,
                style: regular20,
              ),
              const SizedBox(height: 16),
              // TextField for notes
              withNote
                  ? TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tulis Catatan...',
                      ),
                      maxLines: 6,
                    )
                  : const SizedBox(),
              const Spacer(),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Reject Button
                  ElevatedButton(
                    onPressed: () {
                      final note = noteController.text.toString();
                      Navigator.of(context).pop(note); // Close the dialog
                      onReject(note);
                      noteController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(rejectText ?? "Ditolak"),
                  ),
                  const SizedBox(width: 16),
                  // Accept Button
                  ElevatedButton(
                    onPressed: () {
                      onAccept();
                      noteController.clear();
                      Navigator.of(context).pop(); // Tidak mengirim note
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(acceptText ?? 'Diterima'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<String?> showCustomConfirmAcceptDialogWithNote({
  required BuildContext context,
  required String title,
  required String message,
  required bool withNote,
  String? acceptText,
  String? rejectText,
  required Function(String? note) onAccept,
  required VoidCallback onReject,
}) {
  final TextEditingController noteController = TextEditingController();

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5.0,
        child: Container(
          width: 350,
          height: 350,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(title, style: bold24.copyWith(color: japfaOrange)),
              const SizedBox(height: 16),
              // Message
              Text(
                message,
                textAlign: TextAlign.center,
                style: regular20,
              ),
              const SizedBox(height: 16),
              // TextField for notes
              withNote
                  ? TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Tulis Catatan...',
                      ),
                      maxLines: 6,
                    )
                  : const SizedBox(),
              const Spacer(),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Reject Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onReject();
                      noteController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(rejectText ?? "Ditolak"),
                  ),
                  const SizedBox(width: 16),
                  // Accept Button
                  ElevatedButton(
                    onPressed: () {
                      final note = noteController.text.toString();
                      Navigator.of(context).pop(note);
                      onAccept(note);
                      noteController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(acceptText ?? 'Diterima'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
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

String generateRandomPassword(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final Random random = Random();
  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

// Show Confirmation Dialog
Future<void> showConfirmationDialog(BuildContext context,
    {required String title, required String message}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ConfirmationDialog(
        title: title,
        message: message,
      );
    },
  );
}
