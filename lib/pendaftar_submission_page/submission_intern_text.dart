import 'package:flutter/material.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/models/universitas_data/universitas_data.dart';
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
  List<TextEditingController> projectNameControllers = [
    TextEditingController() // default 1 field
  ];
  final TextEditingController urlController = TextEditingController();

  late List<UniversitasData> universities;
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
    _fetchUniversities();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = isScreenMobile(context);

    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: Navbar(
        context: context,
        title:
            isMobile ? appName : "$appName - Daftar ${widget.departmentName}",
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Center(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: SingleChildScrollView(
              child: Container(
                width: isMobile ? 300 : 400,
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
                    // Different form based on page
                    if (_currentPage == 0) _buildSubmissionTextField(),
                    if (_currentPage == 1) _buildSoftSkillScale(),
                    if (_currentPage == 2) _buildProjectSubmissionFields(),
                    const SizedBox(height: 20),
                    _buildNextButton(),
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
    bool isMobile = isScreenMobile(context);
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
                      style: isMobile ? bold14 : bold30,
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
                        style: isMobile ? regular10 : regular16,
                      ),
                      Text(
                        "Bersifat opsional / tidak wajib",
                        style: isMobile ? regular10 : regular14,
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
    print("Universitas Akhir: $universities");
    bool isMobile = isScreenMobile(context);
    return Column(
      children: [
        const SizedBox(height: 20),
        buildTextField('Nama', nameController,
            mandatory: true, isMobile: isMobile),
        const SizedBox(height: 20),
        buildTextField('Alamat', addressController,
            mandatory: true, isMobile: isMobile),
        const SizedBox(height: 20),
        buildTextField('No Telepon', phoneNumberController,
            mandatory: true, isMobile: isMobile),
        const SizedBox(height: 20),
        buildTextField('Email', emailController,
            mandatory: true, isMobile: isMobile),
        const SizedBox(height: 15),
        // buildDropDownField(
        //   'Universitas/Sekolah',
        //   mandatory: true,
        //   selectedUniversity,
        //   universities,
        //   (value) {
        //     setState(() {
        //       selectedUniversity = value!;
        //       final selectedUniversityData = universities.firstWhere(
        //         (univ) => univ['value'] == selectedUniversity,
        //         orElse: () => {'akreditasi': ''},
        //       );
        //       akreditasiUniversitas =
        //           selectedUniversityData['akreditasi'] ?? '';
        //       print('Akreditas : $akreditasiUniversitas');
        //     });
        //   },
        // ),
        CustomDropdown(
          label: 'Universitas/Sekolah',
          selectedValue: selectedUniversity,
          options: universities
              .map((univ) => {
                    'value': univ.namaUniversitas,
                    'name': univ.namaUniversitas,
                    'akreditasi': univ.akreditasi,
                  })
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedUniversity = value!;
              final selectedUniv = universities.firstWhere(
                (selected) => selected.namaUniversitas == value,
                orElse: () =>
                    const UniversitasData(namaUniversitas: '', akreditasi: ''),
              );
              akreditasiUniversitas = selectedUniv.akreditasi;
            });
          },
          mandatory: true,
        ),
        const SizedBox(height: 15),
        buildTextField('Angkatan', generationController,
            mandatory: true, isMobile: isMobile),
        const SizedBox(height: 15),
        buildTextField('IPK', scoreController,
            mandatory: true, isMobile: isMobile),
        const SizedBox(height: 15),
        buildTextField('Jurusan', majorController)
      ],
    );
  }

  // Build Communication Skills and Likert Scale
  Widget _buildSoftSkillScale() {
    bool isMobile = isScreenMobile(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        buildLikertScale('Kemampuan Komunikasi', likertKomunikasiValue,
            (newValue) {
          setState(() {
            likertKomunikasiValue = newValue;
          });
        }, isMobile: isMobile),
        const SizedBox(height: 10),
        buildLikertScale('Kreativitas', likertKreativitasValue, (newValue) {
          setState(() {
            likertKreativitasValue = newValue;
          });
        }, isMobile: isMobile),
        const SizedBox(height: 10),
        buildLikertScale('Tanggung Jawab', likertTanggungJawabValue,
            (newValue) {
          setState(() {
            likertTanggungJawabValue = newValue;
          });
        }, isMobile: isMobile),
        const SizedBox(height: 10),
        buildLikertScale('Kerja Sama', likertKerjaSamaValue, (newValue) {
          setState(() {
            likertKerjaSamaValue = newValue;
          });
        }, isMobile: isMobile),
        const SizedBox(height: 10),
        buildLikertScale('Kemampuan Teknis', likertTeknisValue, (newValue) {
          setState(() {
            likertTeknisValue = newValue;
          });
        }, isMobile: isMobile),
      ],
    );
  }

  Widget _buildProjectSubmissionFields() {
    bool isMobile = isScreenMobile(context);
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
              buildTextField('Judul Proyek ${index + 1} (Opsional)', controller,
                  withDeleteIcon: true, onDelete: () {
                _removeProjectField(index);
              }, isMobile: isMobile),
              const SizedBox(height: 20),
            ],
          );
        }),
        buildTextField('Link Lampiran (untuk semua proyek)', urlController,
            isMobile: isMobile),
        const SizedBox(height: 10),

        // Add button to add more project fields
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RoundedRectangleButton(
              title: isMobile ? "Tambah" : "Tambah Proyek",
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
      onPressed: () async {
        bool emailSudahDaftar =
            await checkEmailSudahMendaftar(emailController.text);
        if (validateTextFields(context)) {
          if (_currentPage == 0) {
            if (emailSudahDaftar == false) {
              setState(() {
                _currentPage = 1;
              });
            } else {
              showSnackBar(context,
                  "Email sudah terdaftar pengajuan (Tiap email hanya bisa mendaftar sekali)");
            }
          } else if (_currentPage == 1) {
            setState(() {
              _currentPage = 2;
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
                major: majorController.text,
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

  Future<void> _fetchUniversities() async {
    setState(() {
      isLoading = true;
    });
    try {
      universities =
          await ApiService().universitasService.fetchUniversitasData();
    } catch (e) {
      showSnackBar(context, "Gagal mengambil list universitas");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Method for checking if an email has already been submitted
  Future<bool> checkEmailSudahMendaftar(String email) async {
    try {
      // Call the function to fetch data by email
      await ApiService().pesertaMagangService.fetchPesertaMagangByEmail(email);

      // Check if the response is empty
      return true;
    } catch (e) {
      print("error : $e");
      return false;
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
              fieldType: FieldType.elseMustFill,
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
