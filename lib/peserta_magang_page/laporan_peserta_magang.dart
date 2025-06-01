import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/file_uploading.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LaporanPesertaMagang extends ConsumerStatefulWidget {
  const LaporanPesertaMagang({super.key});

  @override
  _LaporanPesertaMagangState createState() => _LaporanPesertaMagangState();
}

class _LaporanPesertaMagangState extends ConsumerState<LaporanPesertaMagang> {
  late PesertaMagangData peserta;
  String email = "";
  String pathFileLaporanAkhir = '';
  bool isLoading = true;

  // Default report types
  List<String> laporans = ['Laporan Akhir'];
  Map<String, Map<String, String?>> laporanData = {
    'Laporan Akhir': {'url': null, 'validasi': 'Pending'},
  };

  @override
  void initState() {
    super.initState();
    final loginState = ref.read(loginProvider);
    email = loginState.email!;
    _fetchPesertaData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show loading indicator while fetching data
      return Scaffold(
        appBar: Navbar(
          context: context,
          title: 'Laporan Peserta',
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: Navbar(
          context: context,
          title: 'Laporan Peserta',
        ),
        body: Container(
          decoration: buildJapfaLogoBackground(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Laporan Peserta",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: _buildLaporanTable(),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildLaporanTable() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0), // Padding around the table
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Container(
              color: Colors.white, // Background color behind the DataTable
              child: SingleChildScrollView(
                // Added for horizontal scrolling
                scrollDirection: Axis.horizontal, // Enable horizontal scroll
                child: DataTable(
                  headingRowColor: const WidgetStatePropertyAll(Colors.orange),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  border: TableBorder.all(color: Colors.grey, width: 1),
                  columns: const [
                    DataColumn(label: Text('Nama Laporan')),
                    DataColumn(label: Text('File / URL')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: laporans.map<DataRow>((laporan) {
                    String? url = peserta.urlLaporanAkhir ?? '';
                    return DataRow(cells: [
                      DataCell(Text(laporan)),
                      DataCell(
                        GestureDetector(
                          onTap: () {
                            if (url.isNotEmpty) {
                              launchURLImagePath(url);
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                getFileIcon(url),
                                color:
                                    url.isNotEmpty ? Colors.blue : Colors.grey,
                              ),
                              const SizedBox(
                                  width: 8), // Space between icon and text
                              Text(
                                getOriginalFileNameFromPath(url),
                                style: TextStyle(
                                  color: url.isNotEmpty
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            // Check for Laporan Akhir for edit
                            RoundedRectangleButton(
                              title: "UPLOAD",
                              backgroundColor: lightBlue,
                              fontColor: Colors.black,
                              style: regular14,
                              height: 40.h,
                              width: 150.w,
                              rounded: 5,
                              onPressed: () =>
                                  _showDialogUploadLaporanAkhir(email),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteLaporan(laporan),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchPesertaData() async {
    try {
      PesertaMagangData pesertaData = await ApiService()
          .pesertaMagangService
          .fetchPesertaMagangByEmail(email);

      setState(() {
        peserta = pesertaData;
        isLoading = false; // Set loading to false on data fetch completion
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading on error
      });
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
  }

  void _showDialogUploadLaporanAkhir(String email) {
    String labelFieldPersetujuan = "File Laporan Akhir";
    String? uploadedFileName;
    Uint8List? uploadedFileBytes;

    // Use CustomAlertDialog for file upload
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Center(
                  child: Text(
                "UPLOAD LAPORAN AKHIR",
                style: bold20,
              )),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    FileUploading().buildFileField(
                      labelFieldPersetujuan,
                      uploadedFileName,
                      isMobile: true,
                      () => FileUploading().pickFile(
                        setState,
                        labelFieldPersetujuan,
                        false,
                        (field, fileName, fileBytes) {
                          setState(() {
                            uploadedFileName = fileName;
                            uploadedFileBytes = fileBytes;
                          });
                        },
                      ),
                      () => FileUploading().removeFile(
                        setState,
                        labelFieldPersetujuan,
                        (field, _, __) {
                          setState(() {
                            uploadedFileName = null;
                            uploadedFileBytes = null;
                          });
                        },
                      ),
                      () {},
                    ),
                    const SizedBox(height: 20),
                    // Row for buttons in the dialog content
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RoundedRectangleButton(
                            title: 'CANCEL',
                            fontColor: japfaOrange,
                            backgroundColor: Colors.white,
                            outlineColor: japfaOrange,
                            height: 50.h,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: RoundedRectangleButton(
                            title: 'UPLOAD',
                            fontColor: Colors.white,
                            backgroundColor: japfaOrange,
                            height: 50.h,
                            onPressed: () async {
                              if (uploadedFileBytes != null) {
                                // Call the upload file function
                                await _uploadFile(
                                  uploadedFileName!,
                                  uploadedFileBytes!,
                                );
                                print("PATH LAPORAN : $pathFileLaporanAkhir");

                                // DATABASE nama adalah URL tapi Valuenya adalah path laporan akhir
                                await ApiService()
                                    .pesertaMagangService
                                    .updateUrlLaporanAkhir(
                                      email,
                                      pathFileLaporanAkhir,
                                    );
                                _fetchPesertaData();

                                Navigator.of(context).pop(); // Close the dialog
                              } else {
                                showSnackBar(
                                  context,
                                  'Tolong pilih file untuk diupload',
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _uploadFile(String fileName, Uint8List fileBytes) async {
    try {
      // Here you replace the URL with your actual endpoint for file uploads
      final uploadFilePath =
          await ApiService().uploadFileToServer(fileBytes, fileName);

      setState(() {
        pathFileLaporanAkhir = uploadFilePath;
      });
      print("FILE PATH : $pathFileLaporanAkhir");
    } catch (e) {
      print('Error uploading file: $e');
      showSnackBar(context, 'Error uploading file.');
    }
  }

  void _deleteLaporan(String laporanType) {
    setState(() async {
      // PATH URL Laporan akhir = empty
      await ApiService().pesertaMagangService.updateUrlLaporanAkhir(email, '');
      _fetchPesertaData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("File Upload berhasil dihapus")),
      );
    });
  }
}
