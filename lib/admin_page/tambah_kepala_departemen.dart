import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/kepala_departemen_page/dashboard_pembimbing_magang.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/models/kepala_departemen_data/kepala_departemen_data.dart';
import 'package:japfa_internship/navbar.dart';

class TambahKepalaDepartemen extends StatefulWidget {
  const TambahKepalaDepartemen({super.key});

  @override
  State<TambahKepalaDepartemen> createState() => _TambahKepalaDepartemenState();
}

class _TambahKepalaDepartemenState extends State<TambahKepalaDepartemen> {
  String searchQuery = "";
  List<KepalaDepartemenData> kepalaDepartemenList = [];
  TextEditingController namaKepalaDepartemenController =
      TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaDepartemenController = TextEditingController();
  TextEditingController passwordTokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchKepalaDept();
  }

  @override
  Widget build(BuildContext context) {
    // Filter kepala_departemen based on search query
    List<KepalaDepartemenData> filteredDepartemenData = kepalaDepartemenList
        .where((kepala) =>
            kepala.nama.toLowerCase().contains(searchQuery.toLowerCase()))
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
            // Search bar
            _buildSearchAndAddButton(),
            // Table Section
            _buildKepalaDepartemenTable(filteredDepartemenData),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndAddButton() {
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
          // Button to add a new kepala departmen
          RoundedRectangleButton(
            title: "Tambah Kepala Dept",
            backgroundColor: Colors.white,
            outlineColor: japfaOrange,
            height: 40,
            width: 200,
            rounded: 5,
            onPressed: () {
              _showDialogAddKepalaDepartemen();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKepalaDepartemenTable(List<KepalaDepartemenData> filteredData) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Container(
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
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Departemen')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Aksi')),
              ],
              rows: filteredData.map((kepala) {
                return DataRow(
                  cells: [
                    DataCell(Text(kepala.idKepalaDepartemenData.toString())),
                    DataCell(Text(kepala.nama)),
                    DataCell(Text(kepala.email)),
                    DataCell(Text(kepala.departemen)),
                    DataCell(Text(kepala.role)),
                    DataCell(
                      Text(
                        kepala.status,
                        style: TextStyle(
                          color: kepala.status == statusPembimbingAktif
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                    DataCell(
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RoundedRectangleButton(
                              title: "LIST",
                              style: regular16,
                              backgroundColor: lightOrange,
                              height: 30,
                              width: 100,
                              rounded: 5,
                              onPressed: () {
                                fadeNavigation(
                                  context,
                                  targetNavigation: DashboardPembimbingMagang(
                                    kepalaDepartemen: kepala,
                                  ),
                                  time: 200,
                                );
                              },
                            ),
                            SizedBox(width: 8.w),
                            RoundedRectangleButton(
                              title: "STATUS",
                              style: regular16,
                              backgroundColor: lightBlue,
                              height: 30,
                              width: 100,
                              rounded: 5,
                              onPressed: () => _showStatusModal(kepala),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialogAddKepalaDepartemen() async {
    List<String> namaDepartemen = await fetchDepartemenNames();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Masukkan Data",
          subTitle: "Kepala Departemen",
          numberOfField: 4,
          controllers: [
            namaKepalaDepartemenController,
            emailController,
            namaDepartemenController,
            passwordTokenController
          ],
          labels: const [
            "Nama Kepala Departemen",
            "Email",
            "Nama Departemen",
            "Password Token"
          ],
          fieldTypes: const [
            BuildFieldTypeController.text,
            BuildFieldTypeController.text,
            BuildFieldTypeController.dropdown,
            BuildFieldTypeController.text
          ],
          dropdownOptions: namaDepartemen,
          onSave: () => _addKepalaDepartemen(),
        );
      },
    );
  }

  void _addKepalaDepartemen() async {
    try {
      final count = await ApiService()
          .kepalaDepartemenService
          .fetchKepalaDepartemenCount();
      final idKepalaDepartemen = 'KP_${count.toString().padLeft(2, '0')}';

      final kepalaDepartemen = KepalaDepartemenData(
        idKepalaDepartemenData: idKepalaDepartemen,
        nama: namaKepalaDepartemenController.text,
        email: emailController.text,
        departemen: namaDepartemenController.text,
        password: passwordTokenController.text,
        role: roleKepalaDeptValue,
        status: statusPembimbingAktif,
      );

      await ApiService()
          .kepalaDepartemenService
          .addKepalaDepartemen(kepalaDepartemen);
      // Optionally show success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Kepala Departemen added successfully!')));
      _fetchKepalaDept();
    } catch (error) {
      // Handle the error: show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  void _showStatusModal(KepalaDepartemenData kepala) async {
    await showCustomConfirmAcceptDialogWithNote(
      context: context,
      title: "Ubah Status",
      message: "Aktif / Tidak Aktif",
      withNote: false,
      acceptText: "Aktif",
      acceptColor: Colors.green,
      cancelText: "Tidak Aktif",
      cancelColor: Colors.red,
      // Aktif
      onAccept: (note) {
        _changeKepalaStatus(
            kepala.idKepalaDepartemenData, statusPembimbingAktif);
      },
      // Tidak Aktif
      onCancel: () {
        _changeKepalaStatus(
            kepala.idKepalaDepartemenData, statusPembimbingTidakAktif);
      },
    );
    setState(() {});
  }

  void _changeKepalaStatus(String id, String newStatus) async {
    try {
      await ApiService()
          .kepalaDepartemenService
          .updateKepalaDepartemenStatus(id, newStatus);

      // Optionally show success message
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Kepala Departemen status updated successfully!')));

      // Refresh the list after updating status
      _fetchKepalaDept();
    } catch (error) {
      // Handle the error: show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $error')));
    }
  }

  Future<void> _fetchKepalaDept() async {
    try {
      // Fetch all departments
      List<KepalaDepartemenData> fetchedKepalaDept =
          await ApiService().kepalaDepartemenService.fetchAllKepalaDepartemen();

      setState(() {
        kepalaDepartemenList = fetchedKepalaDept;
      });
    } catch (e) {
      print("Error fetching  kepala departemen: $e");
    }
  }

  Future<List<String>> fetchDepartemenNames() async {
    try {
      // Fetch all departemen data
      List<DepartemenData> departemenList =
          await ApiService().departemenService.fetchDepartemen();

      // Extract the names and return them as a list of strings
      return departemenList
          .map((departemen) => departemen.namaDepartemen)
          .toList();
    } catch (error) {
      print('Error fetching department names: $error');
      rethrow; // Rethrow the error for further handling if needed
    }
  }
}
