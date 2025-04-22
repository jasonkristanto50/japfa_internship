import 'package:flutter/material.dart';
import 'package:japfa_internship/admin_page/detail_pengajuan_magang.dart';
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
    print('Edit button clicked for $jobName');
  }

  // Function to handle View Applications Button click
  void _onViewApplications(String jobName) {
    // Navigate to the applications view for the specific job
    print('View applications button clicked for $jobName');
    // Here you can navigate to another page where applications are listed
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPengajuanMagang(jobTitle: jobName)));
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
                          DataColumn(label: Text('Action')),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RoundedRectangleButton(
                                      title: "EDIT",
                                      backgroundColor: const Color.fromARGB(
                                          255, 247, 211, 159),
                                      height: 30,
                                      width: 85,
                                      rounded: 5,
                                      onPressed: () => _editTable(job),
                                    ),
                                    const SizedBox(
                                        width: 8), // Space between buttons
                                    RoundedRectangleButton(
                                      title: "VIEW",
                                      backgroundColor: const Color.fromARGB(
                                          255, 152, 209, 255),
                                      height: 30,
                                      width: 85,
                                      rounded: 5,
                                      onPressed: () =>
                                          _onViewApplications(job['job']),
                                    ),
                                  ],
                                ),
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
