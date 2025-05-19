import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';

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
  String namaPembimbing = "";
  List<LogbookPesertaMagangData> logbookData = [];

  @override
  void initState() {
    super.initState();
    final loginState = ref.read(loginProvider);
    nama = loginState.name!;
    email = loginState.email!;
    departement = loginState.departemen!;
    fetchLogbooks(); // Fetch logbooks on initialization
    getNamaPembimbing();
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
            _buildNamaPembimbing(),
            // Logbook Table
            _buildLogbookTable(filteredLogData),
          ],
        ),
      ),
    );
  }

  // New method to build the header
  Widget _buildNamaPembimbing() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(180, 0, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Pembimbing: $namaPembimbing', style: bold28),
            ],
          ),
        ],
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
                    DataCell(
                      Text(
                        data.validasiPembimbing == 'true'
                            ? 'Disetujui'
                            : (data.validasiPembimbing == 'false'
                                ? 'Ditolak'
                                : 'Menunggu'),
                        style: TextStyle(
                          color: data.validasiPembimbing == 'true'
                              ? Colors.green
                              : (data.validasiPembimbing == 'false'
                                  ? Colors.red
                                  : Colors.black),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(Text(data.catatanPembimbing ?? '')),
                    DataCell(
                      RoundedRectangleButton(
                          title: 'EDIT',
                          backgroundColor: lightBlue,
                          height: 30,
                          width: 85,
                          rounded: 5,
                          onPressed: () => _showEditLogbookModal(data)),
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
        return CustomAlertDialog(
          title: 'Tambah Log Book',
          subTitle: 'Isi Formulir Berikut',
          controllers: [activityController, dateController, urlController],
          labels: const ['Aktivitas', 'Tanggal Aktivitas', 'URL Lampiran'],
          fieldTypes: const [
            BuildFieldTypeController.text,
            BuildFieldTypeController.date,
            BuildFieldTypeController.text,
          ],
          numberOfField: 3,
          onSave: () {
            addNewLogbook(
              activityName: activityController.text,
              tanggalActivity: dateController.text,
              url: urlController.text,
            );
            Navigator.of(ctx).pop();
          },
        );
      },
    );
  }

  void _showEditLogbookModal(LogbookPesertaMagangData existingLogbook) {
    final TextEditingController activityController =
        TextEditingController(text: existingLogbook.namaAktivitas);
    final TextEditingController dateController =
        TextEditingController(text: existingLogbook.tanggalAktivitas);
    final TextEditingController urlController =
        TextEditingController(text: existingLogbook.urlLampiran);

    showDialog(
      context: context,
      builder: (ctx) {
        return CustomAlertDialog(
          title: 'Edit Log Book',
          subTitle: 'Update Formulir Berikut',
          controllers: [activityController, dateController, urlController],
          labels: const ['Aktivitas', 'Tanggal Aktivitas', 'URL Lampiran'],
          fieldTypes: const [
            BuildFieldTypeController.text,
            BuildFieldTypeController.date,
            BuildFieldTypeController.text,
          ],
          numberOfField: 3,
          onSave: () {
            updateLogbook(
              idLogbook:
                  existingLogbook.idLogbook, // Pass the existing logbook ID
              activityName: activityController.text,
              tanggalActivity: dateController.text,
              url: urlController.text,
            );
            Navigator.of(ctx).pop();
          },
        );
      },
    );
  }

  Future<void> updateLogbook({
    required String idLogbook,
    required String activityName,
    required String tanggalActivity,
    required String url,
  }) async {
    try {
      // Create the updated logbook entry
      final updatedLogbook = LogbookPesertaMagangData(
        idLogbook: idLogbook,
        namaPeserta: nama,
        email: email,
        departemen: departement,
        namaAktivitas: activityName,
        tanggalAktivitas: tanggalActivity,
        urlLampiran: url,
      );

      await ApiService().updateLogbook(
          updatedLogbook); // Ensure you implement this method in your API service
      await fetchLogbooks(); // Refresh the list after updating
    } catch (e) {
      print('Error updating logbook: $e');
    }
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

  Future<void> getNamaPembimbing() async {
    try {
      final namaPembimbingFetched =
          await ApiService().fetchPembimbingByEmail(email);
      setState(() {
        namaPembimbing = namaPembimbingFetched!; // Store fetched data
      });
      print('Fetched nama pembimbing : $namaPembimbingFetched');
    } catch (e) {
      print('Error fetching nama pembimbing : $e'); // Log errors
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
