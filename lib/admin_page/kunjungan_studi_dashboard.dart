import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/data.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class KunjunganStudiDashboard extends StatefulWidget {
  const KunjunganStudiDashboard({super.key});

  @override
  State<KunjunganStudiDashboard> createState() =>
      _KunjunganStudiDashboardState();
}

class _KunjunganStudiDashboardState extends State<KunjunganStudiDashboard> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filter kunjunganData based on search query
    List<Map<String, dynamic>> filteredKunjunganData = kunjunganData
        .where((kunjungan) => kunjungan['asal universitas']
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Search bar
            CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value; // Update search query
                });
              },
            ),
            // Table Section - Centered
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
                        DataColumn(label: Text('Asal Universitas')),
                        DataColumn(label: Text('Nama Perwakilan')),
                        DataColumn(label: Text('No Telp')),
                        DataColumn(label: Text('Jumlah Anak')),
                        DataColumn(label: Text('Tanggal')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: filteredKunjunganData.map((kunjungan) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                kunjungan['asal universitas'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                kunjungan['nama'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                kunjungan['no telp'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                kunjungan['jumlah'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                kunjungan['tanggal kegiatan'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Text(
                                kunjungan['status'].toString(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.center,
                                child: RoundedRectangleButton(
                                  title: "RESPOND",
                                  backgroundColor:
                                      const Color.fromARGB(255, 247, 211, 159),
                                  height: 30,
                                  width: 150,
                                  rounded: 5,
                                  onPressed: () => _respond(kunjungan),
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

  void _respond(Map<String, dynamic> kunjungan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Respond to Kunjungan'),
          content: const Text(
              'Do you want to accept (Diterima) or reject (Ditolak) this request?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Diterima'),
              onPressed: () {
                Navigator.of(context).pop();
                _handleResponse(kunjungan, true);
              },
            ),
            TextButton(
              child: const Text('Ditolak'),
              onPressed: () {
                Navigator.of(context).pop();
                _handleResponse(kunjungan, false);
              },
            ),
          ],
        );
      },
    );
  }

  void _handleResponse(Map<String, dynamic> kunjungan, bool isAccepted) {
    setState(() {
      if (isAccepted) {
        kunjungan['status'] = 'Diterima';
      } else {
        kunjungan['status'] = 'Ditolak';
      }
    });

    // Optional: Add print for debugging
    print(
        'Kunjungan for ${kunjungan['nama']} status updated to: ${kunjungan['status']}');
  }
}
