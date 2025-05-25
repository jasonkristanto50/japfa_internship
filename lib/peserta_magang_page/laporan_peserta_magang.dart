import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaporanPesertaMagang extends ConsumerStatefulWidget {
  const LaporanPesertaMagang({super.key});

  @override
  _LaporanPesertaMagangState createState() => _LaporanPesertaMagangState();
}

class _LaporanPesertaMagangState extends ConsumerState<LaporanPesertaMagang> {
  String email = "";
  // Default report types
  List<String> laporans = ['Laporan Akhir'];

  Map<String, Map<String, String?>> laporanData = {
    'Laporan Akhir': {'url': null, 'validasi': 'Pending'},
  };

  @override
  void initState() {
    super.initState();
    final loginState = ref.read(loginProvider);
    email = loginState.email!;
    _fetchPesertaData();
  }

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
                          // Check for Laporan Akhir for edit
                          (laporan == 'Laporan Akhir')
                              ? RoundedRectangleButton(
                                  title: "Edit URL",
                                  backgroundColor: lightBlue,
                                  fontColor: Colors.black,
                                  style: regular14,
                                  height: 40.h,
                                  width: 150.w,
                                  rounded: 5,
                                  onPressed: () => _showEditUrlModal(laporan),
                                )
                              : RoundedRectangleButton(
                                  title: "Tambah URL",
                                  backgroundColor: lightBlue,
                                  fontColor: Colors.black,
                                  style: regular14,
                                  height: 40.h,
                                  width: 150.w,
                                  rounded: 5,
                                  onPressed: () =>
                                      _showAddLaporanModal(laporan),
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

  Future<void> _fetchPesertaData() async {
    try {
      PesertaMagangData pesertaData = await ApiService()
          .pesertaMagangService
          .fetchPesertaMagangByEmail(email);

      setState(() {
        // Assuming url_lampiran is a property of PesertaMagangData
        laporanData['Laporan Akhir']?['url'] = pesertaData.urlLaporanAkhir;
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

  void _showAddLaporanModal(String laporanType) {
    TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Tambah URL Laporan',
          subTitle: laporanType,
          numberOfField: 1,
          controllers: [urlController],
          labels: const ["File / URL Laporan"],
          fieldTypes: const [BuildFieldTypeController.text],
          onSave: () {
            String filePath = urlController.text;
            if (filePath.isNotEmpty) {
              setState(() {
                laporanData[laporanType]?['url'] = filePath;
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

  void _showEditUrlModal(String laporanType) {
    TextEditingController urlController =
        TextEditingController(text: laporanData[laporanType]?['url'] ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Edit URL Laporan Akhir',
          subTitle: laporanType,
          numberOfField: 1,
          controllers: [urlController],
          labels: const ["File / URL Laporan"],
          fieldTypes: const [BuildFieldTypeController.text],
          onSave: () async {
            String newUrl = urlController.text;
            if (newUrl.isNotEmpty) {
              await ApiService()
                  .pesertaMagangService
                  .updateUrlLaporanAkhir(email, newUrl);

              setState(() {
                laporanData[laporanType]?['url'] =
                    newUrl; // Update the URL in local state
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
