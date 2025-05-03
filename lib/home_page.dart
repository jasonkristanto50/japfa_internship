import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/department_card.dart';
import 'package:japfa_internship/authentication/login.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/pendaftar_submission_page/submission_study.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
        titleOnPressed: _scrollToTop,
        onLoginPressed: _navigateToLogin,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Column(
                children: [
                  if (loginState.role == "admin") ...[
                    _blurBackground(),
                  ] else ...[
                    _buildBackgroundBlurImage(),
                    const SizedBox(height: 50),
                  ]
                ],
              ),
              // DEPARTMENT CARD SECTION
              Padding(
                padding: const EdgeInsets.fromLTRB(150, 50, 150, 20),
                child: Column(
                  children: [
                    const Text(
                      'Department List',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 50),
                    buildCardDepartment()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _blurBackground() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Container(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildBackgroundBlurImage() {
    // Full-Height Login Section with Blurry Background
    return SizedBox(
      height: MediaQuery.of(context).size.height, // Full height of the screen
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              japfaBuduranImgPath,
              fit: BoxFit.cover,
            ),
          ),
          // Blurry Effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          _buildWelcomeContainer()
        ],
      ),
    );
  }

  Widget _buildWelcomeContainer() {
    final isLogin = ref.watch(loginProvider).isLoggedIn;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        // No fixed constraints, allow the content to dictate size
        width: 350, // Set a width if needed for consistency
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure the column size is minimum
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang ke Japfa Internship',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Reduced height for spacing
            if (!isLogin) ...[
              // Login Button
              RoundedRectangleButton(
                title: 'Login',
                style: regular20,
                fontColor: japfaOrange,
                backgroundColor: Colors.white,
                outlineColor: japfaOrange,
                onPressed: _navigateToLogin,
              ),
              const SizedBox(height: 20),
            ],
            // New Kunjungan Studi Button
            RoundedRectangleButton(
              title: 'Kunjungan Studi',
              style: regular20,
              fontColor: Colors.white,
              backgroundColor: japfaOrange,
              onPressed: kunjunganStudiOnPressed,
            ),
            const SizedBox(height: 20),
            // List Departemen Button
            RoundedRectangleButton(
              title: 'Daftar Magang',
              style: regular20,
              fontColor: Colors.white,
              backgroundColor: japfaOrange,
              onPressed: scrollToCard,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardDepartment() {
    final loginState = ref.watch(loginProvider);

    return FutureBuilder<List<DepartemenData>>(
      future: ApiService().fetchDepartemenDataUpdateCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          var department = snapshot.data!;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1,
              crossAxisSpacing: 100,
              mainAxisSpacing: 50,
            ),
            itemCount: department.length,
            itemBuilder: (context, index) {
              return DepartmentCard(
                title: department[index].namaDepartemen,
                sisaKuota: department[index].sisaKuota ?? 0,
                jumlahPengajuan: department[index].jumlahPengajuan ?? 0,
                description:
                    department[index].deskripsi ?? 'Tidak ada Deskripsi',
                image: department[index].pathImage,
                requirements:
                    department[index].syaratDepartemen ?? ['Tidak ada syarat'],
                isAdmin: loginState.role == "admin",
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  // Function to scroll to top
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Function croll to card
  void scrollToCard() {
    _scrollController.animateTo(
      850, // Adjust this value to match the position of the Card section
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void kunjunganStudiOnPressed() {
    final isLoggedIn = ref.read(loginProvider).isLoggedIn;
    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (context) => CustomLoginDialog(
          onLoginPressed: () {
            fadeNavigation(context, targetNavigation: const LoginScreen());
          },
        ),
      );
    } else {
      // If already login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SubmissionStudy()),
      );
    }
  }
}
