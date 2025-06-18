import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/pendaftar_submission_page/submission_intern_text.dart';
import 'package:japfa_internship/function_variable/variable.dart';

// ignore: must_be_immutable
class DepartmentCard extends ConsumerStatefulWidget {
  final String title;
  int sisaKuota;
  int jumlahPengajuan;
  String description;
  final String image;
  List<String> requirements;
  final bool isAdmin;
  final bool isKepalaDept;
  bool isMobile;

  DepartmentCard({
    required this.title,
    required this.sisaKuota,
    required this.jumlahPengajuan,
    required this.description,
    required this.image,
    required this.requirements,
    required this.isAdmin,
    required this.isKepalaDept,
    this.isMobile = false,
    super.key,
  });

  @override
  _DepartmentCardState createState() => _DepartmentCardState();
}

class _DepartmentCardState extends ConsumerState<DepartmentCard> {
  bool isHovered = false;

  // Local state for editable content
  late TextEditingController _descriptionController;
  late List<TextEditingController> _requirementControllers = [
    TextEditingController()
  ];

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
                            style: widget.isMobile
                                ? bold16.copyWith(
                                    color: japfaOrange,
                                    decoration: TextDecoration.none,
                                  )
                                : bold20.copyWith(color: japfaOrange),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          if (widget.isMobile == false)
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
    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside
      builder: (BuildContext dialogContext) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Center(
            child: GestureDetector(
              onTap: () {
                // Prevent the tap event from bubbling up to the outer GestureDetector
              },
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: widget.isAdmin ? 800 : 400,
                  height: widget.isAdmin ? 700 : 600,
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
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitleName(),
                          const SizedBox(height: 20),
                          _buildImage(),
                          const SizedBox(height: 10),
                          _buildEditableDeskripsiAndSyarat(setState),
                          const SizedBox(height: 16),
                          _buildCancelSaveButton(setState),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleName() {
    return // Title above the image
        Center(
      child: Text(
        widget.title,
        style: widget.isMobile
            ? bold12.copyWith(
                color: japfaOrange,
                decoration: TextDecoration.none,
              )
            : bold20.copyWith(
                color: japfaOrange,
                decoration: TextDecoration.none,
              ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildImage() {
    return // Image in the custom modal
        ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset(
        widget.image,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 150,
      ),
    );
  }

  Widget _buildEditableDeskripsiAndSyarat(StateSetter setState) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Sisa Kuota : ${widget.sisaKuota}",
                style: widget.isMobile
                    ? bold10.copyWith(color: japfaOrange)
                    : bold16.copyWith(color: japfaOrange),
              ),
            ),
            Center(
              child: Text(
                "Antri Pengajuan : ${widget.jumlahPengajuan}",
                style: widget.isMobile
                    ? bold10.copyWith(color: japfaOrange)
                    : bold16.copyWith(color: japfaOrange),
              ),
            ),
            const SizedBox(height: 20),

            // Editable Description
            widget.isAdmin
                ? TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    textAlignVertical: TextAlignVertical.top,
                    style: regular16,
                    decoration: const InputDecoration(
                      labelText: "Edit Deskripsi",
                      border: OutlineInputBorder(),
                    ),
                  )
                : Center(
                    child: Text(
                      widget.description,
                      style: widget.isMobile
                          ? regular10.copyWith(
                              color: darkGrey, decoration: TextDecoration.none)
                          : regular16.copyWith(
                              color: darkGrey, decoration: TextDecoration.none),
                    ),
                  ),
            const SizedBox(height: 16),

            // Requirements section
            Text(
              widget.isAdmin ? 'Edit Syarat' : 'Syarat:',
              style: widget.isMobile
                  ? regular12.copyWith(
                      color: darkGrey, decoration: TextDecoration.none)
                  : regular16.copyWith(
                      color: darkGrey, decoration: TextDecoration.none),
            ),
            widget.isAdmin
                ? Column(
                    children: _requirementControllers
                        .map((controller) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: TextField(
                                controller: controller,
                                style: widget.isMobile ? regular10 : regular16,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                // Not Admin
                : Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.requirements
                          .map((requirement) => Text(
                                requirement,
                                style: widget.isMobile
                                    ? light10.copyWith(
                                        color: darkGrey,
                                        decoration: TextDecoration.none,
                                      )
                                    : light16.copyWith(
                                        color: darkGrey,
                                        decoration: TextDecoration.none,
                                      ),
                              ))
                          .toList(),
                    ),
                  ),

            // For Admin: Add and Remove Requirement Button
            if (widget.isAdmin) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RoundedRectangleButton(
                    title: "Hapus",
                    backgroundColor: Colors.white,
                    outlineColor: japfaOrange,
                    width: 120,
                    height: 30,
                    rounded: 5,
                    onPressed: () {
                      setState(() {
                        _removeRequirementField();
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  RoundedRectangleButton(
                    title: "Tambah",
                    fontColor: Colors.white,
                    backgroundColor: japfaOrange,
                    width: 120,
                    height: 30,
                    rounded: 5,
                    onPressed: () {
                      setState(() {
                        _addRequirementField();
                      });
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCancelSaveButton(StateSetter setState) {
    return Row(
      children: [
        // Cancel button
        RoundedRectangleButton(
          title: "Batal",
          backgroundColor: Colors.white,
          outlineColor: japfaOrange,
          width: 150,
          height: 30,
          style: widget.isMobile ? regular12 : regular16,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const Spacer(),
        // Conditional button display
        if (widget.isAdmin)
          // Show "Save Changes" button if isAdmin
          RoundedRectangleButton(
            title: "Simpan",
            fontColor: Colors.white,
            backgroundColor: japfaOrange,
            width: 150,
            height: 30,
            style: widget.isMobile ? regular12 : regular16,
            onPressed: () {
              saveChangesOnPressedFunction();
            },
          )
        else if (widget.isKepalaDept)
          // Show nothing if Kepala Dept
          const SizedBox.shrink()
        else
        // Show "Daftar" button for other cases
        if (widget.sisaKuota > 0) ...[
          RoundedRectangleButton(
            title: "Daftar",
            fontColor: Colors.white,
            backgroundColor: japfaOrange,
            width: 150,
            height: 30,
            style: widget.isMobile ? regular12 : regular16,
            onPressed: () {
              // Clear the modal
              Navigator.pop(context);
              applyDaftarFunction();
            },
          ),
        ] else ...[
          RoundedRectangleButton(
            title: "Daftar",
            backgroundColor: Colors.grey,
            width: 150,
            height: 30,
            style: regular16,
            onPressed: () {
              showSnackBar(
                context,
                "Kuota sudah habis",
                backgroundColor: japfaOrange,
              );
            },
          ),
        ]
      ],
    );
  }

  void _addRequirementField() {
    setState(() {
      _requirementControllers
          .add(TextEditingController()); // Add new controller
    });
  }

  void _removeRequirementField() {
    if (_requirementControllers.length > 1) {
      // Ensure at least one field remains
      setState(() {
        _requirementControllers.removeLast(); // Remove the last controller
      });
    }
  }

  void saveChangesOnPressedFunction() async {
    final newDeskripsi = _descriptionController.text;
    final List<String> newSyarat =
        _requirementControllers.map((controller) => controller.text).toList();

    try {
      final updatedDepartemenData =
          await ApiService().departemenService.updateDepartemenDeskripsiSyarat(
                widget.title,
                newDeskripsi,
                newSyarat,
              );

      // Save the updated values locally
      setState(() {
        // Update the local state with the new values returned from API
        widget.description =
            updatedDepartemenData.deskripsi ?? widget.description;
        widget.requirements =
            updatedDepartemenData.syaratDepartemen ?? widget.requirements;
      });

      // Optionally, show a success message if necessary
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Changes saved successfully!')),
      );

      Navigator.of(context).pop(); // Close the modal
    } catch (e) {
      print('Failed to save changes: $e');
      // Optionally show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save changes: $e')),
      );
    }
  }

  void applyDaftarFunction() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => SubmissionIntern(
                departmentName: widget.title,
              )),
    );
  }
}
