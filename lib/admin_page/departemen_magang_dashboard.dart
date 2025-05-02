import 'package:flutter/material.dart';
import 'package:japfa_internship/admin_page/pendaftaran_magang_departemen.dart';
import 'package:japfa_internship/admin_page/edit_department_modal.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class DepartemenMagangDashboard extends StatefulWidget {
  const DepartemenMagangDashboard({super.key});

  @override
  State<DepartemenMagangDashboard> createState() =>
      _DepartemenMagangDashboardState();
}

class _DepartemenMagangDashboardState extends State<DepartemenMagangDashboard> {
  List<DepartemenData> departemen = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadDepartemen();
  }

  @override
  Widget build(BuildContext context) {
    // Search filter for departments
    List<DepartemenData> filteredData = departemen
        .where((department) => department.namaDepartemen
            .toLowerCase()
            .contains(searchQuery.toLowerCase())) // Search filter
        .toList();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Add Custom Search Bar
            CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value; // Update search query
                });
              },
              widthValue: 175,
            ),
            // Button to add a new department - left aligned
            Padding(
              padding: const EdgeInsets.only(left: 175.0, top: 0.0, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft, // Align to the left
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
            ),
            const SizedBox(height: 10), // Space between button and table

            // Table Section

            _buildPengajuanTable(filteredData),
          ],
        ),
      ),
    );
  }

  Future<void> _loadDepartemen() async {
    try {
      List<DepartemenData> fetchedDepartemen =
          await ApiService().fetchDepartemen();
      setState(() {
        departemen = fetchedDepartemen;
      });
    } catch (e) {
      // Handle the error (e.g., show a snackbar or dialog)
      print("Error fetching departemen: $e");
    }
  }

  Widget _buildPengajuanTable(List<DepartemenData> filteredData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set the desired background color
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
          rows: filteredData.map((department) {
            return DataRow(
              cells: [
                DataCell(Text(department.namaDepartemen,
                    textAlign: TextAlign.center)), // Corrected this line
                DataCell(Text(department.maxKuota.toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department.jumlahPengajuan.toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department.jumlahApproved.toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department.jumlahOnBoarding.toString(),
                    textAlign: TextAlign.center)),
                DataCell(Text(department.sisaKuota.toString(),
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
                            _onViewApplications(department.namaDepartemen),
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

  void _addNewDepartment() {
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

  void _editTable(DepartemenData department) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditDepartmentModal(department: department);
      },
    ).then((updatedDepartment) {
      if (updatedDepartment != null) {
        setState(() {
          // Find the index and update the list
          int index = departemen.indexWhere(
              (d) => d.idDepartemen == updatedDepartment.idDepartemen);
          if (index != -1) {
            departemen[index] =
                updatedDepartment; // Update the list with the new department instance
          }
        });
      }
    });
  }

  void _onViewApplications(String departmentName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PendaftaranMagangDepartemen(departmentName: departmentName),
      ),
    );
  }
}
