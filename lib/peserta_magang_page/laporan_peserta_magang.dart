import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:japfa_internship/navbar.dart';

class LaporanPesertaMagang extends StatefulWidget {
  const LaporanPesertaMagang({super.key});

  @override
  State<LaporanPesertaMagang> createState() => _LaporanPesertaMagangState();
}

class _LaporanPesertaMagangState extends State<LaporanPesertaMagang> {
  // Default report types
  List<String> laporans = [
    'Proposal',
    'Laporan Kemajuan',
    'Refleksi Kepemimpinan',
    'Laporan Akhir',
    'Lampiran',
    'Placement Acceptance'
  ];

  // This will hold the URLs for each report
  Map<String, Map<String, String?>> laporanData = {
    'Proposal': {'url': null, 'validasi': 'Pending'},
    'Laporan Kemajuan': {'url': null, 'validasi': 'Pending'},
    'Refleksi Kepemimpinan': {'url': null, 'validasi': 'Pending'},
    'Laporan Akhir': {'url': null, 'validasi': 'Pending'},
    'Lampiran': {'url': null, 'validasi': 'Pending'},
    'Placement Acceptance': {'url': null, 'validasi': 'Pending'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: 'Laporan Peserta',
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Laporan Peserta",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: _buildLaporanTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLaporanTable() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0), // Padding around the table
      child: Center(
        child: SizedBox(
          // Set width to 90% of screen width
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Container(
              color: Colors.white, // Background color behind the DataTable
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(Colors.orange[500]),
                headingTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                border: TableBorder.all(color: Colors.grey, width: 1),
                columns: const [
                  DataColumn(label: Text('Nama Laporan')),
                  DataColumn(label: Text('File / URL')),
                  DataColumn(label: Text('Verifikasi Pembimbing')),
                  DataColumn(label: Text('Action')),
                ],
                rows: laporans.map<DataRow>((laporan) {
                  String? url = laporanData[laporan]?['url'];
                  return DataRow(cells: [
                    DataCell(Text(laporan)),
                    DataCell(
                      // Clickable link using GestureDetector
                      GestureDetector(
                        onTap: () {
                          if (url != null && url.isNotEmpty) {
                            _launchURL(url);
                          }
                        },
                        child: Text(
                          url ?? '',
                          style: TextStyle(
                            color: url != null && url.isNotEmpty
                                ? Colors.blue
                                : Colors.grey,
                            decoration: url != null && url.isNotEmpty
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                        Text(laporanData[laporan]?['validasi'] ?? 'Pending')),
                    DataCell(
                      Row(
                        children: [
                          RoundedRectangleButton(
                            title: "Tambah URL",
                            backgroundColor: lightBlue,
                            fontColor: Colors.black,
                            style: regular14,
                            height: 40.h,
                            width: 150.w,
                            rounded: 5,
                            onPressed: () => _showAddLaporanModal(laporan),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteLaporan(laporan),
                          ),
                        ],
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

  // Launch URL function
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showAddLaporanModal(String laporanType) {
    TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Tambah URL Laporan',
          departmentName: laporanType,
          controller: urlController,
          label: "File / URL Laporan",
          onSave: () {
            String filePath = urlController.text;
            if (filePath.isNotEmpty) {
              setState(() {
                laporanData[laporanType]?['url'] =
                    filePath; // Update the URL for the selected report
                laporanData[laporanType]?['validasi'] =
                    'Pending'; // Reset validation
              });
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please enter a valid URL.")),
              );
            }
          },
        );
      },
    );
  }

  void _deleteLaporan(String laporanType) {
    setState(() {
      laporanData[laporanType]?['url'] =
          null; // Remove the URL for the selected report
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("URL deleted successfully!")),
      );
    });
  }
}
