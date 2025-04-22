import 'package:flutter/material.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/navbar.dart';

class DetailPengajuanMagang extends StatelessWidget {
  final String departmentName;

  const DetailPengajuanMagang({super.key, required this.departmentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: appName,
        context: context,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Details for Applications of $departmentName',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Here you can add more information and widgets related to the applications
              // For example, a ListView to show application details
              const Text('No application details available yet.'),
            ],
          ),
        ),
      ),
    );
  }
}
