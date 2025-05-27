import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/admin_page/departemen_magang_dashboard.dart';
import 'package:japfa_internship/admin_page/kunjungan_studi_dashboard.dart';
import 'package:japfa_internship/admin_page/list_all_peserta_magang.dart';
import 'package:japfa_internship/admin_page/pendaftaran_magang_detail_page.dart';
import 'package:japfa_internship/admin_page/tambah_kepala_departemen.dart';
import 'package:japfa_internship/authentication/login.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/kepala_departemen_page/dashboard_pembimbing_magang.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/pendaftar_submission_page/kunjungan_studi_detail_page.dart';
import 'package:japfa_internship/pendaftar_submission_page/timeline_interview.dart';
import 'package:japfa_internship/peserta_magang_page/laporan_peserta_magang.dart';
import 'package:japfa_internship/peserta_magang_page/logbook_peserta.dart';
import 'package:japfa_internship/profile_page.dart';

// ignore: must_be_immutable
class Navbar extends ConsumerWidget implements PreferredSizeWidget {
  BuildContext context;
  final String title;
  final VoidCallback? titleOnPressed;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onSubmissionPressed;
  final VoidCallback? onTimelinePressed;
  final VoidCallback? onAdminDataPendaftarMagang;
  final VoidCallback? onAdminHomePageMagang;
  final VoidCallback? onAdminKunjunganStudi;
  final VoidCallback? onLogoutPressed;
  final PesertaMagangData? peserta;
  final KunjunganStudiData? kunjungan;
  final bool showBackButton;

