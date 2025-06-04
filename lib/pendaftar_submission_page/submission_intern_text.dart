import 'package:flutter/material.dart';
import 'package:japfa_internship/data.dart';
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
  int _currentPage = 0;

  // Controllers for the inputs
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController generationController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  List<TextEditingController> projectNameControllers = [];
  final TextEditingController urlController = TextEditingController();

  String? selectedUniversity;
  String? akreditasiUniversitas;
  String? selectedMajor;

  double likertKomunikasiValue = 1.0;
  double likertKreativitasValue = 1.0;
  double likertTanggungJawabValue = 1.0;
  double likertKerjaSamaValue = 1.0;
  double likertTeknisValue = 1.0;

  final List<String> projectName = [];

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
                    _buildNextButton(), // Build the button
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build Title
  Widget _buildTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (_currentPage == 0) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    _currentPage =
                        _currentPage - 1; // Go back to the previous page
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
                              : 'Lampiran Proyek',
                      style: bold30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            _currentPage == 2
                ? Column(
                    children: [
                      Text(
                        "Tuliskan Judul Proyek yang Pernah Dikerjakan",
                        style: regular16,
                      ),
                      Text(
                        "Bersifat opsional / tidak wajib",
                        style: regular14,
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        )
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
        buildDropDownField(
          'Universitas/Sekolah',
          selectedUniversity,
          universities, // universities list
          (value) {
            setState(() {
              selectedUniversity = value!;
              final selectedUniversityData = universities.firstWhere(
                (univ) => univ['value'] == selectedUniversity,
                orElse: () => {'akreditasi': ''},
              );
              akreditasiUniversitas =
                  selectedUniversityData['akreditasi'] ?? '';
              print('Akreditas : $akreditasiUniversitas');
            });
          },
        ),
        const SizedBox(height: 15),
        buildTextField('Angkatan / Kelas', generationController),
        const SizedBox(height: 15),
        buildTextField('Nilai', scoreController),
        const SizedBox(height: 15),
        buildDropDownField(
          'Jurusan',
          selectedMajor,
          majors, // jurusan list
          (value) {
            setState(() {
              selectedMajor = value!;
            });
          },
        ),
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

  Widget _buildProjectSubmissionFields() {
    int maxField = 5;
    bool isMax = projectNameControllers.length == maxField;
    return Column(
      children: [
        const SizedBox(height: 20),
        ...projectNameControllers.asMap().entries.map((entry) {
          int index = entry.key;

          TextEditingController controller = entry.value;

          return Column(
            children: [
              buildTextField(
                'Judul Proyek ${index + 1} (Opsional)',
                controller,
                withDeleteIcon: true,
                onDelete: () {
                  _removeProjectField(index);
                },
              ),
              const SizedBox(height: 20),
            ],
          );
        }),
        buildTextField('Link Lampiran (untuk semua proyek)', urlController),
        const SizedBox(height: 10),

        // Add button to add more project fields
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RoundedRectangleButton(
              title: "Tambah Proyek",
              fontColor: !isMax ? japfaOrange : Colors.white,
              backgroundColor: !isMax ? Colors.white : Colors.grey,
              outlineColor: !isMax ? japfaOrange : Colors.grey,
              width: 150,
              height: 30,
              rounded: 5,
              onPressed: !isMax
                  ? () => _addProjectField()
                  : () => showSnackBar(
                        context,
                        "Proyek yang bisa dituliskan sudah maksimal",
                        backgroundColor: darkGrey,
                      ),
            ),
          ],
        ),
      ],
    );
  }

  void _addProjectField() {
    setState(() {
      projectNameControllers.add(TextEditingController());
    });
  }

  void _removeProjectField(int index) {
    setState(() {
      if (projectNameControllers.isNotEmpty) {
        projectNameControllers[index].dispose();
        projectNameControllers.removeAt(index);
      }
    });
  }

  // Method for building the RoundedRectangleButton
  Widget _buildNextButton() {
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

            // Prepare project names for submission
            addProjectNameList();

            // TODO: Fix project detail
            fadeNavigation(
              context,
              targetNavigation: SubmissionInternFile(
                departmentName: widget.departmentName,
                name: nameController.text,
                address: addressController.text,
                phoneNumber: phoneNumberController.text,
                email: emailController.text,
                university: selectedUniversity!,
                akreditasiUniversitas: akreditasiUniversitas!,
                generation: generation ?? 0,
                score: score ?? 0,
                major: selectedMajor!,
                likertKomunikasi: likertKomunikasiValue,
                likertKreativitas: likertKreativitasValue,
                likertTanggungJawab: likertTanggungJawabValue,
                likertKerjaSama: likertKerjaSamaValue,
                likertTeknis: likertTeknisValue,
                listProjectName: projectName,
                urlProject: urlController.text,
              ),
              time: 0, // No fade animation
            );
          }
        }
      },
    );
  }

  void addProjectNameList() {
    projectName.clear();
    for (var controller in projectNameControllers) {
      // Add only non-empty strings to the projectName list
      String text = controller.text.trim();
      if (text.isNotEmpty) {
        projectName.add(text);
      }
    }
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
              selectedValue: selectedUniversity,
              fieldName: "Asal Universitas",
              fieldType: FieldType.universityDropdown,
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
              selectedValue: selectedMajor,
              fieldName: "Jurusan",
              fieldType: FieldType.jurusanDropdown,
              context: context);
    }

    // Validator for project submission
    if (_currentPage == 2) {
      // Validation for project details (optional)
      return true; // Optional fields can be left blank, so just return true
    }

    return true; // Default true for pages without validation
  }
}
