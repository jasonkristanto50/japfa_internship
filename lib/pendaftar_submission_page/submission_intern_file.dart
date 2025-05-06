// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/pendaftar_submission_page/submission_intern_text.dart';
import 'package:japfa_internship/pendaftar_submission_page/timeline_interview.dart';

class SubmissionInternFile extends StatefulWidget {
  final String departmentName;
  final String name;
  final String address;
  final String phoneNumber;
  final String email;
  final String university;
  final int generation;
  final double score;
  final String major;

  const SubmissionInternFile({
    super.key,
    required this.departmentName,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.university,
    required this.generation,
    required this.score,
    required this.major,
  });

  @override
  _SubmissionInternFileState createState() => _SubmissionInternFileState();
}

class _SubmissionInternFileState extends State<SubmissionInternFile> {
  // TODO : Semua File disini masih DUMMY dan HARUS DIUBAH
  String? cvFileName;
  String? campusApprovalFileName;
  String? transcriptFileName;
  String? fotoDiriFileName;

  String? cvFilePath = "assets/file_upload_peserta/cv_dummy_jason.jpg";
  String? campusApprovalFilePath =
      "assets/file_upload_peserta/persetujuan_univ_dummy_jason.pdf";
  String? transcriptFilePath =
      "assets/file_upload_peserta/transkrip_dummy_jason.pdf";
  String? fotoDiriFilePath = "assets/file_upload_peserta/dummy_foto_diri.png";

  Uint8List? cvFile;
  Uint8List? campusApprovalFile;
  Uint8List? transcriptFile;
  Uint8List? fotoDiriFile;

