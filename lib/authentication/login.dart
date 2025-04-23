import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/admin_page/pendaftar_magang_dashboard.dart';
import 'package:japfa_internship/peserta_magang_page/logbook_peserta.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/authentication/sign_up.dart';
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider); // Watch login state

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
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
              child: buildLoginForm(loginState),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 65),
            const Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Login to your account.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        buildTextField('Email', _emailController),
        const SizedBox(height: 15),
        buildTextField(
          'Password',
          _passwordController,
          isPassword: true,
        ),
        const SizedBox(height: 20),
        if (loginState.isLoading) // Show loading indicator
          const CircularProgressIndicator(),
        if (!loginState.isLoading) // Show button only if not loading
          RoundedRectangleButton(
            title: "Login",
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            onPressed: _loginFunction,
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
            fadeNavigation(context, targetNavigation: const SignUp());
          },
          child: Text(
            "Don't have an account? Sign up",
            style: TextStyle(color: japfaOrange, fontSize: 14),
          ),
        ),
      ],
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

    await ref.read(loginProvider.notifier).login(email, password);

    final currentState = ref.read(loginProvider);
    // Now check if logged in after the state is updated
    if (currentState.isLoggedIn) {
      // Check role to decide which page to navigate to
      switch (currentState.role) {
        case 'admin':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PendaftarMagangDashboard(),
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
              builder: (context) => const LogBookPesertaDashboard(),
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
