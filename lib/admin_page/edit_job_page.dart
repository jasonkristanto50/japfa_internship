import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class EditJobModal extends StatefulWidget {
  final Map<String, dynamic> job;

  const EditJobModal({super.key, required this.job});

  @override
  _EditJobModalState createState() => _EditJobModalState();
}

class _EditJobModalState extends State<EditJobModal> {
  late TextEditingController maxQuotaController;
  late TextEditingController totalApplicationsController;
  late TextEditingController approvedController;
  late TextEditingController onboardingController;
  late TextEditingController remainingQuotaController;

  @override
  void initState() {
    super.initState();
    maxQuotaController =
        TextEditingController(text: widget.job['maxQuota'].toString());
    totalApplicationsController =
        TextEditingController(text: widget.job['totalApplications'].toString());
    approvedController =
        TextEditingController(text: widget.job['approved'].toString());
    onboardingController =
        TextEditingController(text: widget.job['onboarding'].toString());
    remainingQuotaController =
        TextEditingController(text: widget.job['remainingQuota'].toString());
  }

  @override
  void dispose() {
    maxQuotaController.dispose();
    totalApplicationsController.dispose();
    approvedController.dispose();
    onboardingController.dispose();
    remainingQuotaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16)), // Rounded corners for the modal
      title: Center(
        // Center the title
        child: Text('EDIT JOB', style: bold14),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the selected job under the title
            Center(
              child: Text(
                  widget.job['job']
                      .toString()
                      .toUpperCase(), // Display the job name here
                  style: bold16.copyWith(color: japfaOrange)),
            ),
            const SizedBox(height: 16),
            _buildTextField(maxQuotaController, 'Max Kuota'),
            _buildTextField(totalApplicationsController, 'Jumlah Pengajuan'),
            _buildTextField(approvedController, 'Jumlah Approved'),
            _buildTextField(onboardingController, 'Jumlah On Boarding'),
            _buildTextField(remainingQuotaController, 'Sisa Kuota'),
            const SizedBox(height: 16),
            Center(
                // Center the Save Changes button
                child: RoundedRectangleButton(
                    title: 'SAVE',
                    backgroundColor: japfaOrange,
                    onPressed: _saveChanges)),
          ],
        ),
      ),
    );
  }

  // Function to save changes and close the modal
  void _saveChanges() {
    setState(() {
      widget.job['maxQuota'] =
          int.tryParse(maxQuotaController.text) ?? widget.job['maxQuota'];
      widget.job['totalApplications'] =
          int.tryParse(totalApplicationsController.text) ??
              widget.job['totalApplications'];
      widget.job['approved'] =
          int.tryParse(approvedController.text) ?? widget.job['approved'];
      widget.job['onboarding'] =
          int.tryParse(onboardingController.text) ?? widget.job['onboarding'];
      widget.job['remainingQuota'] =
          int.tryParse(remainingQuotaController.text) ??
              widget.job['remainingQuota'];
    });

    Navigator.pop(context); // Close the modal after saving
  }

  // Custom method to build text fields for the modal
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: controller.text.isEmpty
                ? Colors.black
                : Colors
                    .orange, // Change label color to red when the field is focused
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: japfaOrange,
                width: 2), // Focused border color set to red
          ),
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(
            color: Colors.black), // Text color (black by default)
        cursorColor: Colors.black, // Cursor color set to red
      ),
    );
  }
}
