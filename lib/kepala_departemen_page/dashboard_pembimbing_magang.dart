import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/kepala_departemen_page/dashboard_logbook_peserta.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/navbar.dart';

class DashboardPembimbingMagang extends ConsumerStatefulWidget {
  const DashboardPembimbingMagang({super.key});

  @override
  _DashboardPembimbingMagangState createState() =>
      _DashboardPembimbingMagangState();
}

class _DashboardPembimbingMagangState
    extends ConsumerState<DashboardPembimbingMagang> {
  String searchQuery = "";
  List<PesertaMagangData> pesertaMagangList = [];
  late String namaPembimbing;

  @override
  void initState() {
    super.initState();
    // Get the login state and set the namaPembimbing
    final loginState = ref.read(loginProvider);
    namaPembimbing = loginState.name!;
    _fetchPesertaMagangDataByPembimbing();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPesertaData = pesertaMagangList
        .where((peserta) =>
            peserta.nama.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: 'Dashboard Peserta Magang',
        titleOnPressed: () {},
        showBackButton: true,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Search Bar
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
            _buildPesertaMagangDataTable(filteredPesertaData),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildPesertaMagangDataTable(
      List<PesertaMagangData> filteredPesertaData) {
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
              headingRowColor: const WidgetStatePropertyAll(Colors.orange),
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
                DataColumn(label: Text('Aksi')),
              ],
              rows: filteredPesertaData.map((peserta) {
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
                      Align(
                        alignment: Alignment.center,
                        child: RoundedRectangleButton(
                          title: "LOGBOOK",
                          backgroundColor:
                              const Color.fromARGB(255, 152, 209, 255),
                          height: 30,
                          width: 150,
                          rounded: 5,
                          onPressed: () {
                            _viewLogbook(
                                peserta.email); // Dummy function for UI only
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

  Future<void> _fetchPesertaMagangDataByPembimbing() async {
    try {
      List<PesertaMagangData> data = await ApiService()
          .pesertaMagangService
          .fetchDataByPembimbing(namaPembimbing);
      setState(() {
        pesertaMagangList = data;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _viewLogbook(String email) {
    fadeNavigation(
      context,
      targetNavigation: DashboardLogbookPeserta(email: email),
    );
  }
}
