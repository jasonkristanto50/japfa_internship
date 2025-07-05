import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:japfa_internship/function_variable/file_uploading.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';

// Build the Japfa Logo Background
BoxDecoration buildJapfaLogoBackground() {
  return BoxDecoration(
    color: Colors.white, // Fallback background color
    image: DecorationImage(
      image: AssetImage(japfaLogoBackgroundImgPath),
      fit: BoxFit.cover,
    ),
  );
}

// Rounded Rectangle Button
class RoundedRectangleButton extends StatelessWidget {
  final String title;
  final Color fontColor;
  final Color backgroundColor;
  final Color outlineColor;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? rounded;
  final TextStyle? style;

  const RoundedRectangleButton({
    required this.title,
    this.fontColor = Colors.black,
    required this.backgroundColor,
    this.outlineColor = Colors.transparent, // Default to transparent
    required this.onPressed,
    this.width,
    this.height,
    this.rounded = 10,
    this.style,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: fontColor,
          backgroundColor: backgroundColor,
          // Ensure no outline if the color is intended as transparent
          side: BorderSide(
              color: outlineColor.withOpacity(outlineColor.alpha == 0 ? 0 : 1),
              width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded ?? 10),
          ),
        ),
        child: Text(
          title,
          style: style,
        ),
      ),
    );
  }
}

// Custom Dialog Widget for Login if user not login
class CustomLoginDialog extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback? onClearTap;

  const CustomLoginDialog(
      {required this.onLoginPressed, this.onClearTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onClearTap == null) {
          onClearTap?.call();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: Colors.black.withOpacity(0.5), // Black transparent background
        child: Center(
          child: GestureDetector(
            onTap: () {}, // Prevent taps on the dialog from closing it
            child: AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: const EdgeInsets.all(24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Please Login",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  const Text("You need to login to apply."),
                  const SizedBox(height: 24.0),
                  RoundedRectangleButton(
                    title: "LOGIN",
                    backgroundColor: japfaOrange,
                    fontColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      onLoginPressed(); // Trigger the login navigation
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Dialog for Respond
class CustomRespondDialog extends StatelessWidget {
  final String title;
  final String? message;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const CustomRespondDialog({
    super.key,
    required this.title,
    this.message,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5.0,
      child: Container(
        width: 350,
        height: 200,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: japfaOrange,
              ),
            ),
            const SizedBox(height: 16),
            // Message
            Text(
              message ?? "",
              textAlign: TextAlign.center,
              style: regular16,
            ),
            const Spacer(),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Reject Button
                ElevatedButton(
                  onPressed: onReject,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Ditolak'),
                ),
                const SizedBox(width: 16),
                // Accept Button
                ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Diterima'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// CustomSearchBar
class CustomSearchBar extends StatelessWidget {
  final Function(String) onChanged;
  final String? labelSearchBar;
  final double? widthValue;
  final double? heightValue;
  final bool withSearchButton;

  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.labelSearchBar,
    this.widthValue,
    this.heightValue,
    this.withSearchButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: heightValue ?? 70,
            width: widthValue,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // If widthValue is given → use it, otherwise expand
                widthValue != null
                    ? SizedBox(
                        width: widthValue,
                        child: _buildTextField(),
                      )
                    : Expanded(child: _buildTextField()),
                if (withSearchButton) ...[
                  const SizedBox(width: 8), // small gap
                  RoundedRectangleButton(
                    title: 'Search',
                    fontColor: Colors.white,
                    backgroundColor: Colors.orange,
                    height: 45,
                    width: 100,
                    rounded: 5,
                    onPressed: () {},
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() => TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: labelSearchBar ?? 'Ketikkan pencarian',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
      );
}

// Custom Confirmation Dialog
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = isScreenMobile(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Dynamic height based on content
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: bold28.copyWith(color: japfaOrange),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                message,
                style: regular20,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24), // Space before button
            Center(
              child: RoundedRectangleButton(
                title: "OK",
                backgroundColor: japfaOrange,
                height: 50.h,
                width: isMobile ? 150.w : 300.w,
                rounded: 5,
                fontColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
            const SizedBox(height: 16), // Space at the bottom
          ],
        ),
      ),
    );
  }
}

enum BuildFieldTypeController {
  text,
  multiLineText,
  number,
  date,
  dropdown,
  viewOnly
}

// Custom Alert Dialog
class CustomAlertDialog extends StatefulWidget {
  final String title;
  final String? subTitle;
  final List<TextEditingController> controllers;
  final List<String>? viewValue; // For view only
  final List<String> labels;
  final List<BuildFieldTypeController> fieldTypes;
  final String? saveButtonText;
  final VoidCallback onSave;
  final bool withCancelButton;
  final int numberOfField;
  final List<String>? dropdownOptions;

  const CustomAlertDialog(
      {super.key,
      required this.title,
      this.subTitle,
      required this.controllers,
      this.viewValue,
      required this.labels,
      required this.fieldTypes,
      this.saveButtonText,
      required this.onSave,
      this.withCancelButton = false,
      required this.numberOfField,
      this.dropdownOptions});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  String? uploadedFileName;
  final FileUploading fileUploading = FileUploading();

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Center(
        child: Text(widget.title, style: bold24),
      ),
      content: Container(
        width: isMobile ? 300.w : 400.w,
        constraints: BoxConstraints(
          maxHeight: isMobile ? 350 : 400,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.subTitle != null ? widget.subTitle!.toUpperCase() : "",
                  style: isMobile
                      ? regular14.copyWith(color: japfaOrange)
                      : regular20.copyWith(color: japfaOrange),
                ),
              ),
              const SizedBox(height: 10),
              ...List.generate(widget.numberOfField, (index) {
                return _buildField(
                  widget.controllers[index],
                  widget.labels[index],
                  widget.fieldTypes[index],
                  context,
                  index,
                  viewValue: widget.viewValue?[index],
                  options: widget.dropdownOptions,
                );
              }),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  children: [
                    if (widget.withCancelButton == true) ...[
                      RoundedRectangleButton(
                        title: "Batal",
                        backgroundColor: Colors.white,
                        fontColor: japfaOrange,
                        outlineColor: japfaOrange,
                        height: 40,
                        width: 150,
                        onPressed: Navigator.of(context).pop,
                      ),
                      const SizedBox(width: 20),
                    ],
                    RoundedRectangleButton(
                      title: widget.saveButtonText ?? "Simpan",
                      width: widget.withCancelButton ? 150 : 320,
                      height: widget.withCancelButton ? 40 : 50,
                      backgroundColor: japfaOrange,
                      fontColor: Colors.white,
                      onPressed: widget.onSave,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    BuildFieldTypeController fieldType,
    BuildContext context,
    int index, {
    List<String>? options,
    String? viewValue,
  }) {
    switch (fieldType) {
      case BuildFieldTypeController.text:
        return _buildTextField(controller, label);
      case BuildFieldTypeController.multiLineText:
        return _buildMultiLineTextField(controller, label);
      case BuildFieldTypeController.number:
        return _buildNumberField(controller, label);
      case BuildFieldTypeController.date:
        return _buildDateField(controller, label, context);
      case BuildFieldTypeController.dropdown:
        return _buildDropdownField(controller, label, options!);
      case BuildFieldTypeController.viewOnly:
        return _buildViewOnlyField(viewValue!, label);
    }
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );
  }

  Widget _buildMultiLineTextField(
      TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        maxLines: 3, // Set this to control the number of visible lines
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );
  }

  Widget _buildNumberField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
      ),
    );
  }

  Widget _buildDateField(
      TextEditingController controller, String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (picked != null) {
            controller.text = DateFormat('dd-MM-yyyy').format(picked);
          }
        },
      ),
    );
  }

  Widget _buildDropdownField(
      TextEditingController controller, String label, List<String> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: controller.text.isNotEmpty ? controller.text : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: regular14.copyWith(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        items: options.map((String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.text = newValue ?? "";
        },
        isExpanded: true,
        dropdownColor: Colors.white,
      ),
    );
  }

  Widget _buildViewOnlyField(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: value), // Set the initial value
        readOnly: true, // Make the field read-only
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.orange, width: 2),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

