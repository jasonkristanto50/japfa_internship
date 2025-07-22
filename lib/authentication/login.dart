import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/authentication/otp_screen.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/navbar.dart';
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

  String otpNumber = '';

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
              child: _isTokenLogin
                  ? buildTokenLoginForm(loginState)
                  : buildLoginPasswordForm(loginState),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginPasswordForm(LoginState loginState) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Login Admin & Kepala Dept',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        buildTextField('Email', _emailController, isMobile: isMobile),
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
    bool isMobile = isScreenMobile(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Similar header code for Token Login
        const Text(
          'Login Pendaftar Magang / Kunjungan',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        buildTextField('Email', _emailController, isMobile: isMobile),
        const SizedBox(height: 15),

        PasswordToggleTextField(
          label: 'Token',
          controller: _tokenController,
        ),
        const SizedBox(height: 20),
        if (loginState.isLoading) const CircularProgressIndicator(),
        if (!loginState.isLoading)
          RoundedRectangleButton(
            title: "Login",
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            onPressed: _tokenLoginFunction,
          ),
        if (loginState.errorMessage != null)
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
            "Login Admin & Kepala Dept ? Klik Disini",
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
          LoginState(errorMessage: "Tolong isi semua data");
      return;
    }

    await ref
        .read(loginProvider.notifier)
        .loginPassword(email: email, password: password);

    sendEmailOTP(email, '');
    print("KODE OTP : $otpNumber");

    fadeNavigation(
      context,
      targetNavigation: OtpScreen(
        email: email,
        password: password,
        kodeOTP: otpNumber,
        isToken: false,
      ),
    );

    // _handleLoginResponse();
  }

  Future<void> _tokenLoginFunction() async {
    String email = _emailController.text.trim();
    String token = _tokenController.text.trim();

    if (email.isEmpty || token.isEmpty) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      ref.read(loginProvider.notifier).state =
          LoginState(errorMessage: "Tolong isi semua data");
      return;
    }

    await ref
        .read(loginProvider.notifier)
        .loginToken(email: email, passwordToken: token);

    sendEmailOTP(email, '');
    print("KODE OTP : $otpNumber");

    fadeNavigation(
      context,
      targetNavigation: OtpScreen(
        email: email,
        password: token,
        kodeOTP: otpNumber,
        isToken: true,
      ),
    );
  }

  void sendEmailOTP(String email, String name) async {
    setState(() {
      otpNumber = generateRandomOTPNumber();
    });
    // Send Email OTP
    await ApiService().sendEmail(
      email,
      name,
      otpNumber,
      EmailMessageType.kirimOtp,
    );
  }
}
