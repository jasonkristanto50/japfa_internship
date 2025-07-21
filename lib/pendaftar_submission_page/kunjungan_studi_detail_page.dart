import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/navbar.dart';

class KunjunganStudiDetailPage extends ConsumerStatefulWidget {
  final KunjunganStudiData? kunjunganData;

  const KunjunganStudiDetailPage({super.key, this.kunjunganData});

  @override
  ConsumerState<KunjunganStudiDetailPage> createState() =>
      _KunjunganStudiDetailPageState();
}

class _KunjunganStudiDetailPageState
    extends ConsumerState<KunjunganStudiDetailPage> {
  KunjunganStudiData? kunjunganData;
  bool _loading = false; // Loading state

  @override
  void initState() {
    super.initState();
    final login = ref.read(loginProvider);
    _fetchKunjunganDataByEmail(login.email!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Detail Kunjungan Studi',
        context: context,
        titleOnPressed: () {},
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (kunjunganData == null) {
      return const Center(child: Text('Tidak ada data kunjungan.'));
    }

    return Center(
      child: Container(
        width: 1000,
        height: 600,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))
          ],
        ),
        child: Column(
          children: [
            Text('Detail Kunjungan Studi',
                style: bold24.copyWith(color: japfaOrange)),
            const SizedBox(height: 20),
            _mainContent(),
          ],
        ),
      ),
    );
  }

  Widget _mainContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDataInfoField(
                    label: 'ID Kunjungan',
                    value: kunjunganData!.idKunjunganStudi,
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Nama Perwakilan',
                    value: kunjunganData!.namaPerwakilan,
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'No. Telp',
                    value: kunjunganData!.noTelp,
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Email',
                    value: kunjunganData!.email,
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Asal Universitas',
                    value: kunjunganData!.asalUniversitas,
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Tanggal Kegiatan',
                    value: kunjunganData!.tanggalKegiatan,
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Jam Kegiatan',
                    value: kunjunganData!.jamKegiatan,
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Jumlah Peserta',
                    value: kunjunganData!.jumlahPeserta.toString(),
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Catatan HR',
                    value: kunjunganData!.catatanHr ?? 'Tidak ada catatan',
                    verticalPadding: 5,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  children: [_buildFileUpload()],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFileUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFileButton(
          'File Persetujuan Instansi',
          () => launchURLImagePath(kunjunganData!.pathPersetujuanInstansi),
        ),
        if (kunjunganData!.pathFileResponJapfa != null) ...[
          buildFileButton(
            'File Respon Japfa',
            () => launchURLImagePath(kunjunganData!.pathFileResponJapfa!),
          ),
        ] else ...[
          Text(
            "File Respon Belum Diberikan",
            style: bold16,
          )
        ],
        const SizedBox(height: 10),
        Text('STATUS:', style: bold14),
        Text(
          kunjunganData!.status,
          style: bold18.copyWith(
            color: getStatusKunjunganColor(kunjunganData!.status),
          ),
        ),
        if (kunjunganData!.status == statusKunjunganSelesai) ...[
          const SizedBox(height: 20),
          buildFileButton(
            "Silahkan Isi Link Review ",
            backgroundColor: lightBlue,
            () => launchFullURLImagePath(fullPath: 'https://google.com'),
          )
        ]
      ],
    );
  }

  Future<void> _fetchKunjunganDataByEmail(String email) async {
    setState(() => _loading = true);
    try {
      final kunjunganDataList = await ApiService()
          .kunjunganStudiService
          .fetchKunjunganDataByEmail(email);
      if (kunjunganDataList.isNotEmpty) {
        setState(() {
          kunjunganData = kunjunganDataList.first;
        });
      }
    } catch (error) {
      print('Error fetching kunjungan data: $error');
    } finally {
      setState(() => _loading = false);
    }
  }
}
