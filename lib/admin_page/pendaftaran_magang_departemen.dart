import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/admin_page/pendaftaran_magang_detail_page.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/models/skill_peserta_magang_data/skill_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class PendaftaranMagangDepartemen extends StatefulWidget {
  const PendaftaranMagangDepartemen({super.key, required this.departmentName});
  final String departmentName;

  @override
  State<PendaftaranMagangDepartemen> createState() =>
      _PendaftaranMagangDepartemenState();
}

class _PendaftaranMagangDepartemenState
    extends State<PendaftaranMagangDepartemen> {
  String searchQuery = "";
  List<PesertaMagangData> pesertaMagangList = [];
  List<PesertaMagangData> filteredPesertaData = [];
  String? currentStatus;
  bool isFuzzyRecomView = false;
  Map<String, double> emailToFuzzyScoreMap = {};

  @override
  void initState() {
    super.initState();
    _fetchPesertaMagangData();
  }

  @override
  Widget build(BuildContext context) {
    _updateFilteredPesertaData(); // Ensure filtered data is updated

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: '$appName - ${widget.departmentName}',
        titleOnPressed: () {},
        showBackButton: true,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            _buildSearchAndFuzzyRecommendationButton(),
            _buildGroupByStatusButton(),
            _buildPesertaMagangDataTable(filteredPesertaData),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Build search bar and recommendation button
  Widget _buildSearchAndFuzzyRecommendationButton() {
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
            title: isFuzzyRecomView ? "Kembali" : "Rekomendasi",
            backgroundColor: isFuzzyRecomView ? lightOrange : Colors.white,
            outlineColor: japfaOrange,
            height: 40,
            width: 200,
            rounded: 5,
            onPressed: () => _sortPesertaByFuzzyScore(),
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
              _filterByStatus(null); // No status = All
            },
          ),
          const SizedBox(width: 10),
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
              _filterByStatus(statusMagangMenunggu); // Filter by "Menunggu"
            },
          ),
          const SizedBox(width: 10),
          RoundedRectangleButton(
            title: "Diterima",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusMagangDiterima
                ? Colors.green
                : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangDiterima); // Filter by "Diterima"
            },
          ),
          const SizedBox(width: 10),
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
          RoundedRectangleButton(
            title: "Ditolak",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor:
                currentStatus == statusMagangDitolak ? Colors.red : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangDitolak); // Filter by "Ditolak"
            },
          ),
        ],
      ),
    );
  }

  // Build the data table
  Widget _buildPesertaMagangDataTable(
    List<PesertaMagangData> filteredMagangData,
  ) {
    return filteredMagangData.isEmpty
        ? buildEmptyDataMessage(
            dataName: "Pendaftar Magang ${widget.departmentName}",
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
                    columns: isFuzzyRecomView
                        ? [
                            const DataColumn(label: Text('Nama')),
                            const DataColumn(label: Text('Nilai Rekomendasi')),
                            const DataColumn(label: Text('Email')),
                            const DataColumn(label: Text('Universitas')),
                            const DataColumn(label: Text('Jurusan')),
                            const DataColumn(label: Text('IPK')),
                            const DataColumn(label: Text('Status')),
                            const DataColumn(label: Text('Aksi')),
                          ]
                        : [
                            const DataColumn(label: Text('Nama')),
                            const DataColumn(label: Text('No. Telp')),
                            const DataColumn(label: Text('Email')),
                            const DataColumn(label: Text('Universitas')),
                            const DataColumn(label: Text('Jurusan')),
                            const DataColumn(label: Text('Angkatan')),
                            const DataColumn(label: Text('IPK')),
                            const DataColumn(label: Text('Status')),
                            const DataColumn(label: Text('Aksi')),
                          ],
                    rows: filteredMagangData.map((peserta) {
                      // Get fuzzy score from the skill data using email
                      double? fuzzyScore = emailToFuzzyScoreMap[peserta.email];
                      print('FuzzyScore : $fuzzyScore');
                      String fuzzyString = getFuzzyStringValue(fuzzyScore);
                      return DataRow(
                        cells: [
                          DataCell(
                              Text(peserta.nama, textAlign: TextAlign.center)),
                          DataCell(
                            Text(
                              isFuzzyRecomView ? fuzzyString : peserta.noTelp,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isFuzzyRecomView
                                    ? getFuzzyStringColor(fuzzyString)
                                    : Colors.black,
                              ),
                            ),
                          ),
                          DataCell(
                              Text(peserta.email, textAlign: TextAlign.center)),
                          DataCell(Text(peserta.asalUniversitas,
                              textAlign: TextAlign.center)),
                          DataCell(Text(peserta.jurusan,
                              textAlign: TextAlign.center)),
                          if (!isFuzzyRecomView) ...[
                            DataCell(
                              Text(
                                peserta.angkatan.toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          DataCell(Text(peserta.nilaiUniv.toString(),
                              textAlign: TextAlign.center)),
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

  void _sortPesertaByFuzzyScore() async {
    try {
      List<SkillPesertaMagangData> skillDataList =
          await ApiService().skillService.fetchAllSkills();

      emailToFuzzyScoreMap = {
        for (var skill in skillDataList) skill.email: skill.fuzzyScore,
      };

      pesertaMagangList.sort((a, b) {
        double scoreA = emailToFuzzyScoreMap[a.email] ?? 0;
        double scoreB = emailToFuzzyScoreMap[b.email] ?? 0;

        return scoreB.compareTo(scoreA);
      });

      setState(() {
        pesertaMagangList = pesertaMagangList;
        isFuzzyRecomView = !isFuzzyRecomView;
      });

      showSnackBar(
        context,
        isFuzzyRecomView
            ? "Data telah diurutkan berdasarkan departemen dan skor fuzzy"
            : "Data telah kembali diurutkan berdasarkan urutan pengajuan",
        backgroundColor: Colors.grey,
      );
    } catch (e) {
      print('Error sorting data: $e');
    }
  }

  // Method to update the filtered data based on search query and status
  void _updateFilteredPesertaData() {
    setState(() {
      filteredPesertaData = pesertaMagangList.where((peserta) {
        bool matchesDepartment = peserta.departemen == widget.departmentName;
        bool matchesSearchQuery =
            peserta.nama.toLowerCase().contains(searchQuery.toLowerCase());

        // If a status is selected, check for that status
        if (currentStatus != null) {
          return matchesDepartment &&
              matchesSearchQuery &&
              peserta.statusMagang == currentStatus;
        }

        return matchesDepartment && matchesSearchQuery;
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
}