// Password Textfield
class PasswordToggleTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const PasswordToggleTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  _PasswordToggleTextFieldState createState() =>
      _PasswordToggleTextFieldState();
}

class _PasswordToggleTextFieldState extends State<PasswordToggleTextField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
          cursorColor: const Color.fromARGB(255, 48, 48, 48),
        ),
      ],
    );
  }
}

// Dropdown textfield

class CustomDropdown extends StatefulWidget {
  final String label;
  final String? selectedValue;
  final List<Map<String, String>> options;
  final ValueChanged<String?> onChanged;
  final bool mandatory;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
    this.mandatory = false,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<Map<String, String>> filteredOptions = [];
  final TextEditingController _searchController = TextEditingController();
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    filteredOptions = List.from(widget.options);
  }

  void _filterOptions(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredOptions = List.from(widget.options);
      } else {
        filteredOptions = widget.options.where((option) {
          final name = option['name'];
          return name != null &&
              name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _onSelected(String? value) {
    widget.onChanged(value);
    _searchController.clear();
    setState(() {
      filteredOptions = List.from(widget.options);
      isDropdownOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 48, 48, 48)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isDropdownOpen = !isDropdownOpen;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 45,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: widget.selectedValue == null
                          ? widget.label
                          : widget.selectedValue!,
                      style: const TextStyle(color: Colors.black87),
                      children: <TextSpan>[
                        if (widget.selectedValue == null && widget.mandatory)
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          if (isDropdownOpen)
            SizedBox(
              height: 200, // Set a height limit for the dropdown
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Column(
                  children: [
                    // Search Text Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        onChanged: _filterOptions,
                        decoration: const InputDecoration(
                          hintText: 'Cari',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    // Filtered Options
                    Expanded(
                      child: ListView(
                        children: filteredOptions.isEmpty
                            ? [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    title: Text('No results found',
                                        style: TextStyle(color: Colors.grey)),
                                  ),
                                )
                              ]
                            : filteredOptions.map((option) {
                                return ListTile(
                                  title: Text(option['name']!),
                                  onTap: () => _onSelected(option['value']),
                                );
                              }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
