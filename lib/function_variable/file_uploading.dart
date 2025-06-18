import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FileUploading {
  // Build a file upload field with delete functionality
  Widget buildFileField(
    String label,
    String? fileName,
    Function pickFile,
    Function removeFile,
    Function openFilePreview, {
    bool isMobile = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          width: isMobile ? 250 : double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: fileName == null
              ? InkWell(
                  onTap: () => pickFile(),
                  child: const Center(
                      child: Text('Klik disini untuk upload file')),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 10),
                        const Icon(Icons.picture_as_pdf, size: 20), // PDF icon
                        const SizedBox(width: 5),
                        SizedBox(
                          width: isMobile ? 100 : 200,
                          child: Text(
                            getFileNameWithEllipsis(fileName, isMobile),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.remove_circle_outline,
                        color: Colors.red,
                      ),
                      onPressed: () => removeFile(),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  // Function to truncate the middle part of the file name
  String getFileNameWithEllipsis(String fileName, bool isMobile) {
    if (isMobile) {
      if (fileName.length > 12) {
        String start = fileName.substring(0, 3);
        String end = fileName.substring(fileName.length - 3);
        return '$start...$end';
      }
    } else {
      if (fileName.length > 20) {
        String start = fileName.substring(0, 10);
        String end = fileName.substring(fileName.length - 10);
        return '$start....$end';
      }
    }
    return fileName;
  }

  // Method to pick a file using file_picker
  Future<void> pickFile(
    Function setState,
    String field,
    bool isFoto,
    Function updateFileData,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions:
          isFoto ? ['jpg', 'png', 'jpeg'] : ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      String fileName = result.files.single.name;

      // Check if the platform is web
      if (kIsWeb) {
        Uint8List? fileBytes = result.files.single.bytes;
        if (fileBytes != null) {
          setState(() {
            updateFileData(field, fileName, fileBytes);
          });
        }
      } else {
        // For mobile, read the file and get bytes
        String? filePath = result.files.single.path;
        if (filePath != null) {
          // Read the file bytes
          File file = File(filePath);
          Uint8List fileBytes = await file.readAsBytes();
          setState(() {
            updateFileData(field, fileName, fileBytes); // Update with bytes
          });
        } else {
          print("File path is null, please try again.");
        }
      }
    } else {
      print("No file selected. Please try again.");
    }
  }

  // Function to remove a file
  void removeFile(Function setState, String field, Function updateFileData) {
    setState(() {
      updateFileData(field, null, null);
    });
  }
}
