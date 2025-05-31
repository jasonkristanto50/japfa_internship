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
import 'package:japfa_internship/home_page.dart';
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
  bool _loading = false;
  late bool isAdmin;
  TextEditingController tanggalMeetController = TextEditingController();
  TextEditingController jamMeetController = TextEditingController();
  TextEditingController linkMeetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    peserta = widget.peserta;

    final login = ref.read(loginProvider);
    if (login.role == roleAdminValue) {
      isAdmin = true;
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
        height: 675,
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

  // WIDGET Functions

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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDataInfoField(
                    label: 'Komunikasi',
                    value: likertStringValue(skill!.komunikasi),
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Kreativitas',
                    value: likertStringValue(skill!.kreativitas),
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Tanggung Jawab',
                    value: likertStringValue(skill!.tanggungJawab),
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Kerja Sama',
                    value: likertStringValue(skill!.kerjaSama),
                    verticalPadding: 5,
                  ),
                  buildDataInfoField(
                    label: 'Skill Teknis',
                    value: likertStringValue(skill!.skillTeknis),
                    verticalPadding: 5,
                  ),
                  const SizedBox(height: 10),
                  Text('Proyek:', style: bold20),
                  _buildProyekField(),
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
                  verticalPadding: 5,
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
            onPressed: () => _confirmReject(peserta!),
          ),
          const SizedBox(width: 20),
          RoundedRectangleButton(
            title: 'Terima',
            backgroundColor: Colors.green,
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
            title: 'Menunggu',
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            style: bold16,
            width: 120,
            height: 40,
            onPressed: () =>
                _updateStatus(peserta!.idMagang, statusMagangMenunggu),
          ),
          const SizedBox(width: 10),
          RoundedRectangleButton(
            title: 'Set Pembimbing',
            backgroundColor: Colors.white,
            fontColor: japfaOrange,
            outlineColor: japfaOrange,
            style: bold16,
            width: 150,
            height: 40,
            onPressed: () => _showSetPembimbingModal(peserta!),
          ),
          const SizedBox(width: 10),
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
            width: 120,
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
    setState(() => _loading = true);
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
      setState(() => _loading = false);
    }
  }

  Future<void> _fetchSkillByEmail(String email) async {
    setState(() => _loading = true);
    try {
      // TODO
      final dataSkill =
          await ApiService().skillService.fetchSkillByEmail(email);
      setState(() {
        skill = dataSkill;
      });
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
      onAccept: (note) {
        if (note == null) {
          _updateStatus(peserta.idMagang, statusMagangDiterima);
        } else {
          _updateStatusWithNote(peserta, true, note);
        }
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
      },
    );
  }

  Future<void> _updateStatus(String id, String status) async {
    final upd = await ApiService()
        .pesertaMagangService
        .updatePesertaMagangStatus(id, status);
    if (upd != null) {
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
      PesertaMagangData p, bool accepted, String note) async {
    setState(() {
      peserta = p.copyWith(
        statusMagang: accepted ? statusMagangDiterima : statusMagangDitolak,
        catatanHr: note,
      );
    });
    try {
      await ApiService().pesertaMagangService.updatePesertaMagangStatusWithNote(
            idMagang: p.idMagang,
            status: peserta!.statusMagang,
            catatanHr: note,
          );
      if (widget.onUpdate != null) {
        widget.onUpdate!();
      }
    } catch (_) {
      setState(() {
        peserta = p.copyWith(statusMagang: 'Pending', catatanHr: null);
      });
    }
  }

  void _showMeetDetail() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Detail Wawancara",
          numberOfField: 3,
          controllers: [
            tanggalMeetController,
            jamMeetController,
            linkMeetController
          ],
          labels: const [
            "Tanggal Wawancaran",
            "Jam Wawancara",
            "Link Wawancara"
          ],
          viewValue: [
            peserta!.tanggalInterview!,
            peserta!.jamInterview!,
            peserta!.linkMeetInterview!
          ],
          fieldTypes: const [
            BuildFieldTypeController.viewOnly,
            BuildFieldTypeController.viewOnly,
            BuildFieldTypeController.viewOnly
          ],
          saveButtonText: "Kembali",
          onSave: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void _showDialogAddLink() {
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
            linkMeetController
          ],
          labels: const [
            "Tanggal Wawancaran",
            "Jam Wawancara",
            "Link Wawancara"
          ],
          fieldTypes: const [
            BuildFieldTypeController.date,
            BuildFieldTypeController.text,
            BuildFieldTypeController.text
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
