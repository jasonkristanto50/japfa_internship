import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
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
  bool isMobile = false;

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
    // Check if the current device is mobile
    isMobile = MediaQuery.of(context).size.width < 600;

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
            // Display the Pembimbing name
            _buildNamaPembimbing(),
            // Logbook Table
            _buildLogbookTable(filteredLogData),
          ],
        ),
      ),
    );
  }

  Widget _buildNamaPembimbing() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile == true ? 30 : 180,
        0,
        15,
        15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Pembimbing: $namaPembimbing',
                style: isMobile == true ? bold12 : bold28,
              ),
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
            labelSearchBar: "Cari",
            widthValue: isMobile ? 200.w : 1200.w, // Adjust width for mobile
          ),
          const SizedBox(width: 16),
          // Button to add a new logbook
          RoundedRectangleButton(
            title: isMobile ? "Tambah" : "Tambah Log Book", // Conditional title
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            height: 40,
            width: isMobile ? 100 : 200, // Adjust width for mobile
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
                  child: filteredLogData.isEmpty
                      ? buildEmptyDataMessage(filteredData: filteredLogData)
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor:
                                WidgetStateProperty.all(Colors.orange[500]),
                            headingTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            border:
                                TableBorder.all(color: Colors.grey, width: 1),
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
                                .asMap()
                                .entries
                                .map<DataRow>((entry) {
                              // index of entry list
                              int index = entry.key;
                              // logbook data
                              LogbookPesertaMagangData data = entry.value;
                              return DataRow(cells: [
                                DataCell(
                                    Text('${filteredLogData.length - index}')),
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
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.edit,
                                            color: japfaOrange),
                                        onPressed: () =>
                                            _showEditLogbookModal(data),
                                        tooltip: 'Edit',
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () =>
                                            _deleteLogbookById(data.idLogbook),
                                        tooltip: 'Hapus',
                                      ),
                                    ],
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

      await ApiService().logbookService.updateLogbook(
          updatedLogbook); // Ensure you implement this method in your API service
      await fetchLogbooks(); // Refresh the list after updating
    } catch (e) {
      print('Error updating logbook: $e');
    }
  }

  Future<void> fetchLogbooks() async {
    try {
      final logbooks =
          await ApiService().logbookService.fetchLogbookByEmail(email);

      // Sort logbooks by date in descending order
      logbooks.sort((a, b) {
        DateTime dateA = DateFormat('dd-MM-yyyy').parse(a.tanggalAktivitas);
        DateTime dateB = DateFormat('dd-MM-yyyy').parse(b.tanggalAktivitas);
        return dateB.compareTo(dateA); // Descending order
      });

      setState(() {
        logbookData = logbooks; // Store fetched and sorted data
      });
      print('Fetched logbooks: $logbooks'); // Log fetched data
    } catch (e) {
      print('Error fetching logbooks: $e'); // Log errors
    }
  }

  Future<void> getNamaPembimbing() async {
    try {
      final namaPembimbingFetched =
          await ApiService().pesertaMagangService.fetchPembimbingByEmail(email);
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
      String newIdLogbook = 'LG_${DateTime.now().millisecondsSinceEpoch}';

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

      await ApiService().logbookService.addLogbook(newLogbook);
      await fetchLogbooks();
    } catch (e) {
      print('Error adding logbook: $e');
    }
  }

  Future<void> _deleteLogbookById(String idLogbook) async {
    try {
      // Call the delete logbook method from your API service
      await ApiService().logbookService.deleteLogbook(idLogbook);

      // Refresh the logbooks after deletion
      await fetchLogbooks();
      print('Logbook deleted successfully!');
    } catch (e) {
      print('Error deleting logbook: $e');
    }
  }
}
