import 'package:flutter/material.dart';

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

enum FieldType {
  name,
  school,
  email,
  phone,
  jumlahAnakKunjungan,
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
        _showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      // Name must alphabet
      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(controller.text)) {
        _showSnackBar(context, '$fieldName hanya boleh mengandung huruf');
        return false;
      }
      break;

    case FieldType.school:
      if (controller.text.isEmpty) {
        _showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      break;

    case FieldType.email:
      if (controller.text.isEmpty ||
          !controller.text.contains('@') ||
          !controller.text.endsWith('.com')) {
        _showSnackBar(context, 'Tolong isi $fieldName dengan benar');
        return false;
      }
      break;

    case FieldType.phone:
      if (controller.text.isEmpty ||
          !RegExp(r'^\d+$').hasMatch(controller.text)) {
        _showSnackBar(context, '$fieldName harus diisi dan harus angka');
        return false;
      }
      break;

    case FieldType.jumlahAnakKunjungan:
      if (controller.text.isEmpty ||
          !RegExp(r'^\d+$').hasMatch(controller.text)) {
        _showSnackBar(context, '$fieldName harus diisi dan harus angka');
        return false;
      }
      // Jumlah maksimal anak = 50
      int value = int.parse(controller.text);
      if (value > 50) {
        _showSnackBar(context, '$fieldName tidak boleh lebih dari 50');
        return false;
      }

    case FieldType.password:
      if (controller.text.isEmpty || controller.text.length < 8) {
        _showSnackBar(context, '$fieldName harus diisi dan minimal 8 digit');
        return false;
      }
      break;

    case FieldType.confirmPassword:
      if (controller.text.isEmpty) {
        _showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      break;
    case FieldType.elseMustFill:
      if (controller.text.isEmpty) {
        _showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      break;
  }

  return true; // If all validation checks passed
}

// Helper function to show snack bar
void _showSnackBar(BuildContext? context, String message) {
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
