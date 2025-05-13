import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/home_page.dart';
import 'package:japfa_internship/navbar.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String userName = "Jason";
  String userEmail = "jason@gmail.com";
  String userRole = "Intern";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();

  bool _isEditing = false; // Flag to check if we're in edit mode

  @override
  void initState() {
    super.initState();
    _nameController.text = userName;
    _emailController.text = userEmail;
    _roleController.text = userRole;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: appName,
        context: context,
        titleOnPressed: () {
          fadeNavigation(context, targetNavigation: const MyHomePage());
        },
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Center(
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
            child: buildProfileContent(),
          ),
        ),
      ),
    );
  }

  Widget buildProfileContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text(
          'User Profile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        buildInfoField('Name', _nameController),
        const SizedBox(height: 15),
        buildInfoField('Email', _emailController),
        const SizedBox(height: 15),
        buildInfoField('Role', _roleController),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns buttons
          children: [
            if (_isEditing) // Show the Cancel button only in edit mode
              Expanded(
                child: RoundedRectangleButton(
                  title: "Cancel",
                  backgroundColor: Colors.grey,
                  fontColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isEditing = false; // Exit editing mode
                      // Reset fields to original values
                      _nameController.text = userName;
                      _emailController.text = userEmail;
                      _roleController.text = userRole;
                    });
                  },
                ),
              ),
            const SizedBox(width: 10), // Space between buttons
            Expanded(
              child: RoundedRectangleButton(
                title: _isEditing ? "Save" : "Edit Profile",
                backgroundColor: japfaOrange,
                fontColor: Colors.white,
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      // Save changes
                      userName = _nameController.text;
                      userEmail = _emailController.text;
                      userRole = _roleController.text;
                    }
                    _isEditing = !_isEditing; // Toggle editing mode
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildInfoField(String label, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _isEditing
              ? TextField(controller: controller) // Editable field
              : Text(controller.text), // Display text
        ),
      ],
    );
  }
}
