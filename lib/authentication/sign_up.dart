// First Registration Page
import 'package:flutter/material.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/authentication/sign_up_password.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/components/widget_component.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _visible = false;

  // Add controllers for each text field
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController lastEducationController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController scoreGPAController = TextEditingController();

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
    lastEducationController.dispose();
    schoolController.dispose();
    scoreGPAController.dispose();
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
              child: _buildSignUpForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
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
            fadeNavigation(context,
                targetNavigation: SignUpPassword(
                  email: emailController.text,
                ));
          },
        ),
      ],
    );
  }
}
