import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:japfa_internship/function_variable/variable.dart'; // Make sure to import your variable definitions

class FileUploading {
  // Build a file upload field with delete functionality
  Widget buildFileField(
    String label,
    String? fileName,
    Function pickFile,
    Function removeFile,
    Function openFilePreview,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: fileName == null
              ? InkWell(
                  onTap: () => pickFile(),
                  child: const Center(child: Text('Click to upload file')),
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
                          width: 200,
                          child: Text(
                            getFileNameWithEllipsis(fileName),
                            style: regular16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => removeFile(),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  // Function to truncate the middle part of the file name
  String getFileNameWithEllipsis(String fileName) {
    if (fileName.length <= 20) {
      return fileName; // No truncation needed if the file name is short
    }
    String start = fileName.substring(0, 10);
    String end = fileName.substring(fileName.length - 10);
    return '$start....$end';
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

      // Check if the file is uploaded to web
      if (kIsWeb) {
        Uint8List? fileBytes = result.files.single.bytes;

        // Update using the byte data
        if (fileBytes != null) {
          setState(() {
            updateFileData(field, fileName, fileBytes);
          });
        }
      } else {
        // For mobile or desktop, update directly with file path
        setState(() {
          updateFileData(field, fileName, null); // Null for Uint8List
        });
      }
    } else {
      // Handle case where no file was selected
    }
  }

  // Function to remove a file
  void removeFile(Function setState, String field, Function updateFileData) {
    setState(() {
      updateFileData(field, null, null);
    });
  }
}
