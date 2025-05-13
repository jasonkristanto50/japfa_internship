import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/file_uploading.dart';
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
  String? cvFileName;
  String? campusApprovalFileName;
  String? transcriptFileName;
  String? fotoDiriFileName;

  String? cvFilePath;
  String? campusApprovalFilePath;
  String? transcriptFilePath;
  String? fotoDiriFilePath;

  Uint8List? cvFile;
  Uint8List? campusApprovalFile;
  Uint8List? transcriptFile;
  Uint8List? fotoDiriFile;

  List<String> tipeDataFileUpload = [
    'pdf',
    'doc',
    'docx',
    'jpg',
    'png',
    'jpeg'
  ];
  List<String> tipeDataFotoUpload = ['jpg', 'png', 'jpeg'];

  final _visible = true;
  String labelCV = 'CV';
  String labelPersetujuanUniv = 'Persetujuan Univ';
  String labelTranskripNilai = 'Transkrip Nilai';
  String labelFotoDiri = 'Foto Diri';

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
    if (cvFileName != null &&
        campusApprovalFileName != null &&
        transcriptFileName != null) {
      try {
        // Set the file path
        cvFilePath = await ApiService().uploadFileToServer(
          cvFile!,
          cvFileName!,
        );
        campusApprovalFilePath = await ApiService().uploadFileToServer(
          campusApprovalFile!,
          campusApprovalFileName!,
        );
        transcriptFilePath = await ApiService().uploadFileToServer(
          transcriptFile!,
          transcriptFileName!,
        );
        fotoDiriFilePath = await ApiService().uploadFileToServer(
          fotoDiriFile!,
          fotoDiriFileName!,
        );
        // Fetch the count of peserta magang
        int count = await ApiService().countPesertaMagang();

        // Construct the idMagang
        String idMagang = 'PDFT_MG_0$count';

        // Generate password token
        String passwordTokenValue = generateRandomPassword(10);

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
          passwordToken: passwordTokenValue,
          nilaiAkhirMagang: null,
        );

        // Submit the form
        await ApiService().submitPesertaMagang(pesertaMagang);

        // Send Email contain passwordToken to user
        await ApiService().sendEmail(
          widget.email,
          widget.name,
          passwordTokenValue,
        );

        print("Email 2 : ${widget.email}");
        print("Nama2: ${widget.name}");
      } catch (error) {
        print("Submission: $error");
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
        FileUploading().buildFileField(
          labelPersetujuanUniv,
          campusApprovalFileName,
          () => FileUploading()
              .pickFile(setState, labelPersetujuanUniv, false, updateFileData),
          () => FileUploading()
              .removeFile(setState, labelPersetujuanUniv, updateFileData),
          () => {},
        ),
        const SizedBox(height: 15),
        FileUploading().buildFileField(
          labelCV,
          cvFileName,
          () => FileUploading()
              .pickFile(setState, labelCV, false, updateFileData),
          () => FileUploading().removeFile(setState, labelCV, updateFileData),
          () => {},
        ),
        const SizedBox(height: 15),
        FileUploading().buildFileField(
          labelTranskripNilai,
          transcriptFileName,
          () => FileUploading()
              .pickFile(setState, labelTranskripNilai, false, updateFileData),
          () => FileUploading()
              .removeFile(setState, labelTranskripNilai, updateFileData),
          () => {},
        ),
        const SizedBox(height: 15),
        FileUploading().buildFileField(
          labelFotoDiri,
          fotoDiriFileName,
          () => FileUploading()
              .pickFile(setState, labelFotoDiri, true, updateFileData),
          () => FileUploading()
              .removeFile(setState, labelFotoDiri, updateFileData),
          () => {},
        ),
        const SizedBox(height: 20),
        RoundedRectangleButton(
          title: "Kirim",
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

  // VALIDATE FIELD
  bool validateFileFields(BuildContext context) {
    // Check if the files are uploaded
    if (!validateFileUpload(labelCV)) {
      return false;
    }

    if (!validateFileUpload(labelPersetujuanUniv)) {
      return false;
    }

    if (!validateFileUpload(labelTranskripNilai)) {
      return false;
    }
    if (!validateFileUpload(labelFotoDiri)) {
      return false;
    }

    return true;
  }

  // Validate file upload (check if files are selected)
  bool validateFileUpload(String field) {
    String? fileName;
    if (field == labelCV) {
      fileName = cvFileName;
    } else if (field == labelPersetujuanUniv) {
      fileName = campusApprovalFileName;
    } else if (field == labelTranskripNilai) {
      fileName = transcriptFileName;
    } else if (field == labelFotoDiri) {
      fileName = fotoDiriFileName;
    }

    if (fileName == null) {
      showSnackBar(context, '$field harus diupload');
      return false;
    }

    return true;
  }

// Function to update file data based on the field
  void updateFileData(String field, String? fileName, Uint8List fileBytes) {
    if (field == labelCV) {
      cvFileName = fileName;
      cvFile = fileBytes;
    } else if (field == labelPersetujuanUniv) {
      campusApprovalFileName = fileName;
      campusApprovalFile = fileBytes;
    } else if (field == labelTranskripNilai) {
      transcriptFileName = fileName;
      transcriptFile = fileBytes;
    } else if (field == labelFotoDiri) {
      fotoDiriFileName = fileName;
      fotoDiriFile = fileBytes;
    }
  }
}
