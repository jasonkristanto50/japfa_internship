import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/admin_page/departemen_magang_dashboard.dart';
import 'package:japfa_internship/admin_page/pendaftaran_magang_detail_page.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/kepala_departemen_page/dashboard_pembimbing_magang.dart';
import 'package:japfa_internship/pendaftar_submission_page/kunjungan_studi_detail_page.dart';
import 'package:japfa_internship/peserta_magang_page/logbook_peserta.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'login_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();

  bool _visible = false;
  bool _isTokenLogin = true; // First page is token login

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider); // Watch login state
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
        showBackButton: isMobile ? false : true,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Center(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(20),
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
              child: _isTokenLogin
                  ? buildTokenLoginForm(loginState)
                  : buildLoginForm(loginState),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(LoginState loginState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Login Admin & User',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        buildTextField('Email', _emailController),
        const SizedBox(height: 15),
        PasswordToggleTextField(
          label: 'Password',
          controller: _passwordController,
        ),
        const SizedBox(height: 20),
        if (loginState.isLoading) const CircularProgressIndicator(),
        if (!loginState.isLoading)
          RoundedRectangleButton(
            title: "Login",
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            onPressed: _loginFunction,
          ),
        if (loginState.errorMessage != null)
          showErrorMessage(loginState.errorMessage!),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            setState(() {
              _isTokenLogin = true;
            });
          },
          child: Text(
            "Masuk pendaftar Magang / Kunjungan ? Klik Disini",
            style: TextStyle(color: japfaOrange, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget buildTokenLoginForm(LoginState loginState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Similar header code for Token Login
        const Text(
          'Login Pendaftar Magang / Kunjungan',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        buildTextField('Email', _emailController),
        const SizedBox(height: 15),
        PasswordToggleTextField(
          label: 'Token',
          controller: _tokenController,
        ),
        const SizedBox(height: 20),
        if (loginState.isLoading) // Show loading indicator
          const CircularProgressIndicator(),
        if (!loginState.isLoading) // Show button only if not loading
          RoundedRectangleButton(
            title: "Login",
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            onPressed: _tokenLoginFunction,
          ),
        if (loginState.errorMessage != null) // Display error
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              loginState.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            setState(() {
              _isTokenLogin = false; // Switch back to password login
            });
          },
          child: Text(
            "Masuk sebagai Admin & User ? Klik Disini",
            style: TextStyle(color: japfaOrange, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget showErrorMessage(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Future<void> _loginFunction() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      ref.read(loginProvider.notifier).state =
          LoginState(errorMessage: "Please fill in all fields");
      return;
    }

    await ref
        .read(loginProvider.notifier)
        .loginPassword(email: email, password: password);

    _handleLoginResponse();
  }

  Future<void> _tokenLoginFunction() async {
    String email = _emailController.text.trim();
    String token = _tokenController.text.trim();

    if (email.isEmpty || token.isEmpty) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      ref.read(loginProvider.notifier).state =
          LoginState(errorMessage: "Please fill in all fields");
      return;
    }

    await ref
        .read(loginProvider.notifier)
        .loginToken(email: email, passwordToken: token);

    _handleLoginResponse();
  }

  void _handleLoginResponse() {
    final currentState = ref.read(loginProvider);

    // Check if logged in after the state is updated
    if (currentState.isLoggedIn) {
      // Determine navigation based on status
      if (currentState.statusMagang != null &&
          currentState.statusMagang != statusMagangBerlangsung) {
        // Navigate to Detail Magang if status magang is found
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PendaftaranMagangDetailPage(),
          ),
        );
      } else if (currentState.statusKunjungan != null) {
        // Navigate to Detail Kunjungan if status kunjungan is found
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const KunjunganStudiDetailPage(),
          ),
        );
      } else {
        // Default navigation by role if no specific status is found
        switch (currentState.role) {
          case 'admin':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DepartemenMagangDashboard(),
              ),
            );
            break;
          case 'pendaftar':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
            break;
          case 'peserta magang':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LogBookPesertaDashboard(),
              ),
            );
            break;
          case 'kepala departemen':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardPembimbingMagang(),
              ),
            );
            break;
          default:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
            break;
        }
      }
    }
  }
}