  final _visible = true;
  List<String> tipeDataFileUpload = [
    'pdf',
    'doc',
    'docx',
    'jpg',
    'png',
    'jpeg'
  ];
  List<String> tipeDataFotoUpload = ['jpg', 'png', 'jpeg'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Center(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: SingleChildScrollView(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            fadeNavigation(context,
                                targetNavigation: SubmissionIntern(
                                  departmentName: widget.departmentName,
                                ));
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 65),
                        const Text(
                          'Submission Page',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    _buildSubmissionFileForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to submit the form
  void _submitFormPesertaMagang() async {
    if (cvFilePath != null &&
        campusApprovalFilePath != null &&
        transcriptFilePath != null) {
      try {
        // Set the file path
        cvFilePath =
            await ApiService().uploadFileToServer(cvFile!, cvFileName!);
        campusApprovalFilePath = await ApiService()
            .uploadFileToServer(campusApprovalFile!, campusApprovalFileName!);
        transcriptFilePath = await ApiService()
            .uploadFileToServer(transcriptFile!, transcriptFileName!);
        fotoDiriFilePath = await ApiService()
            .uploadFileToServer(fotoDiriFile!, fotoDiriFileName!);
        // Fetch the count of peserta magang
        int count = await ApiService().countPesertaMagang();

        // Construct the idMagang
        String idMagang = 'PDFT_MG_0$count';

        // Create the PesertaMagangData object
        PesertaMagangData pesertaMagang = PesertaMagangData(
          idMagang: idMagang,
          nama: widget.name,
          departemen: widget.departmentName,
          alamat: widget.address,
          noTelp: widget.phoneNumber,
          email: widget.email,
          asalUniversitas: widget.university,
          angkatan: widget.generation,
          nilaiUniv: widget.score,
          jurusan: widget.major,
          pathCv: cvFilePath!,
          pathPersetujuanUniv: campusApprovalFilePath!,
          pathTranskripNilai: transcriptFilePath!,
          pathFotoDiri: fotoDiriFilePath!,
          statusMagang: 'On Process',
          nilaiAkhirMagang: null,
        );

        // Submit the form
        await ApiService().submitPesertaMagang(pesertaMagang);

        // Update jumlahPengajuan based on department name
      } catch (error) {
        print('Error occurred: $error');
        showSnackBar(context, 'An error occurred while submitting the form');
      }
    } else {
      showSnackBar(context, 'All files must be uploaded');
    }
  }

  // BUILD WIDGET
  Widget _buildSubmissionFileForm() {
    return Column(
      children: [
        const SizedBox(height: 15),
        buildFileField('CV', cvFileName, 'CV', false),
        const SizedBox(height: 15),
        buildFileField('Campus Approval', campusApprovalFileName,
            'Campus Approval', false),
        const SizedBox(height: 15),
        buildFileField(
            'Score Transcript', transcriptFileName, 'Score Transcript', false),
        const SizedBox(height: 15),
        buildFileField('Foto Diri', fotoDiriFileName, 'Foto Diri', false),
        const SizedBox(height: 20),
        RoundedRectangleButton(
          title: "Submit",
          backgroundColor: japfaOrange,
          fontColor: Colors.white,
          onPressed: () {
            if (validateFileFields(context)) {
              _submitFormPesertaMagang();
              fadeNavigation(context,
                  targetNavigation: const TimelineInterview());
            }
          },
        ),
      ],
    );
  }

  // Custom method to create file upload fields with delete functionality
  Widget buildFileField(
      String label, String? fileName, String field, bool isFoto) {
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
                  onTap: () => pickFile(field, isFoto),
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
                        // Text for file name with ellipsis if the name is too long
                        SizedBox(
                          width: 200,
                          child: Text(_getFileNameWithEllipsis(fileName),
                              style: regular16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.red),
                          onPressed: () => removeFile(field),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_red_eye,
                              color: Colors.blue),
                          onPressed: () => openFilePreview(getFilePath(field)),
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
  String _getFileNameWithEllipsis(String fileName) {
    if (fileName.length <= 20) {
      return fileName; // No truncation needed if the file name is short
    }
    // Get the first 12 characters, add ellipsis, and append the last 12 characters
    String start = fileName.substring(0, 10);
    String end = fileName.substring(fileName.length - 10);
    return '$start....$end';
  }

  // VALIDATE FIELD
  bool validateFileFields(BuildContext context) {
    // Check if the files are uploaded
    if (!validateFileUpload('CV')) {
      return false;
    }

    if (!validateFileUpload('Campus Approval')) {
      return false;
    }

    if (!validateFileUpload('Score Transcript')) {
      return false;
    }
    if (!validateFileUpload('Foto Diri')) {
      return false;
    }

    return true;
  }

  // Validate file upload (check if files are selected)
  bool validateFileUpload(String field) {
    String? fileName;
    if (field == 'CV') {
      fileName = cvFileName;
    } else if (field == 'Campus Approval') {
      fileName = campusApprovalFileName;
    } else if (field == 'Score Transcript') {
      fileName = transcriptFileName;
    } else if (field == 'Foto Diri') {
      fileName = fotoDiriFileName;
    }

    if (fileName == null) {
      showSnackBar(context, '$field harus diupload');
      return false;
    }

    return true;
  }

  /////////////////////////////////////////// FILE MANIPULATION /////////////////////////////////////////////////////////
  // Method to pick files using file_picker package with validation
  void pickFile(String field, bool isFoto) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: isFoto ? tipeDataFotoUpload : tipeDataFileUpload,
    );

    if (result != null) {
      String fileName = result.files.single.name;

      // Web-specific handling
      if (kIsWeb) {
        // Access bytes for web
        Uint8List? fileBytes = result.files.single.bytes;
        if (fileBytes != null) {
          // Handle the file bytes according to your needs
          // For example, you might upload it directly to the server
          setState(() {
            if (field == 'CV') {
              cvFileName = fileName;
              cvFile = fileBytes;
            } else if (field == 'Campus Approval') {
              campusApprovalFileName = fileName;
              campusApprovalFile = fileBytes;
            } else if (field == 'Score Transcript') {
              transcriptFileName = fileName;
              transcriptFile = fileBytes;
            } else if (field == 'Foto Diri') {
              fotoDiriFileName = fileName;
              fotoDiriFile = fileBytes;
            }
          });
        }
      } else {
        // Mobile/Desktop handling
        String? filePath = result.files.single.path;
        setState(() {
          if (field == 'CV') {
            cvFileName = fileName;
            cvFilePath = filePath;
          } else if (field == 'Campus Approval') {
            campusApprovalFileName = fileName;
            campusApprovalFilePath = filePath;
          } else if (field == 'Score Transcript') {
            transcriptFileName = fileName;
            transcriptFilePath = filePath;
          } else if (field == 'Foto Diri') {
            fotoDiriFileName = fileName;
            fotoDiriFilePath = filePath;
          }
        });
      }
    } else {
      // Handle the case where no file was selected
      showSnackBar(context, 'No file selected.');
    }
  }

  // Method to remove the uploaded file
  void removeFile(String field) {
    setState(() {
      if (field == 'CV') {
        cvFileName = null;
        cvFilePath = null;
      } else if (field == 'Campus Approval') {
        campusApprovalFileName = null;
        campusApprovalFilePath = null;
      } else if (field == 'Score Transcript') {
        transcriptFileName = null;
        transcriptFilePath = null;
      } else if (field == 'Foto Diri') {
        fotoDiriFileName = null;
        fotoDiriFilePath = null;
      }
    });
  }

  // Method to open PDF file for preview
  void openFilePreview(String? filePath) {
    if (filePath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFPreviewScreen(filePath: filePath),
        ),
      );
    }
  }

  // Get file path based on field
  String? getFilePath(String field) {
    if (field == 'CV') {
      return cvFilePath;
    } else if (field == 'Campus Approval') {
      return campusApprovalFilePath;
    } else if (field == 'Score Transcript') {
      return transcriptFilePath;
    }
    return null;
  }
}

// Screen for previewing the PDF
class PDFPreviewScreen extends StatelessWidget {
  final String filePath;
  const PDFPreviewScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview File"),
      ),
      body: PDFView(
        filePath: filePath,
      ),
    );
  }
}
