import 'package:flutter/material.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/pendaftar_submission_page/submission_intern_file.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';

class SubmissionIntern extends StatefulWidget {
  final String departmentName;

  const SubmissionIntern({super.key, required this.departmentName});

  @override
  _SubmissionInternState createState() => _SubmissionInternState();
}

class _SubmissionInternState extends State<SubmissionIntern> {
  bool _visible = false;
  int _currentPage = 0; // Track the current page

  // Controllers for the inputs
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController generationController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController projectDetail1Controller =
      TextEditingController();
  final TextEditingController projectDetail2Controller =
      TextEditingController();
  final TextEditingController projectDetail3Controller =
      TextEditingController();
  final TextEditingController urlController = TextEditingController();

  double likertKomunikasiValue = 1.0;
  double likertKreativitasValue = 1.0;
  double likertTanggungJawabValue = 1.0;
  double likertKerjaSamaValue = 1.0;
  double likertTeknisValue = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: "$appName - Daftar ${widget.departmentName}",
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('assets/japfa_logo_background.png'),
            fit: BoxFit.cover,
          ),
        ),
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
                    _buildTitle(),
                    // Show different content based on current page
                    if (_currentPage == 0) _buildSubmissionTextField(),
                    if (_currentPage == 1) _buildSoftSkillScale(),
                    if (_currentPage == 2) _buildProjectSubmissionFields(),
                    const SizedBox(height: 20), // Add spacing before the button
                    _buildRoundedButton(), // Build the button
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method for building the RoundedRectangleButton
  Widget _buildRoundedButton() {
    return RoundedRectangleButton(
      title: "Selanjutnya",
      backgroundColor: japfaOrange,
      fontColor: Colors.white,
      onPressed: () {
        if (validateTextFields(context)) {
          if (_currentPage == 0) {
            setState(() {
              _currentPage = 1; // Go to the next page
            });
          } else if (_currentPage == 1) {
            setState(() {
              _currentPage = 2; // Go to project submission page
            });
          } else if (_currentPage == 2) {
            // Final submission action for Project Submission Page
            int? generation = int.tryParse(generationController.text);
            double? score = double.tryParse(scoreController.text);
            fadeNavigation(context,
                targetNavigation: SubmissionInternFile(
                  departmentName: widget.departmentName,
                  name: nameController.text,
                  address: addressController.text,
                  phoneNumber: phoneNumberController.text,
                  email: emailController.text,
                  university: universityController.text,
                  generation: generation ?? 0,
                  score: score ?? 0,
                  major: majorController.text,
                  likertKomunikasi: likertKomunikasiValue,
                  likertKreativitas: likertKreativitasValue,
                  likertTanggungJawab: likertTanggungJawabValue,
                  likertKerjaSama: likertKerjaSamaValue,
                  likertTeknis: likertTeknisValue,
                  projectDetail1: projectDetail1Controller.text,
                  projectDetail2: projectDetail2Controller.text,
                  projectDetail3: projectDetail3Controller.text,
                  urlProject: urlController.text,
                ));
          }
        }
      },
    );
  }

  // Validate form TEXT fields
  bool validateTextFields(BuildContext context) {
    // Validate for the first page
    if (_currentPage == 0) {
      // Return false if any field validation fails
      return validateField(
              controller: nameController,
              fieldName: "Nama",
              fieldType: FieldType.name,
              context: context) &&
          validateField(
              controller: addressController,
              fieldName: "Alamat",
              fieldType: FieldType.elseMustFill,
              context: context) &&
          validateField(
              controller: phoneNumberController,
              fieldName: "No Telepon",
              fieldType: FieldType.phone,
              context: context) &&
          validateField(
              controller: emailController,
              fieldName: "Email",
              fieldType: FieldType.email,
              context: context) &&
          validateField(
              controller: universityController,
              fieldName: "Asal Universitas",
              fieldType: FieldType.school,
              context: context) &&
          validateField(
              controller: generationController,
              fieldName: "Angkatan",
              fieldType: FieldType.angkatan,
              context: context) &&
          validateField(
              controller: scoreController,
              fieldName: "Nilai",
              fieldType: FieldType.score,
              context: context) &&
          validateField(
              controller: majorController,
              fieldName: "Jurusan",
              fieldType: FieldType.jurusan,
              context: context);
    }

    // Validator for project submission
    if (_currentPage == 2) {
      // Validation for project details (optional)
      return true; // Optional fields can be left blank, so just return true
    }

    return true; // Default true for pages without validation
  }

  // Build Title
  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentPage == 0) {
              Navigator.pop(context);
            } else {
              setState(() {
                _currentPage = _currentPage - 1; // Go back to the previous page
              });
            }
          },
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        Expanded(
          child: Center(
            child: Column(
              children: [
                Text(
                  _currentPage == 0
                      ? 'Data Diri'
                      : _currentPage == 1
                          ? 'Penilaian Diri'
                          : 'Lampiran',
                  style: bold30,
                ),
                _currentPage == 2
                    ? Text(
                        "Bersifat opsional dan boleh kosong",
                        style: regular16,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Build Submission Fields
  Widget _buildSubmissionTextField() {
    return Column(
      children: [
        const SizedBox(height: 20),
        buildTextField('Nama', nameController),
        const SizedBox(height: 20),
        buildTextField('Alamat', addressController),
        const SizedBox(height: 20),
        buildTextField('No Telepon', phoneNumberController),
        const SizedBox(height: 20),
        buildTextField('Email', emailController),
        const SizedBox(height: 15),
        buildTextField('Universitas/Sekolah', universityController),
        const SizedBox(height: 15),
        buildTextField('Angkatan / Kelas', generationController),
        const SizedBox(height: 15),
        buildTextField('Nilai', scoreController),
        const SizedBox(height: 15),
        buildTextField('Jurusan', majorController),
      ],
    );
  }

  // Build Communication Skills and Likert Scale
  Widget _buildSoftSkillScale() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        buildLikertScale(
          'Kemampuan Komunikasi',
          likertKomunikasiValue,
          (newValue) {
            setState(() {
              likertKomunikasiValue = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildLikertScale(
          'Kreativitas',
          likertKreativitasValue,
          (newValue) {
            setState(() {
              likertKreativitasValue = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildLikertScale(
          'Tanggung Jawab',
          likertTanggungJawabValue,
          (newValue) {
            setState(() {
              likertTanggungJawabValue = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildLikertScale(
          'Kerja Sama',
          likertKerjaSamaValue,
          (newValue) {
            setState(() {
              likertKerjaSamaValue = newValue;
            });
          },
        ),
        const SizedBox(height: 10),
        buildLikertScale(
          'Kemampuan Teknis',
          likertTeknisValue,
          (newValue) {
            setState(() {
              likertTeknisValue = newValue;
            });
          },
        ),
      ],
    );
  }

  // Build Project Submission Fields
  Widget _buildProjectSubmissionFields() {
    return Column(
      children: [
        const SizedBox(height: 20),
        buildTextField('Detail Proyek 1', projectDetail1Controller),
        const SizedBox(height: 20),
        buildTextField('Detail Proyek 2', projectDetail2Controller),
        const SizedBox(height: 20),
        buildTextField('Detail Proyek 3', projectDetail3Controller),
        const SizedBox(height: 20),
        buildTextField('URL Lampiran', urlController),
      ],
    );
  }
}
