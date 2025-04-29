import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/models/pendaftar_data/pendaftar_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';

class SignUpPendaftar extends StatefulWidget {
  const SignUpPendaftar({super.key});

  @override
  _SignUpPendaftarState createState() => _SignUpPendaftarState();
}

class _SignUpPendaftarState extends State<SignUpPendaftar> {
  bool _visible = false;
  bool _isPasswordSetup = false;

  // Add controllers for each text field
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
    // Clean up controllers when the widget is disposed
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    schoolController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            duration: const Duration(milliseconds: 100),
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
              child: _buildForm(),
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET
  Widget _buildForm() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isPasswordSetup ? _buildPasswordSetupForm() : _buildSignUpForm(),
    );
  }

  // Form Page 1
  Widget _buildSignUpForm() {
    return Column(
      key: const ValueKey(1), // Unique key for Each Widget
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
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Fill in your details.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        buildTextField('Full Name', fullNameController),
        const SizedBox(height: 15),
        buildTextField('Email', emailController),
        const SizedBox(height: 15),
        buildTextField('Phone Number', phoneNumberController),
        const SizedBox(height: 15),
        buildTextField('School/University', schoolController),
        const SizedBox(height: 20),
        RoundedRectangleButton(
          title: "Next",
          backgroundColor: japfaOrange,
          fontColor: Colors.white,
          onPressed: () {
            setState(() {
              _isPasswordSetup = true;
            });
          },
        ),
      ],
    );
  }

  // Form Page 2
  Widget _buildPasswordSetupForm() {
    return Column(
      key: const ValueKey(2), // Unique key for Each Widget
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _isPasswordSetup = false; // Go back to sign-up form
                });
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 65),
            const Text(
              'Set Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'Email: ${emailController.text}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        _buildPasswordField('Password', passwordController),
        const SizedBox(height: 15),
        _buildPasswordField('Confirm Password', confirmPasswordController),
        const SizedBox(height: 20),
        RoundedRectangleButton(
          title: "Create Account",
          backgroundColor: japfaOrange,
          fontColor: Colors.white,
          onPressed: () {
            // Handle account creation logic here
            signUp();
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      cursorColor: const Color.fromARGB(255, 48, 48, 48),
    );
  }

  // validate all form field
  bool validateFields() {
    if (fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Nama tidak boleh kosong'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (emailController.text.isEmpty ||
        !emailController.text.contains('@') ||
        !emailController.text.endsWith('.com')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Tolong isi email dengan benar'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (phoneNumberController.text.isEmpty ||
        !RegExp(r'^\d+$').hasMatch(phoneNumberController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No Telp harus diisi dan harus angka'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (schoolController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Sekolah / Universitas tidak boleh kosong'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password harus diisi dan minimal 8 digit'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password tidak sama'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Passwords do not match'),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    return true; // All fields are valid
  }

  // Sign Up and send to database
  Future<void> signUp() async {
    // Validate fields before proceeding
    if (!validateFields()) return; // If validation fails, exit the function

    try {
      // Fetch current count to generate ID
      final currentCount = await fetchCount();
      final String newIdPendaftar = 'PDFT_0${currentCount + 1}';

      // Create a new Pendaftar object using the freezed model
      final pendaftar = PendaftarData(
        idPendaftar: newIdPendaftar,
        nama: fullNameController.text,
        noTelp: phoneNumberController.text,
        email: emailController.text,
        asalUniversitas: schoolController.text,
        password: passwordController.text,
        role: 'pendaftar',
      );

      // Send data to API using Dio
      final response = await dio.post(
        'http://localhost:3000/api/pendaftar/add',
        data: pendaftar.toJson(),
      );

      if (response.statusCode == 201) {
        // User created successfully, navigate to home page
        fadeNavigation(context, targetNavigation: const MyHomePage());
      } else {
        // Handle error response
        final errorMessage = response.data['details'] ?? 'Unknown error';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $errorMessage'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // Handle any errors
      print('Sign up error: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to sign up'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<int> fetchCount() async {
    try {
      Response response =
          await dio.get('http://localhost:3000/api/pendaftar/count');

      if (response.statusCode == 200) {
        // Ensure the count is an int
        return int.parse(response.data['count'].toString());
      } else {
        throw Exception('Failed to fetch count: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching count: $e');
      rethrow; // Re-throw the exception for further handling
    }
  }
}
