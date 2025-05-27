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
  int _currentPage = 0;
  String? currentStatus; // Add a variable to keep track of current status

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
            title: "Rekomendasi",
            backgroundColor: Colors.white,
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
            title: "Proses",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: _currentPage == 1 ? japfaOrange : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangMenunggu); // Filter by "On Process"
            },
          ),
          const SizedBox(width: 10),
          RoundedRectangleButton(
            title: statusMagangDiterima,
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: _currentPage == 2 ? Colors.green : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangDiterima); // Filter by "Accepted"
            },
          ),
          const SizedBox(width: 10),
          RoundedRectangleButton(
            title: statusMagangDitolak,
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: _currentPage == 3 ? Colors.red : Colors.grey,
            onPressed: () {
              _filterByStatus(statusMagangDitolak); // Filter by "Rejected"
            },
          ),
        ],
      ),
    );
  }

  // Build the data table
  Widget _buildPesertaMagangDataTable(List<PesertaMagangData> filteredData) {
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
              border: TableBorder.all(color: Colors.grey, width: 1),
              columns: const [
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('No. Telp')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Universitas')),
                DataColumn(label: Text('Jurusan')),
                DataColumn(label: Text('Angkatan')),
                DataColumn(label: Text('IPK')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Aksi')),
              ],
              rows: filteredData.map((peserta) {
                return DataRow(
                  cells: [
                    DataCell(Text(peserta.nama, textAlign: TextAlign.center)),
                    DataCell(Text(peserta.noTelp, textAlign: TextAlign.center)),
                    DataCell(Text(peserta.email, textAlign: TextAlign.center)),
                    DataCell(Text(peserta.asalUniversitas,
                        textAlign: TextAlign.center)),
                    DataCell(
                        Text(peserta.jurusan, textAlign: TextAlign.center)),
                    DataCell(Text(peserta.angkatan.toString(),
                        textAlign: TextAlign.center)),
                    DataCell(Text(peserta.nilaiUniv.toString(),
                        textAlign: TextAlign.center)),
                    DataCell(
                      Text(
                        peserta.statusMagang,
                        style: TextStyle(
                          color: getStatusMagangColor(peserta.statusMagang),
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

      Map<String, double> emailToFuzzyScoreMap = {
        for (var skill in skillDataList) skill.email: skill.fuzzyScore,
      };

      pesertaMagangList.sort((a, b) {
        double scoreA = emailToFuzzyScoreMap[a.email] ?? 0;
        double scoreB = emailToFuzzyScoreMap[b.email] ?? 0;

        return scoreB.compareTo(scoreA);
      });

      setState(() {
        // Refresh the display with sorted list
        pesertaMagangList = pesertaMagangList;
      });
      showSnackBar(context, "Data telah diurutkan berdasar rekomendasi");
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

  void _filterByStatus(String status) {
    setState(() {
      currentStatus = status;
      _updateFilteredPesertaData();
      _currentPage = status == statusMagangMenunggu
          ? 1
          : status == statusMagangDiterima
              ? 2
              : 3;
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
