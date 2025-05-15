import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';

class LogBookPesertaDashboard extends StatefulWidget {
  const LogBookPesertaDashboard({super.key});

  @override
  State<LogBookPesertaDashboard> createState() =>
      _LogBookPesertaDashboardState();
}

class _LogBookPesertaDashboardState extends State<LogBookPesertaDashboard> {
  String searchQuery = "";

  // Dummy data for the logbook
  List<Map<String, String>> logbookData = [
    {
      'no': '1',
      'aktivitas': 'Presentasi dan Knowledge Sharing',
      'tanggal_kegiatan': '29-11-2024',
      'url': 'http://example.com/url1',
      'status': 'Selesai',
      'catatan_pembimbing': 'Catatan 1',
    },
    {
      'no': '2',
      'aktivitas': 'Bug fixing Aplikasi Messaging',
      'tanggal_kegiatan': '28-11-2024',
      'url': 'http://example.com/url2',
      'status': 'Selesai',
      'catatan_pembimbing': 'Catatan 2',
    },
    {
      'no': '3',
      'aktivitas': 'Demo aplikasi pada Mitra',
      'tanggal_kegiatan': '25-11-2024',
      'url': 'http://example.com/url3',
      'status': 'Belum',
      'catatan_pembimbing': 'Catatan 3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredLogData = logbookData.where((data) {
      return data['aktivitas']!
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
            // Add Search Bar
            Center(
              child: CustomSearchBar(
                widthValue: 1500.w,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            // Add Log Book Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: RoundedRectangleButton(
                  title: "Tambah Log Book",
                  backgroundColor: Colors.orange,
                  height: 30,
                  width: 150,
                  rounded: 5,
                  onPressed: () {
                    _showAddLogBookModal();
                  },
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
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
                        border: TableBorder.all(color: Colors.grey, width: 1),
                        columns: const [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Aktivitas')),
                          DataColumn(label: Text('Tanggal Aktivitas')),
                          DataColumn(label: Text('URL Lampiran')),
                          DataColumn(label: Text('Validasi Pembimbing')),
                          DataColumn(label: Text('Catatan Pembimbing')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: filteredLogData.map<DataRow>((data) {
                          return DataRow(cells: [
                            DataCell(Text(data['no']!)),
                            DataCell(Text(data['aktivitas']!)),
                            DataCell(Text(data['tanggal_kegiatan']!)),
                            DataCell(Text(data['url']!)),
                            DataCell(
                                Text(data['status'] == 'Selesai' ? '✓' : '✗')),
                            DataCell(Text(data['catatan_pembimbing']!)),
                            DataCell(Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: Colors.orange),
                                  onPressed: () {
                                    // Handle edit action
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.visibility,
                                      color: Colors.orange),
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

  void _showAddLogBookModal() {
    final TextEditingController activityController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Tambah Log Book'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: activityController,
                  decoration: const InputDecoration(
                    labelText: 'Aktivitas',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Aktivitas',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: urlController,
                  decoration: const InputDecoration(
                    labelText: 'URL Lampiran',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Logic to add log book entry goes here
                Navigator.of(ctx).pop();
              },
              child:
                  const Text('SIMPAN', style: TextStyle(color: Colors.orange)),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }
}
