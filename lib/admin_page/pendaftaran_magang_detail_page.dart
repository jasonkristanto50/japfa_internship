import 'package:flutter/material.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';

class PendaftaranMagangDetailPage extends StatefulWidget {
  final PesertaMagangData peserta;

  const PendaftaranMagangDetailPage({super.key, required this.peserta});

  @override
  _PendaftaranMagangDetailPageState createState() =>
      _PendaftaranMagangDetailPageState();
}

class _PendaftaranMagangDetailPageState
    extends State<PendaftaranMagangDetailPage> {
  late PesertaMagangData peserta;

  @override
  void initState() {
    super.initState();
    peserta = widget.peserta;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Detail Peserta Magang',
        context: context,
        showBackButton: true,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Center(
          child: Container(
            width: 1000,
            height: 600,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Title at the Center Top
                Text(
                  'Detail Peserta',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: japfaOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20), // Space between title and content

                // First Row: Information Fields and File Paths
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Participant data
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildInfoField('Nama', peserta.nama),
                              buildInfoField('No. Telp', peserta.noTelp),
                              buildInfoField('Email', peserta.email),
                              buildInfoField(
                                  'Universitas', peserta.asalUniversitas),
                              buildInfoField('Jurusan', peserta.jurusan),
                              buildInfoField(
                                  'Angkatan', peserta.angkatan.toString()),
                              buildInfoField(
                                  'IPK', peserta.nilaiUniv.toString()),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),

                      buildFileAndStatus(),
                      const SizedBox(width: 50),
                      buildFotoDiriPeserta(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Second Row: Action Buttons
                buildActionButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: bold16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: japfaOrange),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white, // Background color for fields
              ),
              child: Text(value, style: regular14),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFileAndStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CV
        buildFileButton('CV', () {
          launchURLImagePath(peserta.pathCv);
        }),
        // Persetujuan Kampus
        buildFileButton('Persetujuan Kampus', () {
          launchURLImagePath(peserta.pathPersetujuanUniv);
        }),
        // Transkrip Nilai
        buildFileButton('Transkrip Nilai', () {
          launchURLImagePath(peserta.pathTranskripNilai);
        }),
        // Status
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('STATUS:', style: bold14),
              const SizedBox(height: 5),
              Text(
                peserta.statusMagang,
                style: bold16.copyWith(color: japfaOrange),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFotoDiriPeserta() {
    // Full Path
    final String imagePath = '$baseUrl${peserta.pathFotoDiri}';

    return Image.network(
      imagePath,
      height: 300,
      width: 225,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null),
        );
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Center(child: Text('Failed to load image.'));
      },
    );
  }

  Widget buildFileButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title:', style: bold14),
          const SizedBox(height: 5), // Space between label and button
          RoundedRectangleButton(
            title: "Tampilkan",
            style: regular14,
            fontColor: Colors.white,
            backgroundColor: japfaOrange,
            width: 150,
            height: 35,
            rounded: 5,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  Widget buildActionButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedRectangleButton(
          title: 'Reject',
          backgroundColor: Colors.red,
          fontColor: Colors.white,
          width: 100,
          height: 40,
          onPressed: () async {
            await updateStatus(context, peserta.idMagang, "Ditolak");
          },
        ),
        const SizedBox(width: 20),
        RoundedRectangleButton(
          title: 'Accept',
          backgroundColor: japfaOrange,
          fontColor: Colors.white,
          width: 100,
          height: 40,
          onPressed: () async {
            await updateStatus(context, peserta.idMagang, "Diterima");
          },
        ),
      ],
    );
  }

  Future<void> updateStatus(
      BuildContext context, String idMagang, String newStatus) async {
    final updatedPeserta =
        await ApiService().updatePesertaMagangStatus(idMagang, newStatus);

    if (updatedPeserta != null) {
      setState(() {
        peserta = updatedPeserta; // Update the local peserta state
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Peserta updated successfully: ${updatedPeserta.nama}'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update peserta.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
