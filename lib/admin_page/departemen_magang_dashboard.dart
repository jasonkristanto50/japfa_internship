import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  TextEditingController? namaDepartemen;

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
            _buildSearchAndAddDepartemenButton(),
            const SizedBox(height: 10),

            // Table Section
            _buildDepartemenTable(filteredData),
          ],
        ),
      ),
    );
  }

  Future<void> _loadDepartemen() async {
    try {
      // Fetch all departments
      // TODO: update kuota tersisa
      List<DepartemenData> fetchedDepartemen =
          await ApiService().departemenService.fetchDepartemenDataUpdateCount();

      setState(() {
        departemen = fetchedDepartemen;
      });
    } catch (e) {
      print("Error fetching departemen: $e");
    }
  }

  Widget _buildSearchAndAddDepartemenButton() {
    return // Add Custom Search Bar
        Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSearchBar(
            onChanged: (value) {
              setState(() {
                searchQuery = value; // Update search query
              });
            },
            widthValue: 1200.w,
          ),
          // Button to add a new department
          RoundedRectangleButton(
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
        ],
      ),
    );
  }

  Widget _buildDepartemenTable(List<DepartemenData> filteredData) {
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
      // Give the table some vertical room; or wrap it in Expanded/Flexible
      child: SizedBox(
        height: 700.h,
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.orange[500]),
              headingTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              border: TableBorder.all(color: Colors.grey, width: 1),
              columns: const [
                DataColumn(label: Text('Departemen')),
                DataColumn(label: Text('Max Kuota')),
                DataColumn(label: Text('Jumlah Pengajuan')),
                DataColumn(label: Text('Jumlah Approved')),
                DataColumn(label: Text('Jumlah On Boarding')),
                DataColumn(label: Text('Sisa Kuota')),
                DataColumn(label: Text('Action')),
              ],
              rows: filteredData
                  .map((d) => DataRow(cells: [
                        DataCell(Text(d.namaDepartemen,
                            textAlign: TextAlign.center)),
                        DataCell(
                            Text('${d.maxKuota}', textAlign: TextAlign.center)),
                        DataCell(Text('${d.jumlahPengajuan}',
                            textAlign: TextAlign.center)),
                        DataCell(Text('${d.jumlahApproved}',
                            textAlign: TextAlign.center)),
                        DataCell(Text('${d.jumlahOnBoarding}',
                            textAlign: TextAlign.center)),
                        DataCell(Text('${d.sisaKuota}',
                            textAlign: TextAlign.center)),
                        DataCell(Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedRectangleButton(
                              title: 'EDIT',
                              backgroundColor: lightOrange,
                              height: 30,
                              width: 85,
                              rounded: 5,
                              onPressed: () => _editMaxKuota(d),
                            ),
                            const SizedBox(width: 8),
                            RoundedRectangleButton(
                              title: 'VIEW',
                              backgroundColor: lightBlue,
                              height: 30,
                              width: 85,
                              rounded: 5,
                              onPressed: () =>
                                  _onViewApplications(d.namaDepartemen),
                            ),
                          ],
                        )),
                      ]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _addNewDepartment() {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return CustomAlertDialog(
    //       title: "Tambah Departemen",
    //       controllers: [],
    //     );
    //   },
    // );
  }

  void _editMaxKuota(DepartemenData department) {
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
