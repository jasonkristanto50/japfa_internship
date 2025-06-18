import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
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
  bool isTableLogbook = true;
  late PesertaMagangData peserta;

  @override
  void initState() {
    super.initState();
    fetchLogbooks();
    _fetchPesertaData();
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
            _buildLogbookOrLaporanTable(),
            // Logbook Table
            isTableLogbook
                ? _buildLogbookTable(filteredLogData)
                : _buildLaporanAkhirTable(),
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

  // Build buttons to switch logbook or laporan
  Widget _buildLogbookOrLaporanTable() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Button for "Logbook Harian"
          RoundedRectangleButton(
            title: "Logbook Harian",
            style: bold14,
            width: 200.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: isTableLogbook ? japfaOrange : Colors.grey,
            onPressed: () {
              setState(() {
                isTableLogbook = true;
              });
            },
          ),
          const SizedBox(width: 10),
          // Button for "Laporan Akhir"
          RoundedRectangleButton(
            title: "Laporan Akhir",
            style: bold14,
            width: 200.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor:
                isTableLogbook == false ? japfaOrange : Colors.grey,
            onPressed: () {
              setState(() {
                isTableLogbook = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogbookTable(List<LogbookPesertaMagangData> filteredLogData) {
    return Expanded(
      child: filteredLogData.isEmpty
          ? buildEmptyDataMessage(dataName: "Logbook Peserta")
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 700.h, // Set the maximum height
                  ),
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
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor:
                            const WidgetStatePropertyAll(Colors.orange),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        dataRowMinHeight: 120,
                        dataRowMaxHeight: 150,
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
                        rows: filteredLogData
                            .asMap()
                            .entries
                            .map<DataRow>((entry) {
                          // index of entry list
                          int index = entry.key;
                          // logbook data
                          LogbookPesertaMagangData data = entry.value;
                          return DataRow(cells: [
                            DataCell(Text('${filteredLogData.length - index}')),
                            DataCell(Text(data.namaPeserta)),
                            DataCell(Text(data.namaAktivitas)),
                            DataCell(Text(data.tanggalAktivitas)),
                            DataCell(showFoto(data)),
                            DataCell(
                              Text(
                                getValidationStatus(data.validasiPembimbing),
                                style: TextStyle(
                                  color: getValidationColor(
                                      data.validasiPembimbing),
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
                                            isLogbook: true,
                                            id: data.idLogbook,
                                          );
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
            ),
    );
  }

  Widget _buildLaporanAkhirTable() {
    String pathLaporanAkhir = peserta.pathLaporanAkhir ?? '';
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
                headingRowColor: const WidgetStatePropertyAll(Colors.orange),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                border: TableBorder.all(color: Colors.grey, width: 1),
                columns: const [
                  DataColumn(label: Text('No')),
                  DataColumn(label: Text('Nama Peserta')),
                  DataColumn(label: Text('Laporan')),
                  DataColumn(label: Text('Validasi')),
                  DataColumn(label: Text('Aksi')),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text('1')),
                    DataCell(Text(peserta.nama)),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          if (pathLaporanAkhir.isNotEmpty) {
                            launchURLImagePath(pathLaporanAkhir);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              getFileIcon(pathLaporanAkhir),
                              color: pathLaporanAkhir.isNotEmpty
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                            const SizedBox(
                                width: 8), // Space between icon and text
                            Text(
                              getOriginalFileNameFromPath(pathLaporanAkhir),
                              style: TextStyle(
                                color: pathLaporanAkhir.isNotEmpty
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(Text(
                      peserta.validasiLaporanAkhir ?? 'Belum ada Validasi',
                      style: bold16.copyWith(
                        color: getStatusValidasiColor(
                            peserta.validasiLaporanAkhir ?? ''),
                      ),
                    )),
                    DataCell(
                      RoundedRectangleButton(
                        title: 'VALIDASI',
                        backgroundColor: lightBlue,
                        fontColor: darkGrey,
                        style: bold16,
                        width: 120,
                        height: 30,
                        rounded: 5,
                        onPressed: () => showValidationConfirmation(
                            isLogbook: false, id: ''),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showFoto(LogbookPesertaMagangData logbook) {
    final img = '$baseUrl${logbook.urlLampiran}';
    return Image.network(
      img,
      height: 120,
      width: 90,
      fit: BoxFit.cover,
      loadingBuilder: (c, child, p) =>
          p == null ? child : const CircularProgressIndicator(),
      errorBuilder: (c, _, __) => const Text('Failed to load image'),
    );
  }

  void showValidationConfirmation({
    required bool isLogbook,
    required String id,
  }) {
    isLogbook
        ?
        // Logbook
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomRespondDialog(
                title: "Validasi Logbook?",
                onAccept: () async {
                  await updateValidationLogbook(id, true);
                  Navigator.pop(context);
                },
                onReject: () async {
                  await updateValidationLogbook(id, false);
                  Navigator.pop(context);
                },
              );
            },
          )
        :
        // Laporan Akhir
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomRespondDialog(
                title: "Validasi Laporan?",
                onAccept: () async {
                  await updateValidationLaporanAkhir(
                      peserta.idMagang, statusValidasiDiterima);
                  Navigator.pop(context);
                },
                onReject: () async {
                  await updateValidationLaporanAkhir(
                      peserta.idMagang, statusValidasiDitolak);
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

  Future<void> updateValidationLogbook(
    String idLogbook,
    bool validasiValue,
  ) async {
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

  Future<void> updateValidationLaporanAkhir(
    String idMagang,
    String validationStatus,
  ) async {
    try {
      await ApiService()
          .pesertaMagangService
          .validasiLaporanAkhir(idMagang, validationStatus);

      _fetchPesertaData();
    } catch (error) {
      print('Failed to update validation for laporan akhir: $error');
    }
  }

  Future<void> fetchLogbooks() async {
    try {
      final logbooks =
          await ApiService().logbookService.fetchLogbookByEmail(widget.email);

      // Sort logbooks by date in descending order
      logbooks.sort((a, b) {
        DateTime dateA = DateFormat('dd-MM-yyyy').parse(a.tanggalAktivitas);
        DateTime dateB = DateFormat('dd-MM-yyyy').parse(b.tanggalAktivitas);
        return dateB.compareTo(dateA); // Descending order
      });

      setState(() {
        logbookData = logbooks; // Store fetched data
      });
      print('Fetched logbooks: $logbooks'); // Log fetched data
    } catch (e) {
      print('Error fetching logbooks: $e'); // Log errors
    }
  }

  Future<void> _fetchPesertaData() async {
    try {
      PesertaMagangData pesertaData = await ApiService()
          .pesertaMagangService
          .fetchPesertaMagangByEmail(widget.email);

      setState(() {
        peserta = pesertaData;
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }
}
