import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/navbar.dart';

class LaporanPesertaMagang extends StatefulWidget {
  const LaporanPesertaMagang({super.key});

  @override
  State<LaporanPesertaMagang> createState() => _LaporanPesertaMagangState();
}

class _LaporanPesertaMagangState extends State<LaporanPesertaMagang> {
  List<String> laporans = [
    'Proposal',
    'Laporan Kemajuan',
    'Refleksi Kepemimpinan',
    'Laporan Akhir',
    'Lampiran',
    'Placement Acceptance'
  ];

  List<Map<String, String>> laporanList = []; // To hold the submitted reports

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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ElevatedButton(
                onPressed: _showAddLaporanModal,
                child: const Text('Tambah Laporan'),
              ),
            ),
            // Table Section
            Expanded(
              child: laporanList.isEmpty
                  ? _buildEmptyState()
                  : _buildLaporanTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'No reports available.',
        style: TextStyle(fontSize: 20, color: Colors.grey),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                    DataColumn(label: Text('Validasi Pembimbing')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: laporanList.map<DataRow>((laporan) {
                    return DataRow(cells: [
                      DataCell(Text(laporan['nama'] ?? '')),
                      DataCell(Text(laporan['url'] ?? '')),
                      DataCell(Text(laporan['validasi'] ?? '')),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteLaporan(laporan),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddLaporanModal() {
    String selectedLaporanType = '';
    String filePath = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Laporan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Pilih Jenis Laporan',
                ),
                value:
                    selectedLaporanType.isNotEmpty ? selectedLaporanType : null,
                items: laporans.map((String laporan) {
                  return DropdownMenuItem<String>(
                    value: laporan,
                    child: Text(laporan),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedLaporanType = value ?? '';
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "File / URL Laporan",
                ),
                onChanged: (value) {
                  filePath = value;
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (selectedLaporanType.isNotEmpty && filePath.isNotEmpty) {
                  setState(() {
                    laporanList.add({
                      'nama': selectedLaporanType,
                      'url': filePath,
                      'validasi': 'Pending',
                    });
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill in all fields.")),
                  );
                }
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _deleteLaporan(Map<String, String> laporan) {
    setState(() {
      laporanList.remove(laporan);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Laporan deleted successfully!")),
      );
    });
  }
}
