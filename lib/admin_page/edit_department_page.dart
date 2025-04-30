import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart'; // Make sure to import DepartemenData

class EditDepartmentModal extends StatefulWidget {
  final DepartemenData department; // Change to DepartemenData

  const EditDepartmentModal({super.key, required this.department});

  @override
  _EditDepartmentModalState createState() => _EditDepartmentModalState();
}

class _EditDepartmentModalState extends State<EditDepartmentModal> {
  late TextEditingController maxQuotaController;
  late TextEditingController totalApplicationsController;
  late TextEditingController approvedController;
  late TextEditingController onboardingController;
  late TextEditingController remainingQuotaController;

  @override
  void initState() {
    super.initState();
    maxQuotaController =
        TextEditingController(text: widget.department.maxKuota.toString());
    totalApplicationsController = TextEditingController(
        text: widget.department.jumlahPengajuan.toString());
    approvedController = TextEditingController(
        text: widget.department.jumlahApproved.toString());
    onboardingController = TextEditingController(
        text: widget.department.jumlahOnBoarding.toString());
    remainingQuotaController =
        TextEditingController(text: widget.department.sisaKuota.toString());
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
        child: Text('EDIT department', style: bold14),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the selected department under the title
            Center(
              child: Text(
                  widget.department.namaDepartemen
                      .toString()
                      .toUpperCase(), // Access namaDepartemen directly
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
      // TODO:
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
