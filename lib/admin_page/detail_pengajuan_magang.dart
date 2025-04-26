import 'package:flutter/material.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/data.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class DetailPengajuanMagang extends StatefulWidget {
  const DetailPengajuanMagang({super.key, required this.departmentName});
  final String departmentName;

  @override
  State<DetailPengajuanMagang> createState() => _DetailPengajuanMagangState();
}

class _DetailPengajuanMagangState extends State<DetailPengajuanMagang> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filter data based on departmentName and search query
    final filteredData = detailPengajuanData
        .where((detailPengajuan) =>
            detailPengajuan['departemen'] == widget.departmentName &&
            detailPengajuan['nama']
                .toLowerCase()
                .contains(searchQuery.toLowerCase())) // Search filter
        .toList();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: '$appName - ${widget.departmentName}',
        titleOnPressed: () => {}, // invalid title click
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
                  searchQuery = value; // Update search query
                });
              },
            ),
            // Add padding to the top
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
                      border: TableBorder.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      columns: const [
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('Departemen')),
                        DataColumn(label: Text('Universitas')),
                        DataColumn(label: Text('Jurusan')),
                        DataColumn(label: Text('Angkatan')),
                        DataColumn(label: Text('IPK')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: filteredData.map((detailPengajuan) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                detailPengajuan['nama'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                detailPengajuan['departemen'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                detailPengajuan['universitas'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                detailPengajuan['jurusan'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                detailPengajuan['angkatan'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                detailPengajuan['ipk'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
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
                                    // Handle the view details button action
                                    _viewDetails(detailPengajuan);
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
            const SizedBox(height: 24), // Extra space
          ],
        ),
      ),
    );
  }

  void _viewDetails(Map<String, dynamic> detailPengajuan) {
    // Navigate to a new page to show more details
    // For example, you might pass detailPengajuan to a new DetailPage
  }
}
