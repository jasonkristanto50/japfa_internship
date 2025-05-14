import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/authentication/login.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';

class PendaftaranMagangDetailPage extends ConsumerStatefulWidget {
  final PesertaMagangData? peserta;
  const PendaftaranMagangDetailPage({super.key, this.peserta});

  @override
  ConsumerState<PendaftaranMagangDetailPage> createState() =>
      _PendaftaranMagangDetailPageState();
}

class _PendaftaranMagangDetailPageState
    extends ConsumerState<PendaftaranMagangDetailPage> {
  PesertaMagangData? peserta;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    peserta = widget.peserta;

    final login = ref.read(loginProvider);
    if (peserta == null && login.email != null) {
      _fetchByEmail(login.email!);
    }
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
        child: _body(),
      ),
    );
  }

  Widget _body() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    final login = ref.read(loginProvider);
    if (login.isLoggedIn == false) {
      return CustomLoginDialog(
        onLoginPressed: () => fadeNavigation(
          context,
          targetNavigation: const LoginScreen(),
        ),
        onClearTap: () => fadeNavigation(
          context,
          targetNavigation: const MyHomePage(),
        ),
      );
    }
    if (peserta == null) {
      return const Center(child: Text('Tidak ada data peserta.'));
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
            Text('Detail Peserta', style: bold24.copyWith(color: japfaOrange)),
            const SizedBox(height: 20),
            _mainContent(),
            const SizedBox(height: 30),
            _actionButtons(),
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
                  buildDataInfoField(label: 'Nama', value: peserta!.nama),
                  buildDataInfoField(label: 'No. Telp', value: peserta!.noTelp),
                  buildDataInfoField(label: 'Email', value: peserta!.email),
                  buildDataInfoField(
                      label: 'Universitas', value: peserta!.asalUniversitas),
                  buildDataInfoField(label: 'Jurusan', value: peserta!.jurusan),
                  buildDataInfoField(
                      label: 'Angkatan', value: peserta!.angkatan.toString()),
                  buildDataInfoField(
                      label: 'IPK', value: peserta!.nilaiUniv.toString()),
                ],
              ),
            ),
          ),
          const SizedBox(width: 50),
          _fileAndStatus(),
          const SizedBox(width: 50),
          _foto(),
        ],
      ),
    );
  }

  Widget _fileAndStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildFileButton('CV', () => launchURLImagePath(peserta!.pathCv)),
        buildFileButton('Persetujuan Kampus',
            () => launchURLImagePath(peserta!.pathPersetujuanUniv)),
        buildFileButton('Transkrip Nilai',
            () => launchURLImagePath(peserta!.pathTranskripNilai)),
        const SizedBox(height: 10),
        Text('STATUS:', style: bold14),
        Text(peserta!.statusMagang, style: bold16.copyWith(color: japfaOrange)),
        const SizedBox(height: 10),
        Text('NOTE:', style: regular14),
        Text(peserta!.catatanHr ?? 'Tidak ada catatan'),
      ],
    );
  }

  Widget _foto() {
    final img = '$baseUrl${peserta!.pathFotoDiri}';
    return Image.network(
      img,
      height: 300,
      width: 225,
      fit: BoxFit.cover,
      loadingBuilder: (c, child, p) =>
          p == null ? child : const CircularProgressIndicator(),
      errorBuilder: (c, _, __) => const Text('Failed to load image'),
    );
  }

  Widget _actionButtons() {
    final loginState = ref.watch(loginProvider);
    if (loginState.role == roleAdminValue) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedRectangleButton(
            title: 'Reject',
            backgroundColor: Colors.red,
            fontColor: Colors.white,
            width: 100,
            height: 40,
            onPressed: () => _confirmReject(peserta!),
          ),
          const SizedBox(width: 20),
          RoundedRectangleButton(
            title: 'Accept',
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            width: 100,
            height: 40,
            onPressed: () => _confirmAccept(peserta!),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Future<void> _fetchByEmail(String email) async {
    setState(() => _loading = true);
    try {
      // TODO
      final data = await ApiService().fetchPesertaMagangByEmail(email);
      setState(() => peserta = data);
    } finally {
      setState(() => _loading = false);
    }
  }

  void _confirmAccept(PesertaMagangData peserta) async {
    await showCustomConfirmAcceptDialogWithNote(
      context: context,
      title: 'Konfirmasi Terima ?',
      message: 'Berikan Konfirmasi',
      withNote: false,
      rejectText: 'Batal',
      onAccept: (note) {
        if (note == null) {
          _updateStatus(peserta.idMagang, statusMagangDiterima);
        } else {
          _updateStatusWithNote(peserta, true, note);
        }
      },
      onReject: () {},
    );
  }

  void _confirmReject(PesertaMagangData peserta) async {
    await showCustomConfirmRejectDialogWithNote(
      context: context,
      title: 'Konfirmasi Ditolak ?',
      message: 'Berikan Konfirmasi',
      withNote: true,
      onAccept: () {},
      onReject: (note) {
        if (note == null) {
          _updateStatus(peserta.idMagang, statusMagangDitolak);
        } else {
          _updateStatusWithNote(peserta, false, note);
        }
      },
    );
  }

  Future<void> _updateStatus(String id, String status) async {
    final upd = await ApiService().updatePesertaMagangStatus(id, status);
    if (upd != null) {
      setState(() => peserta = upd);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Peserta updated: ${upd.nama}')),
      );
    }
  }

  Future<void> _updateStatusWithNote(
      PesertaMagangData p, bool accepted, String note) async {
    setState(() {
      peserta = p.copyWith(
        statusMagang: accepted ? statusMagangDiterima : statusMagangDitolak,
        catatanHr: note,
      );
    });
    try {
      await ApiService().updatePesertaMagangStatusWithNote(
        idMagang: p.idMagang,
        status: peserta!.statusMagang,
        catatanHr: note,
      );
    } catch (_) {
      setState(() {
        peserta = p.copyWith(statusMagang: 'Pending', catatanHr: null);
      });
    }
    fadeNavigation(context,
        targetNavigation: PendaftaranMagangDetailPage(peserta: peserta),
        time: 0);
  }
}
