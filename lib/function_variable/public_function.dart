import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
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
  bool withDeleteIcon = false,
  VoidCallback? onDelete,
  bool mandatory = false,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      label: RichText(
        text: TextSpan(
          text: label,
          style: regular20.copyWith(color: Colors.black87),
          children: <TextSpan>[
            if (mandatory)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
      border: const OutlineInputBorder(),
      suffixIcon: withDeleteIcon
          ? IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: onDelete,
            )
          : null,
    ),
    cursorColor: const Color.fromARGB(255, 48, 48, 48),
  );
}

Widget buildDateField(
  String label,
  TextEditingController controller,
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      readOnly: true,
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

Widget buildFileButton(
  String title,
  VoidCallback onPressed, {
  Color? backgroundColor,
  String? buttonText,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title:', style: bold14),
        const SizedBox(height: 5), // Space between label and button
        RoundedRectangleButton(
          title: buttonText ?? "Tampilkan",
          style: regular14,
          fontColor: Colors.white,
          backgroundColor: backgroundColor ?? japfaOrange,
          width: 150,
          height: 35,
          rounded: 5,
          onPressed: onPressed,
        ),
      ],
    ),
  );
}

Widget buildDataInfoField({
  required String label,
  required String value,
  double heightValue = 40,
  bool peringatan = false,
  double verticalPadding = 10,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: verticalPadding),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: bold18,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Container(
            height: heightValue,
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
  String title,
  double likertValue,
  ValueChanged<double> onChanged,
) {
  // Mapping of Likert values to corresponding labels
  String getLabel(double value) {
    switch (value.toInt()) {
      case 1:
        return "Sangat kurang";
      case 2:
        return "Kurang";
      case 3:
        return "Cukup";
      case 4:
        return "Bagus";
      case 5:
        return "Sangat bagus";
      default:
        return "";
    }
  }

  return Column(
    children: [
      Text(title, style: regular20),
      Row(
        children: [
          Text(
            "Sangat kurang",
            style: regular16.copyWith(color: Colors.grey),
          ),
          const Spacer(),
          Text(
            "Sangat bagus",
            style: regular16.copyWith(color: Colors.grey),
          ),
        ],
      ),
      Slider(
        activeColor: japfaOrange,
        value: likertValue,
        min: 1.0,
        max: 5.0,
        divisions: 4,
        label: getLabel(likertValue), // Update the label based on value
        onChanged: onChanged,
      ),
    ],
  );
}

Widget buildDropDownField(
  String label,
  String? selectedValue,
  List<Map<String, String>> options,
  ValueChanged<String?> onChanged, {
  bool mandatory = false,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 48, 48, 48)),
      borderRadius: BorderRadius.circular(5),
    ),
    child: DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        label: RichText(
          text: TextSpan(
            text: label,
            style: regular20.copyWith(color: Colors.black87),
            children: <TextSpan>[
              if (mandatory)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: InputBorder.none,
      ),
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option['value'],
          child: Text(option['name']!),
        );
      }).toList(),
      onChanged: onChanged,
      dropdownColor: Colors.white,
      isDense: true,
      itemHeight: 50,
      // Create a custom dropdown with scrolling capability
      selectedItemBuilder: (BuildContext context) {
        return options.map((option) {
          return Container(
            alignment: Alignment.centerLeft,
            child: Text(option['name']!),
          );
        }).toList();
      },
    ),
  );
}

Widget buildEmptyDataMessage({
  dynamic filteredData,
  String? dataName,
  String? message,
  EdgeInsets? padding,
}) {
  print("DATA : $filteredData");
  String dataTable = dataName ?? '';
  EdgeInsets paddingValue = padding ?? const EdgeInsets.only(bottom: 100.0);

  return Center(
    child: Padding(
      padding: paddingValue,
      child: Text(
        message ?? 'Masih belum ada data $dataTable',
        style: bold24.copyWith(color: Colors.black54),
      ),
    ),
  );
}

