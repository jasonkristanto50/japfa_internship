import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/admin_page/departemen_magang_dashboard.dart';
import 'package:japfa_internship/admin_page/pendaftaran_magang_detail_page.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/kepala_departemen_page/dashboard_pembimbing_magang.dart';
import 'package:japfa_internship/pendaftar_submission_page/kunjungan_studi_detail_page.dart';
import 'package:japfa_internship/peserta_magang_page/logbook_peserta.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/views/home_page.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'login_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;
  final String kodeOTP;
  final bool isToken;

  const OtpScreen({
    super.key,
    required this.email,
    required this.password,
    required this.kodeOTP,
    required this.isToken,
  });

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  bool _visible = false;

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    bool isMobile = isScreenMobile(context);

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
                child: buildOTPForm(loginState)),
          ),
        ),
      ),
    );
  }

  Widget buildOTPForm(LoginState loginState) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Masukkan kode OTP',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        buildTextField('OTP', otpController, isMobile: isMobile),
        const SizedBox(height: 20),
        if (loginState.isLoading) const CircularProgressIndicator(),
        if (!loginState.isLoading)
          RoundedRectangleButton(
            title: "Cek OTP",
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            onPressed: validateOTP,
          ),
        if (loginState.errorMessage != null)
          showErrorMessage(loginState.errorMessage!),
        const SizedBox(height: 10),
        Text(
          "Kode OTP dikirimkan melalui email anda",
          style: TextStyle(color: japfaOrange, fontSize: 14),
        ),
      ],
    );
  }

  Future<void> validateOTP() async {
    String otpInput = otpController.text.trim();

    if (otpInput.isEmpty) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      ref.read(loginProvider.notifier).state =
          LoginState(errorMessage: "Tolong isi semua data");
      return;
    }

    if (otpInput == widget.kodeOTP) {
      // Login password (admin)
      if (widget.isToken == false) {
        await ref
            .read(loginProvider.notifier)
            .loginPassword(email: widget.email, password: widget.password);
      }
      // Login token (pendaftar magang)
      else {
        await ref
            .read(loginProvider.notifier)
            .loginToken(email: widget.email, passwordToken: widget.password);
      }

      _handleLoginResponse();
    } else {
      showSnackBar(context, "Kode OTP salah, mohon isi dengan benar");
    }
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

  Widget showErrorMessage(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
