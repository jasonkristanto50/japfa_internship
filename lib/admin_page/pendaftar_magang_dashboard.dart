import 'package:flutter/material.dart';
import 'package:japfa_internship/admin_page/edit_job_page.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/data.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class PendaftarMagangDashboard extends StatefulWidget {
  const PendaftarMagangDashboard({super.key});

  @override
  State<PendaftarMagangDashboard> createState() =>
      _PendaftarMagangDashboardState();
}

class _PendaftarMagangDashboardState extends State<PendaftarMagangDashboard> {
  String selectedDepartment = 'Semua Departemen';

  // Function to handle Edit Button click
  void _onEditButtonClick(String jobName) {
    // Here you can implement the logic when the edit button is clicked
    // For example, show a dialog or navigate to another screen for editing
    print('Edit button clicked for $jobName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: SafeArea(
        // Ensures content is not cut off by system UI
        child: Container(
          decoration: buildJapfaLogoBackground(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Table Section - Centered
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor:
                            WidgetStateProperty.all(Colors.orange[500]),
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        border: TableBorder.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        columns: const [
                          DataColumn(label: Text('Job')),
                          DataColumn(label: Text('Max Kuota')),
                          DataColumn(label: Text('Jumlah Pengajuan')),
                          DataColumn(label: Text('Jumlah Approved')),
                          DataColumn(label: Text('Jumlah On Boarding')),
                          DataColumn(label: Text('Sisa Kuota')),
                          DataColumn(
                              label: Text(
                                  'Action')), // New column for Action (EDIT button)
                        ],
                        rows: jobData.map((job) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  job['job'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(
                                Text(
                                  job['maxQuota'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(
                                Text(
                                  job['totalApplications'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(
                                Text(
                                  job['approved'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(
                                Text(
                                  job['onboarding'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(
                                Text(
                                  job['remainingQuota'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(
                                Align(
                                    alignment: Alignment.center,
                                    child: RoundedRectangleButton(
                                        title: "EDIT",
                                        backgroundColor: const Color.fromARGB(
                                            255, 247, 211, 159),
                                        height: 30,
                                        width: 80,
                                        rounded: 5,
                                        onPressed: () => _editTable(job))),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24), // Extra space to avoid cut-off
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to handle Edit Button click and navigate to the Edit page
  void _editTable(Map<String, dynamic> job) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditJobModal(job: job);
      },
    );
  }
}
