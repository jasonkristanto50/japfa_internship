import 'dart:io';
import 'dart:html' as html; // uncomment if ran in chrome
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/admin_page/pendaftaran_magang_detail_page.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/models/skill_peserta_magang_data/skill_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:path_provider/path_provider.dart';

class ListAllPesertaMagang extends StatefulWidget {
  const ListAllPesertaMagang({super.key});

  @override
  State<ListAllPesertaMagang> createState() => _ListAllPesertaMagangState();
}

class _ListAllPesertaMagangState extends State<ListAllPesertaMagang> {
  String searchQuery = "";
  List<PesertaMagangData> pesertaMagangList = [];
  List<PesertaMagangData> filteredPesertaData = [];
  String? currentStatus;

  @override
  void initState() {
    super.initState();
    _fetchPesertaMagangData();
  }

  @override
  Widget build(BuildContext context) {
    _updateFilteredPesertaData();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
        titleOnPressed: () {},
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            _buildSearchAndDownloadExcel(),
            _buildGroupByStatusButton(),
            _buildPesertaMagangDataTable(filteredPesertaData),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Build search bar and recommendation button
  Widget _buildSearchAndDownloadExcel() {
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
          RoundedRectangleButton(
            title: "Rekomendasi",
            backgroundColor: Colors.white,
            outlineColor: japfaOrange,
            height: 40,
            width: 150,
            rounded: 5,
            onPressed: () {
              _sortPesertaByDepartmentAndFuzzyScore();
            },
          ),
          const SizedBox(width: 15),
          RoundedRectangleButton(
            title: "Download Data",
            backgroundColor: Colors.white,
            outlineColor: Colors.green,
            height: 40,
            width: 150,
            rounded: 5,
            onPressed: () {
              _downloadExcel();
            },
          ),
        ],
      ),
    );
  }

  // Build buttons to filter by status
  Widget _buildGroupByStatusButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Button for "Semua"
          RoundedRectangleButton(
            title: "Semua",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: currentStatus == null ? japfaOrange : Colors.white,
            backgroundColor: currentStatus == null ? Colors.white : Colors.grey,
            outlineColor:
                currentStatus == null ? japfaOrange : Colors.transparent,
            onPressed: () {
              _filterByStatus(null); // Clear filter
            },
          ),
          const SizedBox(width: 10),
          // Button for "On Process"
          RoundedRectangleButton(
            title: "Proses",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusMagangMenunggu
                ? japfaOrange
                : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangMenunggu); // Filter by "On Process"
            },
          ),
          const SizedBox(width: 10),
          // Button for "Diterima"
          RoundedRectangleButton(
            title: statusMagangDiterima, // Assuming this variable is defined
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusMagangDiterima
                ? Colors.green
                : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangDiterima); // Filter by "Accepted"
            },
          ),
          const SizedBox(width: 10),
          // Button for "Sedang Berlangsung"
          RoundedRectangleButton(
            title: "Berlangsung",
            style: bold14,
            width: 150.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusMagangBerlangsung
                ? Colors.blue
                : Colors.grey,
            onPressed: () {
              _filterByStatus(
                  statusMagangBerlangsung); // Filter by "Sedang Berlangsung"
            },
          ),
          const SizedBox(width: 10),
          // Button for "Selesai"
          RoundedRectangleButton(
            title: "Selesai",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor:
                currentStatus == statusMagangSelesai ? darkGrey : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangSelesai); // Filter by "Finished"
            },
          ),
          const SizedBox(width: 10),
          // Button for "Ditolak"
          RoundedRectangleButton(
            title: statusMagangDitolak, // Assuming this variable is defined
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor:
                currentStatus == statusMagangDitolak ? Colors.red : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangDitolak); // Filter by "Rejected"
            },
          ),
          const SizedBox(width: 10),
          // Button for "Tidak Lanjut"
          RoundedRectangleButton(
            title: "Tidak Lanjut",
            style: bold14,
            width: 150.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusMagangTidakLanjut
                ? darkGrey
                : Colors.grey,
            onPressed: () {
              _filterByStatus(
                  statusMagangTidakLanjut); // Filter by "Not Continued"
            },
          ),
        ],
      ),
    );
  }

  // Build the data table
  Widget _buildPesertaMagangDataTable(List<PesertaMagangData> filteredData) {
    return filteredData.isEmpty
        ? buildEmptyDataMessage(
            dataName: "Pendaftar Magang Status $currentStatus",
            padding: const EdgeInsets.only(top: 100, bottom: 0),
          )
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
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor:
                        WidgetStateProperty.all(Colors.orange[500]),
                    headingTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    border: TableBorder.all(color: Colors.grey, width: 1),
                    columns: const [
                      DataColumn(label: Text('Nama')),
                      DataColumn(label: Text('No. Telp')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Universitas')),
                      DataColumn(label: Text('Jurusan')),
                      DataColumn(label: Text('Departemen')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Aksi')),
                    ],
                    rows: filteredData.map((peserta) {
                      return DataRow(
                        cells: [
                          DataCell(
                              Text(peserta.nama, textAlign: TextAlign.center)),
                          DataCell(Text(peserta.noTelp,
                              textAlign: TextAlign.center)),
                          DataCell(
                              Text(peserta.email, textAlign: TextAlign.center)),
                          DataCell(Text(peserta.asalUniversitas,
                              textAlign: TextAlign.center)),
                          DataCell(Text(peserta.jurusan,
                              textAlign: TextAlign.center)),
                          DataCell(Text(peserta.departemen ?? "-")),
                          DataCell(
                            Text(
                              peserta.statusMagang,
                              style: TextStyle(
                                color:
                                    getStatusMagangColor(peserta.statusMagang),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: RoundedRectangleButton(
                                title: "DETAIL",
                                backgroundColor:
                                    const Color.fromARGB(255, 152, 209, 255),
                                height: 30,
                                width: 100,
                                rounded: 5,
                                onPressed: () {
                                  _viewDetails(peserta);
                                },
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

  Future<void> _fetchPesertaMagangData() async {
    try {
      List<PesertaMagangData> data =
          await ApiService().pesertaMagangService.fetchPesertaMagangData();
      setState(() {
        pesertaMagangList = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Method to update the filtered data based on search query and status
  void _updateFilteredPesertaData() {
    setState(() {
      filteredPesertaData = pesertaMagangList.where((peserta) {
        bool matchesSearchQuery =
            peserta.nama.toLowerCase().contains(searchQuery.toLowerCase());

        // If a status is selected, check for that status
        if (currentStatus != null) {
          return matchesSearchQuery && peserta.statusMagang == currentStatus;
        }

        return matchesSearchQuery;
      }).toList();
    });
  }

  void _filterByStatus(String? status) {
    setState(() {
      currentStatus = status;
      _updateFilteredPesertaData();
    });
  }

  void _viewDetails(PesertaMagangData peserta) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PendaftaranMagangDetailPage(
          peserta: peserta,
          onUpdate: _fetchPesertaMagangData,
        ),
      ),
    );
  }

  void _sortPesertaByDepartmentAndFuzzyScore() async {
    try {
      // Fetch the skill data for fuzzy scores
      List<SkillPesertaMagangData> skillDataList =
          await ApiService().skillService.fetchAllSkills();

      // Create a map to correlate email to fuzzy scores
      Map<String, double> emailToFuzzyScoreMap = {
        for (var skill in skillDataList) skill.email: skill.fuzzyScore,
      };

      // Sort by department and then by fuzzy score
      pesertaMagangList.sort((a, b) {
        // First sort by department (ascending order)
        final departmentComparison =
            a.departemen?.compareTo(b.departemen ?? "") ?? -1;

        // If departments are equal, sort by fuzzy score
        if (departmentComparison == 0) {
          final scoreA = emailToFuzzyScoreMap[a.email] ?? 0;
          final scoreB = emailToFuzzyScoreMap[b.email] ?? 0;
          return scoreB
              .compareTo(scoreA); // Sort by fuzzy score (descending order)
        }

        return departmentComparison; // Order departments
      });

      // Set the state to refresh UI
      setState(() {
        // Refresh the display with the sorted list
        pesertaMagangList = pesertaMagangList;
      });

      // Show a confirmation message
      showSnackBar(context,
          "Data telah diurutkan berdasarkan departemen dan skor fuzzy.",
          backgroundColor: Colors.grey);
    } catch (e) {
      print('Error sorting data: $e');
    }
  }

  // Method to download Excel
  void _downloadExcel() async {
    try {
      // Create an Excel document
      var excel = Excel.createExcel();
      Sheet sheet = excel['Data Peserta Magang'];

      // Column name
      sheet.appendRow([
        TextCellValue('Nama'),
        TextCellValue('No. Telp'),
        TextCellValue('Email'),
        TextCellValue('Universitas'),
        TextCellValue('Jurusan'),
        TextCellValue('Departemen'),
        TextCellValue('Status'),
        TextCellValue('Angkatan'),
        TextCellValue('Alamat'),
        TextCellValue('Nilai'),
        TextCellValue('Catatan HR'),
        TextCellValue('Pembimbing'),
        TextCellValue('Nilai Akhir Magang'),
      ]);

      // Data value
      for (var peserta in pesertaMagangList) {
        sheet.appendRow([
          TextCellValue(peserta.nama),
          TextCellValue(peserta.noTelp),
          TextCellValue(peserta.email),
          TextCellValue(peserta.asalUniversitas),
          TextCellValue(peserta.jurusan),
          TextCellValue(peserta.departemen ?? "-"),
          TextCellValue(peserta.statusMagang),
          TextCellValue(peserta.angkatan.toString()),
          TextCellValue(peserta.alamat),
          TextCellValue(peserta.nilaiUniv.toString()),
          TextCellValue(peserta.catatanHr ?? "-"),
          TextCellValue(peserta.namaPembimbing ?? "-"),
          TextCellValue(peserta.nilaiAkhirMagang?.toString() ?? "-"),
        ]);
      }

      // Download if using web
      if (kIsWeb) {
        final bytes = excel.encode()!;
        final blob = html.Blob([
          bytes
        ], 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');

        // Create a link element
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.AnchorElement(href: url)
          ..setAttribute('download', 'peserta_magang.xlsx')
          ..click();

        html.Url.revokeObjectUrl(url);
        showSnackBar(context, "Excel file downloaded.",
            backgroundColor: Colors.green);
      } else {
        // For mobile platforms, you can directly save it
        Directory? directory = await getExternalStorageDirectory();
        String filePath = '${directory!.path}/peserta_magang.xlsx';

        // Save the Excel file
        File(filePath).writeAsBytesSync(excel.encode()!);
        showSnackBar(context, "Excel file downloaded: $filePath",
            backgroundColor: Colors.green);
      }
    } catch (e) {
      showSnackBar(context, "Error during download: $e",
          backgroundColor: Colors.red);
    }
  }
}