  Navbar({
    required this.context,
    required this.title,
    this.titleOnPressed,
    this.onLoginPressed,
    this.onSubmissionPressed,
    this.onTimelinePressed,
    this.onAdminDataPendaftarMagang,
    this.onAdminHomePageMagang,
    this.onAdminKunjunganStudi,
    this.onLogoutPressed,
    this.peserta,
    this.kunjungan,
    this.showBackButton = false, // Default to false
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 57, 57, 57),
      ),
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                // Conditionally show back button
                if (showBackButton)
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous page
                    },
                  ),
                TextButton(
                  onPressed: () =>
                      titleOnPressed ?? _titleNavigateToHomePage(ref),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                // For mobile, show the hamburger icon instead of tabs
                if (isMobile) ...[
                  if (loginState.isLoggedIn)
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => _showMenu(context, ref),
                    ),
                ] else ...[
                  // For desktop, render navigation tabs based on login state
                  if (!loginState.isLoggedIn) ...[
                    buildNavBarTab("My Submission", _navigateToSubmissionData),
                    buildNavBarTab("Timeline", _navigateToTimeLine),
                    const SizedBox(width: 10),
                    buildLoginBotton(),
                  ] else ...[
                    // Logged in => Check role
                    if (loginState.role == roleAdminValue) ...[
                      buildNavBarTab(
                        "Semua Peserta Magang",
                        _navigateToListAllPesertaMagang,
                      ),
                      buildNavBarTab(
                        'Data Pendaftar Magang',
                        _navigateToDepartemenPendaftaranMagangPage,
                      ),
                      buildNavBarTab(
                        'Kunjungan Studi',
                        _navigateToAdminKunjunganStudiPage,
                      ),
                      buildNavBarTab(
                        'Tambah Pembimbing',
                        _navigateToTambahKepalaDept,
                      ),
                      buildNavBarTab(
                        'Home Page Magang',
                        _navigateToHomePageMagang,
                      ),
                    ] else if (loginState.role == rolePesertaMagangValue) ...[
                      buildNavBarTab("Detail Diri", _navigateToDetailPage),
                      buildNavBarTab("Logbook", _navigateToLogbookPage),
                      buildNavBarTab("Laporan", _navigateToLaporanPage),
                    ] else if (loginState.role == roleKepalaDeptValue) ...[
                      buildNavBarTab(
                        "Data Peserta",
                        _navigateToPembimbingDashboard,
                      ),
                      buildNavBarTab(
                        "Departemen",
                        _navigateToHomePageMagang,
                      ),
                    ] else if (loginState.role == rolePendaftarValue) ...[
                      buildNavBarTab(
                          "Pengajuan Magang", _navigateToSubmissionData),
                      buildNavBarTab(
                          "Pengajuan Kunjungan", _navigateToKunjunganData),
                      buildNavBarTab("Timeline", _navigateToTimeLine),
                    ],
                    const SizedBox(width: 16),
                    // Profile Pop Up
                    buildProfileIcon(ref),
                  ],
                ],
              ],
            ),
          ),
          Container(height: 2, color: Colors.white),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);

  Widget buildNavBarTab(String title, void Function()? onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildProfileIcon(WidgetRef ref) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'logout') {
          _logOutFunction(context, ref);
        } else if (value == 'profile') {
          _navigateToProfilePage();
        }
      },
      icon: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            'assets/default_profile.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
      offset: const Offset(-30, 50),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'profile',
            child: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.black),
                  SizedBox(width: 10),
                  Text('Profile')
                ],
              ),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'logout',
            child: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.black),
                  SizedBox(width: 10),
                  Text('Log Out')
                ],
              ),
            ),
          ),
        ];
      },
    );
  }

  void _showMenu(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

    List<PopupMenuEntry<String>> menuItems = [];

    if (loginState.isLoggedIn) {
      if (loginState.role == roleAdminValue) {
        menuItems.add(const PopupMenuItem<String>(
          value: 'home',
          child: Text('Home Page Magang'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'dataPendaftar',
          child: Text('Data Pendaftar Magang'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'kunjungan',
          child: Text('Kunjungan Studi'),
        ));
      } else if (loginState.role == rolePesertaMagangValue) {
        menuItems.add(const PopupMenuItem<String>(
          value: 'detailDiri',
          child: Text('Detail Diri'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'logbook',
          child: Text('Logbook'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'laporan',
          child: Text('Laporan'),
        ));
      } else if (loginState.role == roleKepalaDeptValue) {
        menuItems.add(const PopupMenuItem<String>(
          value: 'logbook',
          child: Text('Logbook'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'dataPeserta',
          child: Text('Data Peserta'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'departemen',
          child: Text('Departemen'),
        ));
      } else if (loginState.role == rolePendaftarValue) {
        menuItems.add(const PopupMenuItem<String>(
          value: 'pengajuanMagang',
          child: Text('Pengajuan Magang'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'pengajuanKunjungan',
          child: Text('Pengajuan Kunjungan'),
        ));
        menuItems.add(const PopupMenuItem<String>(
          value: 'timeline',
          child: Text('Timeline'),
        ));
      }

      menuItems.add(const PopupMenuItem<String>(
        value: 'logout',
        child: Text('Log Out'),
      ));

      showMenu(
        context: context,
        position: const RelativeRect.fromLTRB(100.0, 100.0, 100.0, 0.0),
        items: menuItems,
      ).then((value) {
        if (value != null) {
          switch (value) {
            case 'home':
              _navigateToHomePageMagang();
              break;
            case 'dataPendaftar':
              _navigateToDepartemenPendaftaranMagangPage();
              break;
            case 'kunjungan':
              _navigateToAdminKunjunganStudiPage();
              break;
            case 'detailDiri':
              _navigateToDetailPage();
              break;
            case 'logbook':
              _navigateToLogbookPage();
              break;
            case 'laporan':
              _navigateToLaporanPage();
              break;
            case 'dataPeserta':
              _navigateToPembimbingDashboard();
              break;
            case 'departemen':
              _navigateToHomePageMagang();
              break;
            case 'pengajuanMagang':
              _navigateToSubmissionData();
              break;
            case 'pengajuanKunjungan':
              _navigateToKunjunganData();
              break;
            case 'timeline':
              _navigateToTimeLine();
              break;
            case 'logout':
              _logOutFunction(context, ref);
              break;
          }
        }
      });
    }
  }

  Widget buildLoginBotton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
        onPressed: onLoginPressed ?? _navigateToLogin,
        style: TextButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
        ),
        child: const Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _titleNavigateToHomePage(WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    switch (loginState.role) {
      case "pendaftar":
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MyHomePage()),
          (route) => false,
        );
        break;
      case "admin":
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const DepartemenMagangDashboard()),
          (route) => false,
        );
        break;
      default:
        // Handle any other roles or errors as necessary
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const MyHomePage()),
          (route) => false,
        );
        break;
    }
  }

  void _navigateToProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  // NOT LOGIN
  void _navigateToSubmissionData() {
    fadeNavigation(context,
        targetNavigation: PendaftaranMagangDetailPage(peserta: peserta));
  }

  void _navigateToKunjunganData() {
    fadeNavigation(context, targetNavigation: const KunjunganStudiDetailPage());
  }

  void _navigateToTimeLine() {
    fadeNavigation(context, targetNavigation: const TimelineInterview());
  }

  // ADMIN HR/GA TAB ---------------------------------------------------
  void _navigateToDepartemenPendaftaranMagangPage() {
    fadeNavigation(
      context,
      targetNavigation: const DepartemenMagangDashboard(),
      time: 200,
    );
  }

  void _navigateToListAllPesertaMagang() {
    fadeNavigation(
      context,
      targetNavigation: const ListAllPesertaMagang(),
      time: 200,
    );
  }

  void _navigateToTambahKepalaDept() {
    fadeNavigation(
      context,
      targetNavigation: const TambahKepalaDepartemen(),
      time: 200,
    );
  }

  void _navigateToHomePageMagang() {
    fadeNavigation(context, targetNavigation: const MyHomePage(), time: 200);
  }

  void _navigateToAdminKunjunganStudiPage() {
    fadeNavigation(context,
        targetNavigation: const KunjunganStudiDashboard(), time: 200);
  }

  // PESERTA MAGANG TAB
  void _navigateToDetailPage() {
    fadeNavigation(
      context,
      targetNavigation: const PendaftaranMagangDetailPage(),
      time: 200,
    );
  }

  void _navigateToLogbookPage() {
    fadeNavigation(context,
        targetNavigation: const LogBookPesertaDashboard(), time: 200);
  }

  void _navigateToLaporanPage() {
    // Navigate to Laporan Page
    fadeNavigation(context,
        targetNavigation: const LaporanPesertaMagang(), time: 200);
  }

  void _logOutFunction(BuildContext context, WidgetRef ref) {
    ref.read(loginProvider.notifier).logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(), // Your HomePage
      ),
      (route) => false,
    );
  }

  // KEPALA DEPARTEMEN TAB

  void _navigateToPembimbingDashboard() {
    fadeNavigation(context,
        targetNavigation: const DashboardPembimbingMagang(), time: 200);
  }
}
