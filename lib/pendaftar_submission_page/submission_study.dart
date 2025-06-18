import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:japfa_internship/data.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/file_uploading.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:intl/intl.dart';

class SubmissionStudy extends StatefulWidget {
  const SubmissionStudy({super.key});

  @override
  _SubmissionStudyState createState() => _SubmissionStudyState();
}

class _SubmissionStudyState extends State<SubmissionStudy> {
  bool _isFirstForm = true;
  bool _visible = false;
  String labelFieldPersetujuan = 'Dokumen Persetujuan Instansi';
  String? persetujuanInstansiFileName;
  String? persetujuanInstansiPath;
  Uint8List? persetujuanInstansiFile;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController studentCountController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? selectedUniversity;

  // Second form controllers
  DateTime? selectedDate;
  final TextEditingController dateController = TextEditingController();
  TimeOfDay? selectedTie;
  String? selectedSession;

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
        title: appName,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator() // Show loading indicator
              : _isFirstForm
                  ? _buildKunjunganStudiForm()
                  : _buildKunjunganStudiForm2(),
        ),
      ),
    );
  }

  // Form pertama
  Widget _buildKunjunganStudiForm() {
    return Center(
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
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 65),
                    const Text(
                      'Kunjungan Studi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Tanggal Kunjungan studi akan ditentukan lebih lanjut oleh tim HR & GA',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField('Nama Perwakilan', nameController,
                    mandatory: true),
                const SizedBox(height: 15),
                CustomDropdown(
                  label: 'Universitas',
                  mandatory: true,
                  selectedValue: selectedUniversity,
                  options: universities,
                  onChanged: (value) {
                    setState(() {
                      selectedUniversity = value!;
                    });
                  },
                ),
                const SizedBox(height: 15),
                buildTextField(
                  'Jumlah Peserta',
                  studentCountController,
                  mandatory: true,
                  hintText: "Maksimal 55 peserta",
                ),
                const SizedBox(height: 15),
                buildTextField('No Telepon', phoneController, mandatory: true),
                const SizedBox(height: 15),
                buildTextField('Email', emailController, mandatory: true),
                const SizedBox(height: 20),
                RoundedRectangleButton(
                  title: "Next",
                  backgroundColor: japfaOrange,
                  fontColor: Colors.white,
                  onPressed: () async {
                    if (validateFields(context)) {
                      bool emailSudahDaftar =
                          await checkEmailSudahMendaftar(emailController.text);
                      if (emailSudahDaftar == false) {
                        setState(() {
                          _isFirstForm = false; // Show second form
                        });
                      } else {
                        showSnackBar(context,
                            "Email sudah terdaftar pengajuan (Tiap email hanya bisa mendaftar sekali)");
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Form bagian kedua
  Widget _buildKunjunganStudiForm2() {
    return Center(
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
                        setState(() {
                          _isFirstForm = true; // Back to first form
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 61),
                    const Text(
                      'Kunjungan Studi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Hari Kunjungan hanya Selasa - Kamis',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                buildTanggalField(),
                const SizedBox(height: 15),
                buildJamKunjungan(),
                const SizedBox(height: 15),
                FileUploading().buildFileField(
                  labelFieldPersetujuan,
                  persetujuanInstansiFileName,
                  () => FileUploading().pickFile(
                      setState, labelFieldPersetujuan, false, updateFileData),
                  () => FileUploading().removeFile(
                    setState,
                    labelFieldPersetujuan,
                    (field, _, __) {
                      deleteFileData();
                    },
                  ),
                  () => {},
                ),
                const SizedBox(height: 20),
                RoundedRectangleButton(
                  title: "Kirim",
                  backgroundColor: japfaOrange,
                  fontColor: Colors.white,
                  onPressed: () async {
                    if (validateSecondFormFields(context)) {
                      await _submitKunjunganStudiData();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Date field
  Widget buildTanggalField() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: AbsorbPointer(
          // Prevent keyboard from showing
          child: TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Tanggal Kegiatan",
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  // Pilihan jam kunjungan
  Widget buildJamKunjungan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Jam Kegiatan:', style: regular16),
        DropdownButton<String>(
          dropdownColor: Colors.white,
          value: selectedSession,
          hint: const Text('Pilih Jam'),
          items: pilihanJamKunjunganStudi,
          onChanged: (value) {
            setState(() {
              selectedSession = value;
            });
          },
          isExpanded: true,
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    print("DatePicker: Initializing date selection");

    final DateTime now = DateTime.now();
    final DateTime firstAvailableDate = now.add(const Duration(days: 1));

    // Ensure initialDate is selectable
    DateTime initialDate = selectedDate ?? firstAvailableDate;

    // Loop if current date not selectable
    while (!(initialDate.weekday >= DateTime.tuesday &&
        initialDate.weekday <= DateTime.thursday)) {
      initialDate = initialDate.add(
        const Duration(days: 1),
      );
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstAvailableDate,
      lastDate: DateTime(2050),
      selectableDayPredicate: (DateTime date) {
        // Hanya boleh selasa - kamis
        return date.weekday != DateTime.monday &&
            date.weekday != DateTime.friday &&
            date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday;
      },
    );

    print(
        "DatePicker: Date selected: ${picked.toString()}"); // Check if this is printed

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void updateFileData(String field, String? fileName, Uint8List fileBytes) {
    persetujuanInstansiFileName = fileName;
    persetujuanInstansiFile = fileBytes;
  }

  void deleteFileData() {
    persetujuanInstansiFileName = null;
    persetujuanInstansiFile = null;
  }

  // Submit Kunjungan Studi Data
  Future<void> _submitKunjunganStudiData() async {
    if (isLoading) return; // Prevent double submission
    setState(() {
      isLoading = true; // Set loading to true
    });

    final String nama = nameController.text;
    final String asalUniversitas = selectedUniversity!;
    final String jumlahPeserta = studentCountController.text;
    final String noTelepon = phoneController.text;
    final String email = emailController.text.trim();
    final String tanggalKegiatan = dateController.text;

    try {
      persetujuanInstansiPath = await ApiService().uploadFileToServer(
        persetujuanInstansiFile!,
        persetujuanInstansiFileName!,
      );

      // Fetch the current count
      int countResponse =
          await ApiService().kunjunganStudiService.fetchCurrentCount();
      final String idKunjunganStudi = 'KJS_0${countResponse + 1}';

      // Generate password token
      String passwordTokenValue = generateRandomPassword(7);

      final kunjunganStudi = KunjunganStudiData(
        idKunjunganStudi: idKunjunganStudi,
        namaPerwakilan: nama,
        noTelp: noTelepon,
        email: email,
        asalUniversitas: asalUniversitas,
        jumlahPeserta: int.parse(jumlahPeserta),
        tanggalKegiatan: tanggalKegiatan,
        jamKegiatan: selectedSession!,
        pathPersetujuanInstansi: persetujuanInstansiPath!,
        status: statusKunjunganMenunggu,
        passwordToken: passwordTokenValue,
      );

      // Submit the data
      final response = await ApiService()
          .kunjunganStudiService
          .submitKunjunganStudi(kunjunganStudi);

      // Send email with password token
      await ApiService().sendEmail(
        email,
        nama,
        passwordTokenValue,
        EmailMessageType.daftarKunjungan,
      );

      if (response.statusCode == 201) {
        showSnackBar(context, pengajuanSuksesValue,
            backgroundColor: Colors.green);
        fadeNavigation(context, targetNavigation: const MyHomePage());
        showConfirmationDialog(
          context,
          title: confirmationTitleValue,
          message: confirmationMessageValue,
        );
      } else {
        throw Exception('Failed to submit details');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Submission failed: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Validate fields for the first form
  bool validateFields(BuildContext context) {
    if (!validateField(
        controller: nameController,
        fieldName: "Nama",
        fieldType: FieldType.name,
        context: context)) {
      return false;
    }
    if (!validateField(
        controller: universityController,
        fieldName: "Asal Universitas",
        fieldType: FieldType.universityDropdown,
        selectedValue: selectedUniversity,
        context: context)) {
      return false;
    }
    if (!validateField(
        controller: studentCountController,
        fieldName: "Jumlah Anak",
        fieldType: FieldType.jumlahAnakKunjungan,
        context: context)) {
      return false;
    }
    if (!validateField(
        controller: phoneController,
        fieldName: "No Telepon",
        fieldType: FieldType.phone,
        context: context)) {
      return false;
    }
    if (!validateField(
        controller: emailController,
        fieldName: "Email",
        fieldType: FieldType.email,
        context: context)) {
      return false;
    }
    return true;
  }

  // Validate fields for the second form
  bool validateSecondFormFields(BuildContext context) {
    if (!validateField(
        controller: dateController,
        fieldName: "Tanggal Kegiatan",
        fieldType: FieldType.elseMustFill,
        context: context)) {
      return false;
    }
    if (selectedSession == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Silahkan pilih jam")));
      return false;
    }
    if (persetujuanInstansiFileName == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Tolong upload file ")));
      return false;
    }
    return true;
  }

// Method for checking if an email has already been submitted
  Future<bool> checkEmailSudahMendaftar(String email) async {
    try {
      // Call the function to fetch data by email
      final response = await ApiService()
          .kunjunganStudiService
          .fetchKunjunganDataByEmail(email);

      print("API Response Kunjungan: $response");

      // Check if the response is an empty list
      if (response.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print("error : $e");
      return false; // Consider returning false if an error occurs
    }
  }
}