Future<String?> showCustomConfirmRejectDialogWithNote({
  required BuildContext context,
  required String title,
  required String message,
  required bool withNote,
  String? cancelText,
  String? rejectText,
  Color? cancelColor,
  Color? rejectColor,
  required VoidCallback onCancel,
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
          height: withNote ? 350 : 200,
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
                  // cancel Button
                  ElevatedButton(
                    onPressed: () {
                      onCancel();
                      noteController.clear();
                      Navigator.of(context).pop(); // Tidak mengirim note
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: cancelColor ?? Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(cancelText ?? 'Batal'),
                  ),
                  const SizedBox(width: 16),
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
                      backgroundColor: rejectColor ?? Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(rejectText ?? "Ditolak"),
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
  String? cancelText,
  Color? acceptColor,
  Color? cancelColor,
  required Function(String? note) onAccept,
  required VoidCallback onCancel,
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
          width: withNote ? 350 : 300,
          height: withNote ? 350 : 170,
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
                  // Cancel Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCancel();
                      noteController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: cancelColor ?? Colors.grey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(cancelText ?? "Batal"),
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
                      backgroundColor: acceptColor ?? Colors.green,
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

// Enum for Field Types
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
  universityDropdown,
  jurusanDropdown,
  elseMustFill,
}

// Global validation function
bool validateField({
  required TextEditingController controller,
  required String fieldName,
  required FieldType fieldType,
  String? selectedValue, // Added parameter for selected dropdown value
  BuildContext? context,
}) {
  // Validate based on field type (name, email, phone, etc.)
  switch (fieldType) {
    case FieldType.name:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      // Name must be alphabet
      if (!RegExp(r'^[a-zA-Z\s]+').hasMatch(controller.text)) {
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
      if (controller.text.isEmpty) {
        showSnackBar(context, 'Tolong isi $fieldName.');
        return false;
      } else if (!controller.text.contains('@') ||
          (!controller.text.endsWith('.com') &&
              !controller.text.endsWith('.ac.id'))) {
        showSnackBar(context,
            'Format $fieldName tidak valid. Pastikan mengandung "@" dan diakhiri dengan ".com" atau ".ac.id".');
        return false;
      }
      break;

    case FieldType.phone:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName harus diisi.');
        return false;
      } else if (!RegExp(r'^\d{8,12}').hasMatch(controller.text)) {
        showSnackBar(
            context, '$fieldName harus berupa 8 hingga 12 digit angka.');
        return false;
      }
      break;

    case FieldType.jumlahAnakKunjungan:
      if (controller.text.isEmpty ||
          !RegExp(r'^\d+').hasMatch(controller.text)) {
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
      break;

    case FieldType.angkatan:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
      // Validate angkatan if needed
      if (!RegExp(r'^\d+').hasMatch(controller.text)) {
        showSnackBar(context, '$fieldName harus berupa angka');
        return false;
      }
      break;

    case FieldType.score:
      if (controller.text.isEmpty) {
        showSnackBar(context, '$fieldName tidak boleh kosong');
        return false;
      }
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

    case FieldType.universityDropdown:
      if (selectedValue == null || selectedValue.isEmpty) {
        showSnackBar(context, '$fieldName harus dipilih');
        return false;
      }
      break;

    case FieldType.jurusanDropdown:
      if (selectedValue == null || selectedValue.isEmpty) {
        showSnackBar(context, '$fieldName harus dipilih');
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
void showSnackBar(
  BuildContext? context,
  String message, {
  Color? backgroundColor = Colors.red,
}) {
  if (context != null) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
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

// Launch Image URL
void launchFullURLImagePath({required String fullPath}) async {
  final Uri finalPath = Uri.parse(fullPath);
  if (await canLaunchUrl(finalPath)) {
    await launchUrl(finalPath);
  } else {
    throw 'Could not launch $fullPath';
  }
}

String generateRandomPassword(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final Random random = Random();
  return List.generate(length, (index) => chars[random.nextInt(chars.length)])
      .join();
}

// Show Confirmation Dialog
Future<void> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
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

String likertStringValue(String likertValue) {
  switch (likertValue) {
    case '1':
      return "Sangat Kurang";
    case '2':
      return "Kurang";
    case '3':
      return "Cukup";
    case '4':
      return "Bagus";
    case '5':
      return "Sangat Bagus";
    default:
      return "Invalid value";
  }
}

String getValidationStatus(String? validasiPembimbing) {
  if (validasiPembimbing == 'true') {
    return 'Disetujui';
  } else if (validasiPembimbing == 'false') {
    return 'Ditolak';
  } else {
    return 'Menunggu';
  }
}

String getInfoJamDariSesi(String jamKegiatan) {
  if (jamKegiatan == 'sesi1') {
    return 'Sesi 1 ($durasiSesi1)';
  } else if (jamKegiatan == 'sesi2') {
    return 'Sesi 2 ($durasiSesi2)';
  }
  return 'Sesi Tidak Valid';
}

// Function to extract the original file name from PATH
String getOriginalFileNameFromPath(String? url) {
  if (url != null) {
    // Extract original file name with extension
    final parts = url.split('/');
    final fullFileName = parts.isNotEmpty ? parts.last : '';

    // Check for additional timestamps
    final nameParts = fullFileName.split('-');
    if (nameParts.isNotEmpty) {
      return nameParts[0]; // Return just the original file name
    }
  }
  return '';
}

IconData getFileIcon(String? url) {
  if (url != null) {
    if (url.endsWith('.pdf')) {
      return Icons.picture_as_pdf; // PDF icon
    } else if (url.endsWith('.doc') || url.endsWith('.docx')) {
      return Icons.description; // DOC icon
    }
  }
  return Icons.file_present; // Default file icon
}

// COLOR -----------------------
Color getValidationColor(String? validasiPembimbing) {
  if (validasiPembimbing == 'true') {
    return Colors.green;
  } else if (validasiPembimbing == 'false') {
    return Colors.red;
  } else {
    return Colors.black;
  }
}

// Method to get color based on status
Color getStatusMagangColor(String status) {
  if (status == statusMagangMenunggu) {
    return japfaOrange;
  } else if (status == statusMagangDitolak) {
    return Colors.red;
  } else if (status == statusMagangDiterima) {
    return Colors.green;
  } else if (status == statusMagangBerlangsung) {
    return Colors.blue;
  } else if (status == statusMagangSelesai) {
    return Colors.black;
  } else {
    return Colors.grey;
  }
}

Color getStatusKunjunganColor(String status) {
  if (status == statusKunjunganMenunggu) {
    return japfaOrange;
  } else if (status == statusKunjunganDitolak) {
    return Colors.red;
  } else if (status == statusKunjunganDiterima) {
    return Colors.green;
  } else if (status == statusKunjunganSelesai) {
    return Colors.blue;
  } else {
    return Colors.grey;
  }
}

Color getColorButtonRespondKunjungan(String statusKunjungan) {
  if (statusKunjungan == statusKunjunganMenunggu) {
    return lightBlue;
  } else if (statusKunjungan == statusKunjunganDiterima) {
    return lightBlue;
  } else {
    return Colors.grey;
  }
}

Color getStatusValidasiColor(String statusValidasi) {
  if (statusValidasi == statusValidasiDiterima) {
    return Colors.green;
  } else if (statusValidasi == statusValidasiDitolak) {
    return Colors.red;
  } else {
    return Colors.black;
  }
}
