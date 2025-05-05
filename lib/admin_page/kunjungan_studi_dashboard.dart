import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class KunjunganStudiDashboard extends StatefulWidget {
  const KunjunganStudiDashboard({super.key});

  @override
  State<KunjunganStudiDashboard> createState() =>
      _KunjunganStudiDashboardState();
}

class _KunjunganStudiDashboardState extends State<KunjunganStudiDashboard> {
  String searchQuery = "";
  List<KunjunganStudiData> kunjunganList = [];

  @override
  void initState() {
    super.initState();
    _fetchKunjunganData();
  }

  @override
  Widget build(BuildContext context) {
    // Filter kunjunganData based on search query
    List<KunjunganStudiData> filteredKunjunganData = kunjunganList
        .where((kunjungan) => kunjungan.asalUniversitas
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
              labelSearchBar: "Ketikkan nama universitas",
              widthValue: 1500.w,
              onChanged: (value) {
                setState(() {
                  searchQuery = value; // Update search query
                });
              },
            ),
            // Table Section - Centered
            _buildKunjunganStudiTable(filteredKunjunganData),
          ],
        ),
      ),
    );
  }

  // Fetch Kunjungan Studi data from API or Local source
  Future<void> _fetchKunjunganData() async {
    try {
      final response = await Dio().get(
          'http://localhost:3000/api/kunjungan_studi/fetch-all-kunjungan-data');
      final List<dynamic> data = response.data;

      setState(() {
        kunjunganList = data
            .map((item) => KunjunganStudiData.fromJson(
                item)) // Deserialize into KunjunganStudiData
            .toList();

        // Sort by date (tanggalKegiatan) in descending order (latest first)
        kunjunganList.sort((a, b) {
          // Assuming 'tanggalKegiatan' is a string in the format 'YYYY-MM-DD'
          final dateA = DateTime.parse(a.tanggalKegiatan);
          final dateB = DateTime.parse(b.tanggalKegiatan);
          return dateB.compareTo(dateA); // To sort in descending order
        });
      });
    } catch (e) {
      print('Error fetching kunjungan studi data: $e');
    }
  }

  Widget _buildKunjunganStudiTable(
      List<KunjunganStudiData> filteredKunjunganData) {
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
          child: SizedBox(
            height: 700.h, // Set a fixed height as required
            child: SingleChildScrollView(
              // Vertical Scroll
              child: SingleChildScrollView(
                // Horizontal Scroll
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.orange[500]),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  border: TableBorder.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  columns: const [
                    DataColumn(label: Text('Tanggal')),
                    DataColumn(label: Text('Asal Universitas')),
                    DataColumn(label: Text('Nama Perwakilan')),
                    DataColumn(label: Text('No Telp')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Jumlah Anak')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Aksi')),
                  ],
                  rows: filteredKunjunganData.map((kunjungan) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            kunjungan.tanggalKegiatan,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            kunjungan.asalUniversitas,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            kunjungan.namaPerwakilan,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            kunjungan.noTelp,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            kunjungan.email,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(
                            kunjungan.jumlahAnak.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        DataCell(
                          Text(kunjungan.status,
                              textAlign: TextAlign.center,
                              style: bold18.copyWith(
                                color: kunjungan.status == 'Diterima'
                                    ? Colors.green
                                    : kunjungan.status == 'Ditolak'
                                        ? Colors.red
                                        : kunjungan.status == 'Menunggu'
                                            ? Colors.orange
                                            : Colors.black,
                              )),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: RoundedRectangleButton(
                              title: "RESPOND",
                              backgroundColor: lightBlue,
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
      ),
    );
  }

  void _respond(KunjunganStudiData kunjungan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomRespondDialog(
          title: "Berikan Respon",
          message: "Mau menerima / menolak kunjungan ?",
          onAccept: () {
            Navigator.of(context).pop();
            _handleResponse(kunjungan, true); // Accept
          },
          onReject: () {
            Navigator.of(context).pop();
            _handleResponse(kunjungan, false); // Reject
          },
        );
      },
    );
    setState(() {});
  }

  void _handleResponse(KunjunganStudiData kunjungan, bool isAccepted) async {
    // Update status locally first
    setState(() {
      kunjungan =
          kunjungan.copyWith(status: isAccepted ? 'Diterima' : 'Ditolak');
    });

    // Call the API to update the status in the backend
    try {
      final response = await Dio().put(
        'http://localhost:3000/api/kunjungan_studi/${kunjungan.idKunjunganStudi}',
        data: {
          'status': kunjungan.status, // Send the updated status
        },
      );

      if (response.statusCode == 200) {
        // Optionally, show a success message or handle UI updates
        print('Status updated to: ${kunjungan.status}');
        // Refresh data by calling the function that fetches the latest data from the backend
        _fetchKunjunganData();
      } else {
        // If the backend response isn't successful, revert the local change or show an error message
        print('Failed to update status');
      }
    } catch (e) {
      print('Error updating status: $e');
      // Optionally revert status if error occurs
      setState(() {
        kunjungan = kunjungan.copyWith(status: 'Pending');
      });
    }
  }
}
