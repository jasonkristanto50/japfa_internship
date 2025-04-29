import 'package:flutter/material.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/pendaftar_submission_page/submission_intern_file.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';

class SubmissionIntern extends StatefulWidget {
  const SubmissionIntern({super.key});

  @override
  _SubmissionInternState createState() => _SubmissionInternState();
}

class _SubmissionInternState extends State<SubmissionIntern> {
  bool _visible = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController generationController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();

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
                            Navigator.pop(context);
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
                    _buildSubmissionTextField(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // validate form TEXT fields
  bool validateTextFields(BuildContext context) {
    if (!validateField(
        controller: nameController,
        fieldName: "Nama",
        fieldType: FieldType.name,
        context: context)) {
      return false;
    }

    if (!validateField(
        controller: addressController,
        fieldName: "Alamat",
        fieldType: FieldType.elseMustFill,
        context: context)) {
      return false;
    }

    if (!validateField(
        controller: phoneNumberController,
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

    if (!validateField(
        controller: universityController,
        fieldName: "Asal Universitas",
        fieldType: FieldType.school,
        context: context)) {
      return false;
    }

    if (!validateField(
        controller: generationController,
        fieldName: "Angkatan",
        fieldType: FieldType.angkatan,
        context: context)) {
      return false;
    }

    if (!validateField(
        controller: scoreController,
        fieldName: "Nilai",
        fieldType: FieldType.score,
        context: context)) {
      return false;
    }

    if (!validateField(
        controller: majorController,
        fieldName: "Jurusan",
        fieldType: FieldType.jurusan,
        context: context)) {
      return false;
    }

    return true;
  }

  // BUILD FORM
  Widget _buildSubmissionTextField() {
    return Column(
      children: [
        const SizedBox(height: 20),
        buildTextField('Name', nameController),
        const SizedBox(height: 20),
        buildTextField('Address', addressController),
        const SizedBox(height: 20),
        buildTextField('Phone Number', phoneNumberController),
        const SizedBox(height: 20),
        buildTextField('Email', emailController),
        const SizedBox(height: 15),
        buildTextField('University/School', universityController),
        const SizedBox(height: 15),
        buildTextField('Angkatan / Kelas', generationController),
        const SizedBox(height: 15),
        buildTextField('Score', scoreController),
        const SizedBox(height: 15),
        buildTextField('Jurusan', majorController),
        const SizedBox(height: 20),
        RoundedRectangleButton(
          title: "Next",
          backgroundColor: japfaOrange,
          fontColor: Colors.white,
          onPressed: () {
            // if (validateTextFields(context)) {
            //   fadeNavigation(context,
            //       targetNavigation: const SubmissionInternFile());
            // }
            fadeNavigation(context,
                targetNavigation: const SubmissionInternFile());
          },
        ),
      ],
    );
  }
}
