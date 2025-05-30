import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:url_launcher/url_launcher.dart';

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
            const SizedBox(height: 24),
            // Logbook Table
            isTableLogbook
                ? _buildLogbookTable(filteredLogData) // Display logbook table
                : _buildLaporanAkhirTable(), // Display final report table
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

  Widget _buildLaporanAkhirTable() {
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
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text('1')),
                    DataCell(Text(peserta.nama)),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          // 'laporanAkhir' is the URL for the final report
                          if (peserta.urlLaporanAkhir != null) {
                            _launchURL(peserta.urlLaporanAkhir!);
                          }
                        },
                        child: Text(
                          peserta.urlLaporanAkhir ??
                              "Masih belum ada laporan akhir",
                          style: TextStyle(
                            color: peserta.urlLaporanAkhir != null
                                ? Colors.blue
                                : Colors.grey,
                            decoration: peserta.urlLaporanAkhir != null
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      RoundedRectangleButton(
                          title: "Validasi",
                          backgroundColor: lightBlue,
                          fontColor: Colors.black,
                          style: regular14,
                          height: 40.h,
                          width: 150.w,
                          rounded: 5,
                          onPressed: () {
                            // TODO: Validasi
                          }),
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

  // Launch URL function
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
