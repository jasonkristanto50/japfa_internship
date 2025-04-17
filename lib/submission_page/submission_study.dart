import 'package:flutter/material.dart';
import 'package:japfa_internship/components/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/timeline_interview.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart'; // Assuming custom widget components

class SubmissionStudy extends StatefulWidget {
  const SubmissionStudy({super.key});

  @override
  _SubmissionStudyState createState() => _SubmissionStudyState();
}

class _SubmissionStudyState extends State<SubmissionStudy> {
  bool _visible = false;

  // To hold the file details (name and path)
  String? cvFileName;
  String? campusApprovalFileName;
  String? transcriptFileName;
  String? cvFilePath;
  String? campusApprovalFilePath;
  String? transcriptFilePath;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController studentCountController = TextEditingController();
  final TextEditingController dateController =
      TextEditingController(); // New controller for date

  // Add a new variable to store the selected date
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
                      'Fill in your details and upload the required documents.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildTextField('Name', nameController),
                    const SizedBox(height: 15),
                    buildTextField('University/School', universityController),
                    const SizedBox(height: 15),
                    buildTextField('Jumlah Anak', studentCountController),
                    const SizedBox(height: 15),
                    buildDateField(),
                    const SizedBox(height: 20),
                    RoundedRectangleButton(
                      title: "Submit",
                      backgroundColor: japfaOrange,
                      fontColor: Colors.white,
                      onPressed: () {
                        // Handle submission logic here
                        fadeNavigation(context,
                            targetNavigation: const TimelineInterview());
                      },
                    ),
                  ],
                ),
              ),
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
        labelText: "Select Date",
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
}
