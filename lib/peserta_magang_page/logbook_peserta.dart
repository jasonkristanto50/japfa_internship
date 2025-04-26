import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/data.dart';
import 'package:japfa_internship/navbar.dart';

class LogBookPesertaDashboard extends StatefulWidget {
  const LogBookPesertaDashboard({super.key});

  @override
  State<LogBookPesertaDashboard> createState() =>
      _LogBookPesertaDashboardState();
}

class _LogBookPesertaDashboardState extends State<LogBookPesertaDashboard> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: 'Log Book Mahasiswa',
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Search Section
            CustomSearchBar(
              onChanged: (value) {
                setState(() {
                  searchQuery = value; // Update search query
                });
              },
            ),
            const SizedBox(height: 24),

            Expanded(
              // Ensures that this section takes up the remaining space
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
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Aktivitas')),
                          DataColumn(label: Text('Tanggal Aktivitas')),
                          DataColumn(label: Text('URL Lampiran')),
                          DataColumn(label: Text('Validasi Pembimbing')),
                          DataColumn(label: Text('Catatan Pembimbing')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: logbookData.map<DataRow>((data) {
                          return DataRow(cells: [
                            DataCell(Text('${data['no']}')),
                            DataCell(Text(data['aktivitas'])),
                            DataCell(Text(data['tanggal_kegiatan'])),
                            DataCell(Text(data['url'])),
                            DataCell(
                                Text(data['status'] == 'Selesai' ? '✓' : '✗')),
                            DataCell(Text(data['catatan_pembimbing'])),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle edit action
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.visibility),
                                  onPressed: () {
                                    // Handle view action
                                  },
                                ),
                              ],
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
