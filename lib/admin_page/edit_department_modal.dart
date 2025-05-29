import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart'; // Make sure to import DepartemenData

class EditDepartmentModal extends StatefulWidget {
  final DepartemenData department;

  const EditDepartmentModal({super.key, required this.department});

  @override
  _EditDepartmentModalState createState() => _EditDepartmentModalState();
}

class _EditDepartmentModalState extends State<EditDepartmentModal> {
  late TextEditingController maxQuotaController;

  @override
  void initState() {
    super.initState();
    maxQuotaController =
        TextEditingController(text: widget.department.maxKuota.toString());
  }

  @override
  void dispose() {
    maxQuotaController.dispose();
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
        child: Text('EDIT Department', style: bold14),
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
            const SizedBox(height: 16),
            Center(
                child: RoundedRectangleButton(
                    title: 'SIMPAN',
                    backgroundColor: japfaOrange,
                    onPressed: _saveChanges)),
          ],
        ),
      ),
    );
  }

  // Function to save changes and close the modal
  void _saveChanges() async {
    try {
      int departmentNowMaxKuota = widget.department.maxKuota ?? 0;
      int newMaxKuota =
          int.tryParse(maxQuotaController.text) ?? departmentNowMaxKuota;

      // Calculate new sisa_kuota based on jumlah approved
      int departmentNowApproved = widget.department.jumlahApproved ?? 0;
      int newSisaKuota = newMaxKuota - departmentNowApproved;

      // Call the API method to update max kuota
      await ApiService().departemenService.updateMaxKuotaDepartemen(
          widget.department.idDepartemen, newMaxKuota);

      // Create a new instance of DepartemenData with the updated maxKuota
      DepartemenData updatedDepartment = widget.department
          .copyWith(maxKuota: newMaxKuota, sisaKuota: newSisaKuota);

      Navigator.pop(context, updatedDepartment);
    } catch (e) {
      // Handle errors (e.g., show a snackbar or dialog)
      print('Failed to save changes: $e');
    }
  }

  // Custom method to build text field for the modal
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
            color: controller.text.isEmpty ? Colors.black : Colors.orange,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: japfaOrange, width: 2),
          ),
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );
  }
}
