import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // PDF Viewer package
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/timeline_interview.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart'; // Assuming custom widget components

class SubmissionIntern extends StatefulWidget {
  const SubmissionIntern({super.key});

  @override
  _SubmissionInternState createState() => _SubmissionInternState();
}

class _SubmissionInternState extends State<SubmissionIntern> {
  int pageNumber = 1;
  bool _visible = false;

  // To hold the file details (name and path)
  String? cvFileName;
  String? campusApprovalFileName;
  String? transcriptFileName;
  String? cvFilePath;
  String? campusApprovalFilePath;
  String? transcriptFilePath;

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
                            // If pageNumber is 2, revert it to 1
                            if (pageNumber == 2) {
                              setState(() {
                                pageNumber = 1; // Revert pageNumber to 1
                              });
                            } else {
                              Navigator.pop(
                                  context); // Otherwise, go back to previous screen
                            }
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
                    if (pageNumber == 1) ...[
                      _buildSubmissionTextField(),
                    ] else if (pageNumber == 2)
                      _buildSubmissionFileField(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
            setState(() {
              pageNumber = 2;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSubmissionFileField() {
    return Column(
      children: [
        const SizedBox(height: 15),
        buildFileField('CV', cvFileName, 'CV'),
        const SizedBox(height: 15),
        buildFileField(
            'Campus Approval', campusApprovalFileName, 'Campus Approval'),
        const SizedBox(height: 15),
        buildFileField(
            'Score Transcript', transcriptFileName, 'Score Transcript'),
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
    );
  }

  // Custom method to create file upload fields with delete functionality
  Widget buildFileField(String label, String? fileName, String field) {
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
                  onTap: () => pickFile(field),
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
                        Text(fileName),
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

  // Method to pick files using file_picker package
  void pickFile(String field) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Allow only PDF files
    );

    if (result != null) {
      String fileName = result.files.single.name;

      setState(() {
        // Store the file names and paths for display and opening
        if (field == 'CV') {
          cvFileName = fileName;
          cvFilePath = result.files.single.path;
        } else if (field == 'Campus Approval') {
          campusApprovalFileName = fileName;
          campusApprovalFilePath = result.files.single.path;
        } else if (field == 'Score Transcript') {
          transcriptFileName = fileName;
          transcriptFilePath = result.files.single.path;
        }
      });
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
