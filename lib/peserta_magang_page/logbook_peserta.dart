import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:intl/intl.dart'; // For date formatting

class LogBookPesertaDashboard extends ConsumerStatefulWidget {
  const LogBookPesertaDashboard({super.key});

  @override
  _LogBookPesertaDashboardState createState() =>
      _LogBookPesertaDashboardState();
}

class _LogBookPesertaDashboardState
    extends ConsumerState<LogBookPesertaDashboard> {
  String searchQuery = "";
  String nama = "";
  String email = "";
  String departement = "";
  List<LogbookPesertaMagangData> logbookData = [];

  @override
  void initState() {
    super.initState();
    final loginState = ref.read(loginProvider);
    nama = loginState.name!;
    email = loginState.email!;
    departement = loginState.departemen!;
    fetchLogbooks(); // Fetch logbooks on initialization
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
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Add Search Bar and Add Button
            _buildSearchAndAddLogBookButton(),
            const SizedBox(height: 24),
            // Logbook Table
            _buildLogbookTable(filteredLogData),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndAddLogBookButton() {
    return Center(
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
          const SizedBox(width: 16),
          // Button to add a new logbook
          RoundedRectangleButton(
            title: "Tambah Log Book",
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            height: 40,
            width: 200,
            rounded: 5,
            onPressed: () {
              _showAddLogBookModal();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogbookTable(filteredLogData) {
    return Expanded(
      child: SingleChildScrollView(
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
                border: TableBorder.all(color: Colors.grey, width: 1),
                columns: const [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Aktivitas')),
                  DataColumn(label: Text('Tanggal Aktivitas')),
                  DataColumn(label: Text('URL Lampiran')),
                  DataColumn(label: Text('Validasi Pembimbing')),
                  DataColumn(label: Text('Catatan Pembimbing')),
                  DataColumn(label: Text('Action')),
                ],
                rows: filteredLogData
                    .map<DataRow>((LogbookPesertaMagangData data) {
                  return DataRow(cells: [
                    DataCell(Text(data.idLogbook)),
                    DataCell(Text(data.namaAktivitas)),
                    DataCell(Text(data.tanggalAktivitas)),
                    DataCell(Text(data.urlLampiran)),
                    DataCell(Text(data.validasiPembimbing ?? 'N/A')),
                    DataCell(Text(data.catatanPembimbing ?? 'N/A')),
                    DataCell(
                      RoundedRectangleButton(
                          title: 'EDIT',
                          backgroundColor: lightBlue,
                          height: 30,
                          width: 85,
                          rounded: 5,
                          onPressed: () {}),
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

  void _showAddLogBookModal() {
    final TextEditingController activityController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Tambah Log Book'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: activityController,
                  decoration: const InputDecoration(
                    labelText: 'Aktivitas',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dateController,
                  readOnly: true, // Makes the TextField non-editable
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Aktivitas',
                    border: OutlineInputBorder(),
                    suffixIcon:
                        Icon(Icons.calendar_today), // Show calendar icon
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('dd-MM-yyyy').format(picked);
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'URL Lampiran',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                addNewLogbook(
                  activityName: activityController.text,
                  tanggalActivity: dateController.text,
                  url: urlController.text,
                );
                Navigator.of(ctx).pop();
              },
              child:
                  const Text('SIMPAN', style: TextStyle(color: Colors.orange)),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchLogbooks() async {
    try {
      final logbooks = await ApiService().fetchLogbookByEmail(email);
      setState(() {
        logbookData = logbooks; // Store fetched data
      });
      print('Fetched logbooks: $logbooks'); // Log fetched data
    } catch (e) {
      print('Error fetching logbooks: $e'); // Log errors
    }
  }

  Future<void> addNewLogbook({
    required String activityName,
    required String tanggalActivity,
    required String url,
  }) async {
    try {
      final logbookCount = await ApiService().countLogbooks();
      String newIdLogbook =
          'LG_${(logbookCount != null ? logbookCount + 1 : 1).toString().padLeft(3, '0')}';

      // Create a new logbook entry
      final newLogbook = LogbookPesertaMagangData(
        idLogbook: newIdLogbook,
        namaPeserta: nama,
        email: email,
        departemen: departement,
        namaAktivitas: activityName,
        tanggalAktivitas: tanggalActivity,
        urlLampiran: url,
      );

      await ApiService().addLogbook(newLogbook);
      await fetchLogbooks();
    } catch (e) {
      print('Error adding logbook: $e');
    }
  }
}
