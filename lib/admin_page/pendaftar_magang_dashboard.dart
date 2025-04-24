import 'package:flutter/material.dart';
import 'package:japfa_internship/admin_page/detail_pengajuan_magang.dart';
import 'package:japfa_internship/admin_page/edit_department_page.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/data.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class PendaftarMagangDashboard extends StatefulWidget {
  const PendaftarMagangDashboard({super.key});

  @override
  State<PendaftarMagangDashboard> createState() =>
      _PendaftarMagangDashboardState();
}

class _PendaftarMagangDashboardState extends State<PendaftarMagangDashboard> {
  String selectedDepartment = 'Semua Departemen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Button to add a new department
              Padding(
                padding: const EdgeInsets.only(
                    left: 200.0, right: 16.0, top: 30.0, bottom: 0),
                child: RoundedRectangleButton(
                  title: "Tambah Departemen",
                  backgroundColor: Colors.white,
                  outlineColor: japfaOrange,
                  height: 40,
                  width: 200,
                  rounded: 5,
                  onPressed: () {
                    _addNewDepartment();
                  },
                ),
              ),

              // Table Section - Centered
              Expanded(
                child: Center(
                  child: _buildPengajuanTable(),
                ),
              ),
              const SizedBox(height: 24), // Extra space if needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPengajuanTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(Colors.orange[500]),
          headingTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          border: TableBorder.all(
            color: Colors.grey,
            width: 1,
          ),
          columns: const [
            DataColumn(label: Text('Departemen')),
            DataColumn(label: Text('Max Kuota')),
            DataColumn(label: Text('Jumlah Pengajuan')),
            DataColumn(label: Text('Jumlah Approved')),
            DataColumn(label: Text('Jumlah On Boarding')),
            DataColumn(label: Text('Sisa Kuota')),
            DataColumn(label: Text('Action')),
          ],
          rows: pengajuanDepartemen.map((department) {
            return DataRow(
              cells: [
                DataCell(Text(department['department'].toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department['maxQuota'].toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department['totalApplications'].toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department['approved'].toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department['onboarding'].toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department['remainingQuota'].toString(),
                    textAlign: TextAlign.center)),
                DataCell(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedRectangleButton(
                        title: "EDIT",
                        backgroundColor:
                            const Color.fromARGB(255, 247, 211, 159),
                        height: 30,
                        width: 85,
                        rounded: 5,
                        onPressed: () => _editTable(department),
                      ),
                      const SizedBox(width: 8), // Space between buttons
                      RoundedRectangleButton(
                        title: "VIEW",
                        backgroundColor:
                            const Color.fromARGB(255, 152, 209, 255),
                        height: 30,
                        width: 85,
                        rounded: 5,
                        onPressed: () =>
                            _onViewApplications(department['department']),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // Function to handle adding a new department
  void _addNewDepartment() {
    // Show a dialog for adding a new department
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Department'),
          content: const Text(
              'Fill out the information here...'), // Replace with your form
          actions: [
            TextButton(
              onPressed: () {
                // Handle save functionality
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to handle Edit Button click
  void _editTable(Map<String, dynamic> department) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDepartmentModal(department: department);
      },
    );
  }

  // Function to handle View Applications Button click
  void _onViewApplications(String departmentName) {
    // Navigate to the applications view for the specific job
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailPengajuanMagang(departmentName: departmentName),
      ),
    );
  }
}
