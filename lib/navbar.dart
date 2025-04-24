import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/admin_page/pendaftar_magang_dashboard.dart';
import 'package:japfa_internship/admin_page/kunjungan_studi_dashboard.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/peserta_magang_page/logbook_peserta.dart';
import 'package:japfa_internship/peserta_magang_page/pembimbing_peserta.dart';
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
    this.showBackButton = false, // Default to false
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);

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
                if (!loginState.isLoggedIn) ...[
                  // Not logged in yet => Show "Login" Button
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextButton(
                      onPressed: onLoginPressed,
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
                  ),
                ] else ...[
                  // Logged in => Check role
                  // PENDAFTAR Navbar
                  if (loginState.role == "pendaftar") ...[
                    buildNavBarTab("Submission", onSubmissionPressed),
                    buildNavBarTab("Timeline", onTimelinePressed)
                  ] else if (loginState.role == "admin") ...[
                    // ADMIN Navbar
                    buildNavBarTab(
                        'Home Page Magang', _navigateToHomePageMagang),
                    buildNavBarTab('Data Pendaftar Magang',
                        _navigateToDataPendaftaranMagangPage),
                    buildNavBarTab(
                        'Kunjungan Studi', _navigateToAdminKunjunganStudiPage),
                  ] else if (loginState.role == "peserta magang") ...[
                    // PESERTA MAGANG Navbar
                    buildNavBarTab("Detail", _navigateToDetailPage),
                    buildNavBarTab("Pembimbing", _navigateToPembimbingPage),
                    buildNavBarTab("Logbook", _navigateToLogbookPage),
                    buildNavBarTab("Laporan", _navigateToLaporanPage),
                  ],
                  const SizedBox(width: 16),

                  // PROFILE Pop Up
                  PopupMenuButton<String>(
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
                  ),
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
              builder: (context) => const PendaftarMagangDashboard()),
          (route) => false,
        );
        break;
      default:
        // Handle any other roles or errors as necessary
        break;
    }
  }

  void _navigateToProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  // ADMIN HR/GA TAB
  void _navigateToDataPendaftaranMagangPage() {
    fadeNavigation(context, targetNavigation: const PendaftarMagangDashboard());
  }

  void _navigateToHomePageMagang() {
    fadeNavigation(context, targetNavigation: const MyHomePage());
  }

  void _navigateToAdminKunjunganStudiPage() {
    fadeNavigation(context, targetNavigation: const KunjunganStudiDashboard());
  }

  // PESERTA MAGANG TAB
  void _navigateToDetailPage() {
    // Navigate to Detail Page
  }

  void _navigateToPembimbingPage() {
    fadeNavigation(context,
        targetNavigation: const PembimbingPesertaDashboard(), time: 200);
  }

  void _navigateToLogbookPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LogBookPesertaDashboard()),
    );
  }

  void _navigateToLaporanPage() {
    // Navigate to Laporan Page
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
}
