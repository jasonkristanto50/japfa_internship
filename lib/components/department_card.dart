import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/authentication/login.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/pendaftar_submission_page/submission_intern.dart';
import 'package:japfa_internship/function_variable/variable.dart';

// ignore: must_be_immutable
class DepartmentCard extends ConsumerStatefulWidget {
  final String title;
  String description;
  final String image;
  List<String> requirements; // Add a list for requirements
  final bool isAdmin;

  DepartmentCard({
    required this.title,
    required this.description,
    required this.image,
    required this.requirements,
    required this.isAdmin,
    super.key,
  });

  @override
  _DepartmentCardState createState() => _DepartmentCardState();
}

class _DepartmentCardState extends ConsumerState<DepartmentCard> {
  bool isHovered = false;

  // Local state for editable content
  late TextEditingController _descriptionController;
  late List<TextEditingController> _requirementControllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the initial values from the widget properties
    _descriptionController = TextEditingController(text: widget.description);
    _requirementControllers = widget.requirements
        .map((requirement) => TextEditingController(text: requirement))
        .toList();
  }

  @override
  void dispose() {
    // Dispose controllers when no longer needed
    _descriptionController.dispose();
    for (var controller in _requirementControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          _showDepartmentModal(context); // Show the modal on tap
        },
        child: Transform.scale(
          scale: isHovered ? 1.05 : 1.0, // Scale up on hover
          child: Card(
            color: Colors.white,
            elevation: isHovered ? 10 : 5, // Increase elevation on hover
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: 120,
              height: 150,
              child: Column(
                children: [
                  // Upper half for the image
                  Expanded(
                    flex: 3, // Occupying more space
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        widget.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),

                  // Lower half for title and description
                  Expanded(
                    flex: 2, // Occupying less space
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: bold16.copyWith(color: japfaOrange),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool hovered) {
    setState(() {
      isHovered = hovered; // Update hover state
    });
  }

  void _showDepartmentModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return Material(
          color: Colors.transparent, // Set to transparent to keep background
          child: Center(
            child: Container(
              width: 400,
              height: 600,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title above the image
                  Center(
                    child: Text(
                      widget.title,
                      style: bold16.copyWith(
                          color: japfaOrange,
                          // Text decoration none untuk menghapus garis kuning
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Image in the custom modal
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Editable description and requirements fields
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Editable Description
                          widget.isAdmin
                              ? TextField(
                                  controller: _descriptionController,
                                  decoration: const InputDecoration(
                                    labelText: "Edit Description",
                                  ),
                                )
                              : Text(widget.description,
                                  style: regular16.copyWith(
                                      color: darkGrey,
                                      decoration: TextDecoration.none)),
                          const SizedBox(height: 16),
                          // Requirements section
                          Text(
                            'Requirements:',
                            style: light16.copyWith(
                                color: darkGrey,
                                decoration: TextDecoration.none),
                          ),
                          widget.isAdmin
                              ? Column(
                                  children: _requirementControllers
                                      .map((controller) => TextField(
                                            controller: controller,
                                            decoration: const InputDecoration(
                                              labelText: "Edit Requirement",
                                            ),
                                          ))
                                      .toList(),
                                )
                              : Column(
                                  children: widget.requirements
                                      .map((requirement) => Text(
                                            requirement,
                                            style: light12.copyWith(
                                                color: const Color.fromARGB(
                                                    255, 88, 88, 88),
                                                decoration:
                                                    TextDecoration.none),
                                          ))
                                      .toList(),
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Cancel button
                      RoundedRectangleButton(
                          title: "Cancel",
                          backgroundColor: Colors.white,
                          outlineColor: japfaOrange,
                          width: 150,
                          height: 30,
                          style: regular16,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      const Spacer(),
                      // Edit/Save button
                      widget.isAdmin
                          ? RoundedRectangleButton(
                              title: "Save Changes",
                              backgroundColor: japfaOrange,
                              width: 150,
                              height: 30,
                              style: regular16,
                              onPressed: () {
                                saveChangesOnPressedFunction();
                              },
                            )
                          // User & login
                          : RoundedRectangleButton(
                              title: "Apply",
                              backgroundColor: japfaOrange,
                              width: 150,
                              height: 30,
                              style: regular16,
                              onPressed: () {
                                applyOnPressedFunction();
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void saveChangesOnPressedFunction() {
    // Save the updated values locally
    setState(() {
      // No longer trying to modify final widget values
      widget.description = _descriptionController.text;
      widget.requirements =
          _requirementControllers.map((controller) => controller.text).toList();
    });
    Navigator.of(context).pop();
  }

  void applyOnPressedFunction() {
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
        MaterialPageRoute(builder: (_) => const SubmissionIntern()),
      );
    }
  }
}
