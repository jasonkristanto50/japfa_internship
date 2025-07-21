import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/authentication/login.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/views/home_page.dart';
import 'package:japfa_internship/models/kepala_departemen_data/kepala_departemen_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/models/skill_peserta_magang_data/skill_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';

class PendaftaranMagangDetailPage extends ConsumerStatefulWidget {
  final PesertaMagangData? peserta;
  final VoidCallback? onUpdate;
  const PendaftaranMagangDetailPage({super.key, this.peserta, this.onUpdate});

  @override
  ConsumerState<PendaftaranMagangDetailPage> createState() =>
      _PendaftaranMagangDetailPageState();
}

class _PendaftaranMagangDetailPageState
    extends ConsumerState<PendaftaranMagangDetailPage> {
  PesertaMagangData? peserta;
  SkillPesertaMagangData? skill;
  int _currentPage = 1;
  late bool isAdmin;
  String? adminName;
  TextEditingController tanggalMeetController = TextEditingController();
  TextEditingController jamMeetController = TextEditingController();
  TextEditingController linkMeetController = TextEditingController();
  TextEditingController catatanWawancaraController = TextEditingController();

  @override
  void initState() {
    super.initState();
    peserta = widget.peserta;

    final login = ref.read(loginProvider);
    if (login.role == roleAdminValue) {
      isAdmin = true;
      adminName = login.name;
    } else {
      isAdmin = false;
    }

    if (peserta == null && login.email != null) {
      _fetchPesertaAndSkillByEmail(login.email!);
    } else if (peserta != null) {
      _fetchSkillByEmail(peserta!.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = ref.read(loginProvider);
    return Scaffold(
      appBar: Navbar(
        title: 'Detail Peserta Magang',
        context: context,
        showBackButton: login.role == rolePendaftarValue ? false : true,
        titleOnPressed: () {},
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: _buildMainBodyByRole(),
      ),
    );
  }

  Widget _buildMainBodyByRole() {
    if (isLoading) return const Center(child: CircularProgressIndicator());
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
        height: 700,
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
            if (_currentPage == 1) ...[
              Text('Data Peserta', style: bold28.copyWith(color: japfaOrange)),
              const SizedBox(height: 10),
              _buildDataDiriSkillButton(),
              const SizedBox(height: 20),
              _buildDataPesertaPage(),
            ] else ...[
              Text('Skill Peserta', style: bold28.copyWith(color: japfaOrange)),
              const SizedBox(height: 10),
              _buildDataDiriSkillButton(),
              const SizedBox(height: 20),
              _buildSkillPage(),
            ],
            const SizedBox(height: 30),
            if (peserta!.statusMagang == statusMagangMenunggu) ...[
              _buildRejectAcceptButton(),
            ] else if (peserta!.statusMagang == statusMagangDiterima ||
                peserta!.statusMagang == statusMagangDitolak) ...[
              _buildButtonForDiterimaOrDitolak()
            ] else if (peserta!.statusMagang == statusMagangBerlangsung) ...[
              _buildTidakLanjutAndSelesaiButton()
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildDataDiriSkillButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedRectangleButton(
            title: "Data Diri",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: _currentPage == 1 ? japfaOrange : Colors.grey,
            onPressed: () {
              setState(() {
                _currentPage = 1;
              });
            },
          ),
          const SizedBox(width: 10),
          RoundedRectangleButton(
            title: "Skill Diri",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: _currentPage == 2 ? japfaOrange : Colors.grey,
            onPressed: () {
              setState(() {
                _currentPage = 2;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDataPesertaPage() {
    final login = ref.read(loginProvider);
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
                    label: 'Nama',
                    value: peserta!.nama,
                    verticalPadding: 7,
                  ),
                  buildDataInfoField(
                    label: 'No. Telp',
                    value: peserta!.noTelp,
                    verticalPadding: 7,
                  ),
                  buildDataInfoField(
                    label: 'Email',
                    value: peserta!.email,
                    verticalPadding: 7,
                  ),
                  buildDataInfoField(
                    label: 'Universitas',
                    value: peserta!.asalUniversitas,
                    verticalPadding: 7,
                  ),
                  buildDataInfoField(
                    label: 'Jurusan',
                    value: peserta!.jurusan,
                    verticalPadding: 7,
                  ),
                  buildDataInfoField(
                    label: 'Angkatan',
                    value: peserta!.angkatan.toString(),
                    verticalPadding: 7,
                  ),
                  buildDataInfoField(
                    label: 'IPK',
                    value: peserta!.nilaiUniv.toString(),
                    verticalPadding: 7,
                  ),
                  // IF pembimbing kosong, pendaftar tidak bisa lihat
                  if (login.role == rolePendaftarValue &&
                      peserta!.namaPembimbing == null) ...[
                    const SizedBox(),
                  ] else
                    buildDataInfoField(
                      label: 'Nama Pembimbing',
                      value: peserta!.namaPembimbing ?? "-",
                      verticalPadding: 7,
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
                  children: [
                    Row(
                      children: [
                        _fileAndStatus(),
                        const SizedBox(width: 40),
                        _foto(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildDataInfoField(
                      label: "Link Wawancara",
                      value: peserta!.linkMeetInterview ?? "BELUM ADA LINK",
                      peringatan:
                          peserta!.linkMeetInterview == null ? true : false,
                    ),
                    if (peserta!.linkMeetInterview == null &&
                        login.role == rolePendaftarValue)
                      Text(
                        "Silahkan menunggu tim HR memberi link wawancara",
                        style: regular14.copyWith(color: Colors.grey),
                      ),
                    _buildAddLinkButton(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSkillPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDataInfoField(
                  label: 'Komunikasi',
                  value: likertStringValue(skill!.komunikasi),
                  verticalPadding: 3,
                ),
                buildDataInfoField(
                  label: 'Kreativitas',
                  value: likertStringValue(skill!.kreativitas),
                  verticalPadding: 3,
                ),
                buildDataInfoField(
                  label: 'Tanggung Jawab',
                  value: likertStringValue(skill!.tanggungJawab),
                  verticalPadding: 3,
                ),
                buildDataInfoField(
                  label: 'Kerja Sama',
                  value: likertStringValue(skill!.kerjaSama),
                  verticalPadding: 3,
                ),
                buildDataInfoField(
                  label: 'Skill Teknis',
                  value: likertStringValue(skill!.skillTeknis),
                  verticalPadding: 3,
                ),
                const SizedBox(height: 5),
                Center(child: Text('Proyek:', style: bold20)),
                const SizedBox(height: 3),
                _buildProyekField(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _fileAndStatus(),
                        const SizedBox(width: 40),
                        _foto(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    buildDataInfoField(
                      label: "Link Lampiran",
                      value: skill!.urlLampiran.isNotEmpty
                          ? skill!.urlLampiran
                          : "--Tidak ada lampiran--",
                    ),
                    if (skill!.urlLampiran.isNotEmpty)
                      RoundedRectangleButton(
                        title: "Buka Lampiran",
                        fontColor: Colors.white,
                        backgroundColor: japfaOrange,
                        height: 50.h,
                        onPressed: () => launchFullURLImagePath(
                            fullPath: skill!.urlLampiran),
                      )
                  ],
                ),
              ),
            ),
          )
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
        Text(
          peserta!.statusMagang,
          style: bold18.copyWith(
            color: getStatusMagangColor(peserta!.statusMagang),
          ),
        ),
        const SizedBox(height: 10),
        Text('NOTE:', style: bold14),
        Text(peserta!.catatanHr ?? 'Tidak ada catatan'),
      ],
    );
  }

  Widget _foto() {
    final img = '$baseUrl${peserta!.pathFotoDiri}';
    return Image.network(
      img,
      height: 275,
      width: 200,
      fit: BoxFit.cover,
      loadingBuilder: (c, child, p) =>
          p == null ? child : const CircularProgressIndicator(),
      errorBuilder: (c, _, __) => const Text('Failed to load image'),
    );
  }

  Widget _buildAddLinkButton() {
    return isAdmin
        ? Row(
            children: [
              RoundedRectangleButton(
                title: peserta!.linkMeetInterview == null
                    ? "Tambah Link"
                    : "Edit Link",
                height: 50.h,
                width: peserta!.linkMeetInterview == null ? 250.w : 200.w,
                rounded: 5,
                fontColor: Colors.white,
                backgroundColor: japfaOrange,
                onPressed: () => _showDialogAddLink(),
              ),
              if (peserta!.linkMeetInterview != null) ...[
                const SizedBox(width: 100),
                RoundedRectangleButton(
                  title: "Lihat Detail",
                  height: 50.h,
                  width: 200.w,
                  rounded: 5,
                  backgroundColor: lightBlue,
                  onPressed: () => _showMeetDetail(),
                )
              ]
            ],
          )
        // For peserta magang
        : Row(
            children: [
              if (peserta!.linkMeetInterview != null) ...[
                RoundedRectangleButton(
                  title: "Lihat Detail",
                  height: 50.h,
                  width: 250.w,
                  rounded: 5,
                  backgroundColor: lightBlue,
                  onPressed: () => _showMeetDetail(),
                )
              ]
            ],
          );
  }

  Widget _buildProyekField() {
    return Column(
      children: [
        // Check if there are any projects
        if (skill!.banyakProyek == 0) ...[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5), // Add vertical padding
            child: Text(
              'Tidak ada proyek',
              style: regular20.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ] else ...[
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skill!.banyakProyek,
            itemBuilder: (context, index) {
              // Check if the project exists in the list
              if (index < skill!.listProyek.length) {
                final project = skill!.listProyek[index];
                return buildDataInfoField(
                  label: 'Proyek ${index + 1}',
                  value: project,
                  verticalPadding: 3,
                );
              }
              return Container(); // Return an empty container if out of range
            },
          ),
        ]
      ],
    );
  }

  Widget _buildRejectAcceptButton() {
    final loginState = ref.watch(loginProvider);
    if (loginState.role == roleAdminValue) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedRectangleButton(
              title: 'Tolak',
              backgroundColor: Colors.red,
              fontColor: Colors.white,
              width: 100,
              height: 40,
              onPressed: () {
                _confirmReject(peserta!);
              }),
          const SizedBox(width: 20),
          RoundedRectangleButton(
              title: 'Terima',
              backgroundColor: Colors.green,
              fontColor: Colors.white,
              width: 100,
              height: 40,
              onPressed: () {
                _confirmAccept(peserta!);
              }),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildButtonForDiterimaOrDitolak() {
    final loginState = ref.watch(loginProvider);
    if (loginState.role != roleAdminValue) {
      return const SizedBox();
    }

    if (peserta!.statusMagang == statusMagangDitolak) {
      return RoundedRectangleButton(
        title: 'Menunggu',
        backgroundColor: japfaOrange,
        fontColor: Colors.white,
        width: 120,
        height: 40,
        onPressed: () => _updateStatus(peserta!.idMagang, statusMagangMenunggu),
      );
    } else if (peserta!.statusMagang == statusMagangDiterima) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedRectangleButton(
            title: 'Tolak',
            backgroundColor: Colors.red,
            fontColor: Colors.white,
            width: 120,
            height: 40,
            onPressed: () =>
                _updateStatus(peserta!.idMagang, statusMagangDitolak),
          ),
          const SizedBox(width: 10),
          RoundedRectangleButton(
            title: 'Set Pembimbing',
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            style: bold16,
            width: 150,
            height: 40,
            onPressed: () => _showSetPembimbingModal(peserta!),
          ),
          const SizedBox(width: 10),
          if (peserta!.namaPembimbing != null) ...[
            RoundedRectangleButton(
              title: 'Berlangsung',
              backgroundColor: lightBlue,
              fontColor: Colors.black54,
              style: bold16,
              width: 130,
              height: 40,
              onPressed: () =>
                  _updateStatus(peserta!.idMagang, statusMagangBerlangsung),
            ),
          ] else ...[
            RoundedRectangleButton(
                title: 'Berlangsung',
                backgroundColor: Colors.grey,
                fontColor: Colors.white,
                style: bold16,
                width: 130,
                height: 40,
                onPressed: () => showSnackBar(
                    context, "Mohon isi Nama Pembimbing Dahulu",
                    backgroundColor: darkGrey)),
          ]
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildTidakLanjutAndSelesaiButton() {
    final loginState = ref.watch(loginProvider);
    if (loginState.role != roleAdminValue) {
      return const SizedBox();
    }

    if (peserta!.statusMagang == statusMagangBerlangsung) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedRectangleButton(
            title: 'Tidak Lanjut',
            backgroundColor: Colors.red,
            fontColor: Colors.white,
            style: bold16,
            width: 140,
            height: 40,
            onPressed: () =>
                _updateStatus(peserta!.idMagang, statusMagangTidakLanjut),
          ),
          const SizedBox(width: 20),
          RoundedRectangleButton(
            title: 'Selesai',
            backgroundColor: darkGrey,
            fontColor: Colors.white,
            style: bold16,
            width: 130,
            height: 40,
            onPressed: () =>
                _updateStatus(peserta!.idMagang, statusMagangSelesai),
          ),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  //
  // VOID FUNCTIONS ------------
  //

  Future<void> _fetchPesertaAndSkillByEmail(String email) async {
    setState(() => isLoading = true);
    try {
      final dataPeserta = await ApiService()
          .pesertaMagangService
          .fetchPesertaMagangByEmail(email);

      final dataSkill =
          await ApiService().skillService.fetchSkillByEmail(email);
      setState(() {
        peserta = dataPeserta;
        skill = dataSkill;
      });
    } catch (error) {
      // Handle error here (e.g., show a message)
      print('Error fetching pengajuan data: $error');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _fetchSkillByEmail(String email) async {
    setState(() => isLoading = true);
    try {
      // TODO
      final dataSkill =
          await ApiService().skillService.fetchSkillByEmail(email);
      setState(() {
        skill = dataSkill;
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _confirmAccept(PesertaMagangData peserta) async {
    await showCustomConfirmAcceptDialogWithNote(
      context: context,
      title: 'Konfirmasi Terima ?',
      message: 'Berikan Konfirmasi',
      withNote: false,
      onAccept: (note) {
        if (note == null) {
          _updateStatus(peserta.idMagang, statusMagangDiterima);
        } else {
          _updateStatusWithNote(peserta, true, note);
        }
        ApiService().addLog(
          logUser: adminName ?? '',
          logTable: TableName.pesertaMagang.value,
          logKey: 'statusMagang',
          logKeyValue: statusMagangDiterima,
          logType: LogDataType.update.value,
          logDetail: 'Menerima peserta magang',
        );
      },
      onCancel: () {},
    );
  }

  void _confirmReject(PesertaMagangData peserta) async {
    await showCustomConfirmRejectDialogWithNote(
      context: context,
      title: 'Konfirmasi Ditolak ?',
      message: 'Berikan Konfirmasi',
      withNote: true,
      onCancel: () {},
      onReject: (note) {
        if (note == null) {
          _updateStatus(peserta.idMagang, statusMagangDitolak);
        } else {
          _updateStatusWithNote(peserta, false, note);
        }
        ApiService().addLog(
          logUser: adminName ?? '',
          logTable: TableName.pesertaMagang.value,
          logKey: 'statusMagang',
          logKeyValue: statusMagangDitolak,
          logType: LogDataType.update.value,
          logDetail: 'Menolak peserta magang',
        );
      },
    );
  }

  Future<void> _updateStatus(String id, String status) async {
    final upd = await ApiService()
        .pesertaMagangService
        .updatePesertaMagangStatus(id, status);
    if (upd != null) {
      // Send email with password token
      await ApiService().sendEmail(
        peserta!.email,
        peserta!.nama,
        peserta!.passwordToken!,
        EmailMessageType.statusMagang,
      );

      setState(() => peserta = upd);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Peserta updated: ${upd.nama}')),
      );
      if (widget.onUpdate != null) {
        widget.onUpdate!();
      }
    }
  }

  Future<void> _updateStatusWithNote(
    PesertaMagangData peserta,
    bool accepted,
    String note,
  ) async {
    setState(() {
      isLoading = true;
      peserta = peserta.copyWith(
        statusMagang: accepted ? statusMagangDiterima : statusMagangDitolak,
        catatanHr: note,
      );
    });
    try {
      await ApiService().pesertaMagangService.updatePesertaMagangStatusWithNote(
            idMagang: peserta.idMagang,
            status: peserta.statusMagang,
            catatanHr: note,
          );

      // Send email with password token
      await ApiService().sendEmail(
        peserta.email,
        peserta.nama,
        peserta.passwordToken!,
        EmailMessageType.statusMagang,
      );
      await _fetchPesertaAndSkillByEmail(peserta.email);

      if (widget.onUpdate != null) {
        widget.onUpdate!();
      }
    } catch (_) {
      setState(() {
        peserta = peserta.copyWith(statusMagang: 'Pending', catatanHr: null);
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMeetDetail() {
    catatanWawancaraController.text =
        peserta!.catatanHasilInterview ?? 'Belum ada catatan';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Detail Wawancara",
          numberOfField: 4,
          controllers: [
            tanggalMeetController,
            jamMeetController,
            linkMeetController,
            catatanWawancaraController,
          ],
          labels: const [
            "Tanggal Wawancara",
            "Jam Wawancara",
            "Link Wawancara",
            "Catatan Hasil Wawancara"
          ],
          viewValue: [
            peserta!.tanggalInterview!,
            peserta!.jamInterview!,
            peserta!.linkMeetInterview!,
            ''
          ],
          fieldTypes: const [
            BuildFieldTypeController.viewOnly,
            BuildFieldTypeController.viewOnly,
            BuildFieldTypeController.viewOnly,
            BuildFieldTypeController.multiLineText
          ],
          withCancelButton: true,
          saveButtonText: "Simpan Catatan",
          onSave: () => _saveCatatanHasilInterview(),
        );
      },
    );
  }

  void _showDialogAddLink() {
    tanggalMeetController.text = peserta!.tanggalInterview ?? '';
    jamMeetController.text = peserta!.jamInterview ?? '';
    linkMeetController.text = peserta!.linkMeetInterview ?? '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title:
              peserta!.linkMeetInterview == null ? "Tambah Link" : "Edit Link",
          numberOfField: 3,
          controllers: [
            tanggalMeetController,
            jamMeetController,
            linkMeetController,
          ],
          labels: const [
            "Tanggal Wawancaran",
            "Jam Wawancara",
            "Link Wawancara"
          ],
          fieldTypes: const [
            BuildFieldTypeController.date,
            BuildFieldTypeController.text,
            BuildFieldTypeController.text,
          ],
          onSave: () => _saveMeet(),
        );
      },
    );
  }

  void _saveMeet() async {
    final String tanggalMeet = tanggalMeetController.text;
    final String jamMeet = jamMeetController.text.trim();
    final String linkMeet = linkMeetController.text.trim();

    final String id = peserta?.idMagang ?? '';

    if (id.isNotEmpty && linkMeet.isNotEmpty) {
      await ApiService().pesertaMagangService.updateLinkMeet(
            id,
            linkMeet,
            tanggalMeet,
            jamMeet,
          );
      // Send email with password token
      await ApiService().sendEmail(
        peserta!.email,
        peserta!.nama,
        peserta!.passwordToken!,
        EmailMessageType.tambahLinkMeet,
      );

      // Clear the controller after saving
      linkMeetController.clear();
      Navigator.of(context).pop(); // Close the dialog after saving
    } else {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID and Link Wawancara are required.')),
      );
    }

    setState(() {
      peserta = peserta!.copyWith(linkMeetInterview: linkMeet);
    });
    _fetchPesertaAndSkillByEmail(peserta!.email);
  }

  void _saveCatatanHasilInterview() async {
    final String catatanHasilInterview = catatanWawancaraController.text.trim();
    final String id = peserta?.idMagang ?? '';

    if (id.isNotEmpty && catatanHasilInterview.isNotEmpty) {
      try {
        await ApiService()
            .pesertaMagangService
            .updateCatatanHasilInterview(id, catatanHasilInterview);

        // Clear the controller after saving
        catatanWawancaraController.clear();
        Navigator.of(context).pop(); // Close the dialog after saving

        // Optional: Notify the user about success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Catatan hasil wawancara berhasil disimpan.')),
        );
      } catch (error) {
        // Handle the error, e.g., show a message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan catatan: $error')),
        );
      }
    } else {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID and catatan are required.')),
      );
    }

    // Optionally update the local data or state
    setState(() {
      peserta = peserta!.copyWith(catatanHasilInterview: catatanHasilInterview);
    });
  }

  void _showSetPembimbingModal(PesertaMagangData peserta) async {
    TextEditingController selectedPembimbingName = TextEditingController();
    List<String> listNamaPembimbing = await fetchKepalaDepartemenNames();
    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: 'Set Pembimbing',
          subTitle: '',
          controllers: [selectedPembimbingName],
          labels: const ['Nama Pembimbing'],
          fieldTypes: const [BuildFieldTypeController.dropdown],
          dropdownOptions: listNamaPembimbing,
          numberOfField: 1,
          onSave: () {
            _updateNamaPembimbing(
              peserta.idMagang,
              selectedPembimbingName.text,
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<List<String>> fetchKepalaDepartemenNames() async {
    try {
      // Fetch all Kepala Departemen data
      List<KepalaDepartemenData> kepalaDepartemenList =
          await ApiService().kepalaDepartemenService.fetchAllKepalaDepartemen();

      // Extract the names and return them as a list of strings
      return kepalaDepartemenList.map((kepala) => kepala.nama).toList();
    } catch (error) {
      print('Error fetching kepala departemen names: $error');
      rethrow; // Rethrow the error for further handling if needed
    }
  }

  Future<void> _updateNamaPembimbing(String id, String namaPembimbing) async {
    try {
      await ApiService()
          .pesertaMagangService
          .updateNamaPembimbing(id, namaPembimbing);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nama Pembimbing updated: $namaPembimbing')),
      );
      _fetchPesertaAndSkillByEmail(peserta!.email);
    } catch (error) {
      print('Error updating nama pembimbing: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update Nama Pembimbing.')),
      );
    }
  }
}
