import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';

class DashboardLogbookPeserta extends ConsumerStatefulWidget {
  const DashboardLogbookPeserta({super.key, required this.email});
  final String email;

  @override
  _DashboardLogbookPesertaState createState() =>
      _DashboardLogbookPesertaState();
}

class _DashboardLogbookPesertaState
    extends ConsumerState<DashboardLogbookPeserta> {
  String searchQuery = "";
  List<LogbookPesertaMagangData> logbookData = [];
  late bool isAdmin;

  @override
  void initState() {
    super.initState();
    fetchLogbooks();
    final login = ref.read(loginProvider);
    if (login.role == roleAdminValue) {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter logbook data based on search query
    final filteredLogData = logbookData.where((data) {
      return data.namaAktivitas
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: 'Log Book Mahasiswa',
        showBackButton: true,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Add Search Bar
            _buildSearchBar(),
            const SizedBox(height: 24),
            // Logbook Table
            _buildLogbookTable(filteredLogData),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Center(
      child: CustomSearchBar(
        widthValue: 1500.w,
        onChanged: (value) {
          setState(() {
            searchQuery = value; // Update search query
          });
        },
      ),
    );
  }

  Widget _buildLogbookTable(List<LogbookPesertaMagangData> filteredLogData) {
    return Expanded(
      child: filteredLogData.isEmpty
          ? buildEmptyDataMessage(dataName: "Logbook Peserta")
          : SingleChildScrollView(
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
                      headingRowColor:
                          const WidgetStatePropertyAll(Colors.orange),
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      border: TableBorder.all(color: Colors.grey, width: 1),
                      columns: [
                        const DataColumn(label: Text('No')),
                        const DataColumn(label: Text('Nama Peserta')),
                        const DataColumn(label: Text('Aktivitas')),
                        const DataColumn(label: Text('Tanggal Aktivitas')),
                        const DataColumn(label: Text('URL Lampiran')),
                        const DataColumn(label: Text('Validasi')),
                        const DataColumn(label: Text('Catatan')),
                        // Not admin = kepala
                        if (!isAdmin) const DataColumn(label: Text('Aksi')),
                      ],
                      rows:
                          filteredLogData.asMap().entries.map<DataRow>((entry) {
                        // index of entry list
                        int index = entry.key;
                        // logbook data
                        LogbookPesertaMagangData data = entry.value;
                        return DataRow(cells: [
                          DataCell(Text('${filteredLogData.length - index}')),
                          DataCell(Text(data.namaPeserta)),
                          DataCell(Text(data.namaAktivitas)),
                          DataCell(Text(data.tanggalAktivitas)),
                          DataCell(Text(data.urlLampiran)),
                          DataCell(
                            Text(
                              getValidationStatus(data.validasiPembimbing),
                              style: TextStyle(
                                color:
                                    getValidationColor(data.validasiPembimbing),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(Text(data.catatanPembimbing ?? "")),
                          // Not admin = kepala
                          if (!isAdmin)
                            DataCell(
                              Center(
                                // Center the button in the action column
                                child: Row(
                                  children: [
                                    RoundedRectangleButton(
                                      title: 'VALIDASI',
                                      style: regular16,
                                      backgroundColor: lightBlue,
                                      height: 30,
                                      width: 110,
                                      rounded: 5,
                                      onPressed: () {
                                        showValidationConfirmation(
                                            data.idLogbook);
                                      },
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    RoundedRectangleButton(
                                      title: 'CATATAN',
                                      style: regular16,
                                      backgroundColor: lightOrange,
                                      height: 30,
                                      width: 110,
                                      rounded: 5,
                                      onPressed: () {
                                        addCatatan(data.idLogbook);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  void showValidationConfirmation(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRespondDialog(
          title: "Validasi Logbook?",
          onAccept: () async {
            await updateValidation(id, true);
            Navigator.pop(context);
          },
          onReject: () async {
            await updateValidation(id, false);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void addCatatan(String idLogbook) async {
    await showCustomConfirmAcceptDialogWithNote(
      context: context,
      title: "CATATAN PEMBIMBING",
      message: "Berikan catatan",
      withNote: true,
      acceptText: "Kirim",
      onAccept: (note) async {
        await updateCatatan(idLogbook, note!);
      },
      onCancel: () {},
    );
  }

  Future<void> updateCatatan(String idLogbook, String catatan) async {
    try {
      await ApiService()
          .logbookService
          .updateCatatanPembimbing(idLogbook, catatan);
      // Optionally, refresh the data or show a success message
      fetchLogbooks();
    } catch (error) {
      print('Failed to update validation: $error');
    }
  }

  Future<void> updateValidation(String idLogbook, bool validasiValue) async {
    bool newValidationStatus = validasiValue;
    try {
      await ApiService()
          .logbookService
          .updateLogbookValidation(idLogbook, newValidationStatus);
      // Optionally, refresh the data or show a success message
      fetchLogbooks();
    } catch (error) {
      print(
          'Failed to update validation: $error'); // Handle error appropriately
    }
  }

  Future<void> fetchLogbooks() async {
    try {
      final logbooks =
          await ApiService().logbookService.fetchLogbookByEmail(widget.email);
      setState(() {
        logbookData = logbooks; // Store fetched data
      });
      print('Fetched logbooks: $logbooks'); // Log fetched data
    } catch (e) {
      print('Error fetching logbooks: $e'); // Log errors
    }
  }
}
