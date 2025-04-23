import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/data.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/navbar.dart';

class PembimbingPesertaDashboard extends StatefulWidget {
  const PembimbingPesertaDashboard({super.key});

  @override
  State<PembimbingPesertaDashboard> createState() =>
      _PembimbingPesertaDashboardState();
}

class _PembimbingPesertaDashboardState
    extends State<PembimbingPesertaDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: 'Pembimbing Mahasiswa',
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Search Section
            Container(
              padding: const EdgeInsets.all(20),
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
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
                          DataColumn(label: Text('Nama Pembimbing')),
                          DataColumn(label: Text('Departemen')),
                          DataColumn(label: Text('Status')),
                        ],
                        rows: pembimbingPesertaData.map<DataRow>((data) {
                          return DataRow(cells: [
                            DataCell(Text(data['nama_pembimbing'])),
                            DataCell(Text(data['departemen'])),
                            DataCell(Text(data['status'])),
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
