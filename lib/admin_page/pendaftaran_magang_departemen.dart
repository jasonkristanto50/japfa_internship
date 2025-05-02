import 'package:flutter/material.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
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
  List<PesertaMagangData> pesertaMagangList =
      []; // Your list of PesertaMagangData

  @override
  void initState() {
    super.initState();
    _fetchPesertaMagangData();
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = pesertaMagangList
        .where((peserta) =>
            peserta.departemen == widget.departmentName &&
            peserta.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

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
            // Add Search Bar
            CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            Padding(
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
                          WidgetStateProperty.all(Colors.orange[500]),
                      headingTextStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      border: TableBorder.all(color: Colors.grey, width: 1),
                      columns: const [
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('Departemen')),
                        DataColumn(label: Text('Universitas')),
                        DataColumn(label: Text('Jurusan')),
                        DataColumn(label: Text('Angkatan')),
                        DataColumn(label: Text('IPK')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: filteredData.map((peserta) {
                        return DataRow(
                          cells: [
                            DataCell(Text(peserta.nama,
                                textAlign: TextAlign.center)),
                            DataCell(Text(
                                peserta.departemen ?? "Tidak ada departemen",
                                textAlign: TextAlign.center)),
                            DataCell(Text(peserta.asalUniversitas,
                                textAlign: TextAlign.center)),
                            DataCell(Text(peserta.jurusan,
                                textAlign: TextAlign.center)),
                            DataCell(Text(peserta.angkatan.toString(),
                                textAlign: TextAlign.center)),
                            DataCell(Text(peserta.nilaiUniv.toString(),
                                textAlign: TextAlign.center)),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: RoundedRectangleButton(
                                  title: "VIEW DETAILS",
                                  backgroundColor:
                                      const Color.fromARGB(255, 152, 209, 255),
                                  height: 30,
                                  width: 150,
                                  rounded: 5,
                                  onPressed: () {
                                    // _viewDetails(peserta);
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
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchPesertaMagangData() async {
    try {
      List<PesertaMagangData> data =
          await ApiService().fetchPesertaMagangData();
      setState(() {
        pesertaMagangList = data; // Assign the fetched data to the list
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _viewDetails(Map<String, dynamic> detailPengajuan) {
    // Navigate to a new page to show more details
  }
}
