import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/admin_page/pendaftar_magang_dashboard.dart';
import 'package:japfa_internship/admin_page/kunjungan_studi_dashboard.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/home_page.dart';

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
                TextButton(
                  onPressed: titleOnPressed,
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
                  if (loginState.role == "user") ...[
                    buildNavBarTab("Submission", onSubmissionPressed),
                    buildNavBarTab("Timeline", onTimelinePressed)
                  ] else if (loginState.role == "admin") ...[
                    // Admin Navbar
                    buildNavBarTab('Data Pendaftar Magang',
                        _navigateToDataPendaftaranMagangPage),
                    buildNavBarTab(
                        'Home Page Magang', _navigateToHomePageMagang),
                    buildNavBarTab(
                        'Kunjungan Studi', _navigateToAdminKunjunganStudiPage),
                  ],
                  const SizedBox(width: 16),
                  // Common Logout Menu
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'logout') {
                        _logOutFunction(context, ref);
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
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.black),
                              SizedBox(width: 10),
                              Text('Logout'),
                            ],
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

  void _navigateToDataPendaftaranMagangPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PendaftarMagangDashboard()),
    );
  }

  void _navigateToHomePageMagang() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  }

  void _navigateToAdminKunjunganStudiPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const KunjunganStudiDashboard()),
    );
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
