import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/file_uploading.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/views/home_page.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/models/skill_peserta_magang_data/skill_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';

class SubmissionInternFile extends StatefulWidget {
  final String departmentName;
  final String name;
  final String address;
  final String phoneNumber;
  final String email;
  final String university;
  final String akreditasiUniversitas;
  final int generation;
  final double score;
  final String major;

  // Added fields for Likert values and optional project details
  final double likertKomunikasi;
  final double likertKreativitas;
  final double likertTanggungJawab;
  final double likertKerjaSama;
  final double likertTeknis;

  final List<String> listProjectName;
  final String? urlProject;

  const SubmissionInternFile({
    super.key,
    required this.departmentName,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.university,
    required this.akreditasiUniversitas,
    required this.generation,
    required this.score,
    required this.major,
    required this.likertKomunikasi,
    required this.likertKreativitas,
    required this.likertTanggungJawab,
    required this.likertKerjaSama,
    required this.likertTeknis,
    required this.listProjectName,
    this.urlProject,
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

  String labelCV = 'CV';
  String labelPersetujuanUniv = 'Persetujuan Univ';
  String labelTranskripNilai = 'Transkrip Nilai';
  String labelFotoDiri = 'Foto Diri (3x6)';

  final _visible = true;

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
          child: isLoading
              ? const CircularProgressIndicator()
              : AnimatedOpacity(
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
                          _buildTitle(),
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

  Widget _buildTitle() {
    bool isMobile = isScreenMobile(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Kirim Dokumen',
              style: TextStyle(
                fontSize: isMobile ? 16 : 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
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
          () => FileUploading().removeFile(setState, labelPersetujuanUniv,
              (field, _, __) {
            deleteFileData(field);
          }),
          () => {},
        ),
        const SizedBox(height: 15),
        FileUploading().buildFileField(
          labelCV,
          cvFileName,
          () => FileUploading()
              .pickFile(setState, labelCV, false, updateFileData),
          () => FileUploading().removeFile(setState, labelCV, (field, _, __) {
            deleteFileData(field);
          }),
          () => {},
        ),
        const SizedBox(height: 15),
        FileUploading().buildFileField(
          labelTranskripNilai,
          transcriptFileName,
          () => FileUploading()
              .pickFile(setState, labelTranskripNilai, false, updateFileData),
          () => FileUploading().removeFile(setState, labelTranskripNilai,
              (field, _, __) {
            deleteFileData(field);
          }),
          () => {},
        ),
        const SizedBox(height: 15),
        FileUploading().buildFileField(
          labelFotoDiri,
          fotoDiriFileName,
          () => FileUploading()
              .pickFile(setState, labelFotoDiri, true, updateFileData),
          () => FileUploading().removeFile(setState, labelFotoDiri,
              (field, _, __) {
            deleteFileData(field);
          }),
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
            }
          },
        ),
      ],
    );
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

  // Function to update file data based on the field
  void deleteFileData(String field) {
    if (field == labelCV) {
      cvFileName = null;
      cvFile = null;
    } else if (field == labelPersetujuanUniv) {
      campusApprovalFileName = null;
      campusApprovalFile = null;
    } else if (field == labelTranskripNilai) {
      transcriptFileName = null;
      transcriptFile = null;
    } else if (field == labelFotoDiri) {
      fotoDiriFileName = null;
      fotoDiriFile = null;
    }
  }

  // Method to submit skill data
  void _submitSkillData() async {
    try {
      setState(() {
        isLoading = true;
      });
      // Get the count to generate unique ID
      int skillCount = await ApiService().skillService.countSkills();
      String idSkillValue =
          'SKILL_MG_${(skillCount + 1).toString().padLeft(3, '0')}';

      // Count non-null projects
      List<String> projectList = widget.listProjectName;
      int projectCount = projectList.length;

      int totalSoftskillValue = calculateTotalSoftskills();

      // Access the overall score
      final fuzzyResponse =
          await ApiService().skillService.calculateFuzzyScores(
                totalSoftskill: totalSoftskillValue,
                banyakProyek: projectCount,
                nilaiUniv: widget.score,
                akreditasiUniversitas: widget.akreditasiUniversitas,
                jurusan: widget.major,
              );
      final double overallFuzzyScore = fuzzyResponse['overallScore'];

      // Create the SkillPesertaMagangData object
      SkillPesertaMagangData skillData = SkillPesertaMagangData(
        idSkill: idSkillValue,
        namaPeserta: widget.name,
        departemen: widget.departmentName,
        email: widget.email,
        asalUniversitas: widget.university,
        akreditasiUniversitas: widget.akreditasiUniversitas,
        nilaiUniv: widget.score,
        jurusan: widget.major,
        komunikasi: widget.likertKomunikasi.toString(),
        kreativitas: widget.likertKreativitas.toString(),
        tanggungJawab: widget.likertTanggungJawab.toString(),
        kerjaSama: widget.likertKerjaSama.toString(),
        skillTeknis: widget.likertTeknis.toString(),
        totalSoftskill: totalSoftskillValue,
        banyakProyek: projectCount,
        listProyek: projectList,
        urlLampiran: widget.urlProject ?? '',
        fuzzyScore: overallFuzzyScore,
      );

      // Call the SkillService to add the skill
      await ApiService().skillService.addSkill(skillData);

      print('Skill data submitted successfully');
    } catch (error) {
      print('Error submitting skill data: $error');
      showSnackBar(context, 'Error submitting skill data');
    } finally {
      isLoading = false;
    }
  }

  void _submitFormPesertaMagang() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    if (cvFileName != null &&
        campusApprovalFileName != null &&
        transcriptFileName != null) {
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
        int count =
            await ApiService().pesertaMagangService.countPesertaMagang();

        // Construct the idMagang
        String idMagang = 'PDFT_MG_0$count';

        // Generate password token
        String passwordTokenValue = generateRandomPassword(7);

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
        await ApiService()
            .pesertaMagangService
            .submitPesertaMagang(pesertaMagang);

        // Add skill & project to database skill_peserta_magang
        _submitSkillData();

        // Send Email containing passwordToken to user
        await ApiService().sendEmail(
          widget.email,
          widget.name,
          passwordTokenValue,
          EmailMessageType.daftarMagang,
        );

        ApiService().addLog(
          logUser: widget.name,
          logTable: TableName.pesertaMagang.value,
          logKey: 'idMagang',
          logKeyValue: idMagang,
          logType: LogDataType.insert.value,
          logDetail: 'Menambah peserta magang',
        );

        fadeNavigation(context, targetNavigation: const MyHomePage());
        showConfirmationDialog(
          context,
          title: confirmationTitleValue,
          message: confirmationMessageValue,
        );

        // Show success message
        showSnackBar(
          context,
          'Pengajuan Magang berhasil',
          backgroundColor: Colors.green,
        );
      } catch (error) {
        showSnackBar(context, 'Error dalam mengajukan magang');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      showSnackBar(context, 'All files must be uploaded');
      setState(() {
        isLoading = false;
      });
    }
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

    // Additional check for fotoDiri file extension
    if (field == labelFotoDiri) {
      final allowedExtensions = ['jpg', 'jpeg', 'png'];
      final extension = fileName.split('.').last.toLowerCase();

      if (!allowedExtensions.contains(extension)) {
        showSnackBar(context, 'File $field harus berupa JPG, JPEG, atau PNG');
        return false;
      }
    }

    return true;
  }

  // Method to calculate total soft skills
  int calculateTotalSoftskills() {
    int komunikasiValue = widget.likertKomunikasi.round();
    int kreativitasValue = widget.likertKreativitas.round();
    int tanggungJawabValue = widget.likertTanggungJawab.round();
    int kerjaSamaValue = widget.likertKerjaSama.round();
    int skillTeknisValue = widget.likertTeknis.round();

    int totalSoftskill = komunikasiValue +
        kreativitasValue +
        tanggungJawabValue +
        kerjaSamaValue +
        skillTeknisValue;
    return totalSoftskill;
  }
}
