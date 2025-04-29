import 'package:flutter/material.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:dio/dio.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/timeline_interview.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';

class SubmissionStudy extends StatefulWidget {
  const SubmissionStudy({super.key});

  @override
  _SubmissionStudyState createState() => _SubmissionStudyState();
}

class _SubmissionStudyState extends State<SubmissionStudy> {
  bool _visible = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController studentCountController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime? selectedDate;

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
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/japfa_logo_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: _buildKunjunganStudiForm()),
    );
  }

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
                  'Fill in your details and submit the required information.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField('Nama Perwakilan', nameController),
                const SizedBox(height: 15),
                buildTextField('Asal Universitas', universityController),
                const SizedBox(height: 15),
                buildTextField('Jumlah Anak', studentCountController),
                const SizedBox(height: 15),
                buildTextField('No Telepon', phoneController),
                const SizedBox(height: 15),
                buildTextField('Email', emailController),
                const SizedBox(height: 15),
                buildDateField(),
                const SizedBox(height: 20),
                RoundedRectangleButton(
                  title: "Submit",
                  backgroundColor: japfaOrange,
                  fontColor: Colors.white,
                  onPressed: () async {
                    await _submitStudyDetails(); // Call the submit method
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to create a date picker field
  Widget buildDateField() {
    return TextField(
      controller: dateController,
      readOnly: true, // Make it read-only to prevent manual input
      decoration: InputDecoration(
        labelText: "Tanggal Kegiatan",
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }

  // Method to show date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.toLocal()}"
            .split(' ')[0]; // Set the selected date in the TextField
      });
    }
  }

  // Method to submit the details
  Future<void> _submitStudyDetails() async {
    final String nama = nameController.text;
    final String asalUniversitas = universityController.text;
    final String jumlahAnak = studentCountController.text;
    final String noTelepon = phoneController.text;
    final String email = emailController.text;
    final String tanggalKegiatan = dateController.text;

    // Fetch the current count to generate the new ID
    final countResponse =
        await Dio().get('http://localhost:3000/api/kunjungan_studi/count');
    final currentCount = int.parse(countResponse.data['count']);

    final String idKunjunganStudi = 'KJS_0${currentCount + 1}';

    final kunjunganStudi = KunjunganStudiData(
        idKunjunganStudi: idKunjunganStudi,
        namaPerwakilan: nama,
        noTelp: noTelepon,
        email: email,
        asalUniversitas: asalUniversitas,
        jumlahAnak: int.parse(jumlahAnak), // Convert to int if necessary
        tanggalKegiatan: tanggalKegiatan,
        status: "Menunggu");

    const String url =
        'http://localhost:3000/api/kunjungan_studi/submit-kunjungan-studi';

    try {
      final response = await Dio().post(
        url,
        data: kunjunganStudi.toJson(),
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission successful!')),
        );
        fadeNavigation(context, targetNavigation: const TimelineInterview());
      } else {
        throw Exception('Failed to submit details');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission failed: $e')),
      );
    }
  }
}
