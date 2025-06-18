import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:japfa_internship/authentication/login_provider.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/file_uploading.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';

class LogBookPesertaDashboard extends ConsumerStatefulWidget {
  const LogBookPesertaDashboard({super.key});

  @override
  _LogBookPesertaDashboardState createState() =>
      _LogBookPesertaDashboardState();
}

class _LogBookPesertaDashboardState
    extends ConsumerState<LogBookPesertaDashboard> {
  String searchQuery = "";
  String nama = "";
  String email = "";
  String departement = "";
  String namaPembimbing = "";
  List<LogbookPesertaMagangData> logbookData = [];
  bool isMobile = false;
  String pathLogbookFile = '';

  final TextEditingController activityController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final loginState = ref.read(loginProvider);
    nama = loginState.name!;
    email = loginState.email!;
    departement = loginState.departemen!;
    fetchLogbooks(); // Fetch logbooks on initialization
    getNamaPembimbing();
  }

  @override
  Widget build(BuildContext context) {
    // Check if the current device is mobile
    isMobile = MediaQuery.of(context).size.width < 600;

    // Filter logbook data based on search query
    final filteredLogData = logbookData.where((data) {
      return data.namaAktivitas
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: 'Log Book Mahasiswa',
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Add Search Bar and Add Button
            _buildSearchAndAddLogBookButton(),
            // Display the Pembimbing name
            _buildNamaPembimbing(),
            // Logbook Table
            _buildLogbookTable(filteredLogData),
          ],
        ),
      ),
    );
  }

  Widget _buildNamaPembimbing() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile == true ? 30 : 180,
        0,
        15,
        15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Pembimbing: $namaPembimbing',
                style: isMobile == true ? bold12 : bold28,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndAddLogBookButton() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSearchBar(
            onChanged: (value) {
              setState(() {
                searchQuery = value; // Update search query
              });
            },
            labelSearchBar: "Cari",
            heightValue: 40,
            widthValue: isMobile ? 200.w : 1200.w, // Adjust width for mobile
          ),
          SizedBox(width: isMobile ? 0 : 16),
          // Button to add a new logbook
          RoundedRectangleButton(
            title: isMobile ? "Tambah" : "Tambah Log Book", // Conditional title
            backgroundColor: japfaOrange,
            fontColor: Colors.white,
            height: 40,
            width: isMobile ? 110 : 200, // Adjust width for mobile
            rounded: 5,
            onPressed: () {
              _showAddLogBookModal();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLogbookTable(filteredLogData) {
    return filteredLogData.isEmpty
        ? buildEmptyDataMessage(dataName: "Logbook Peserta")
        : Container(
            constraints: BoxConstraints(
              maxHeight: 700.h, // Set the maximum height
            ),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.orange[500]),
                  headingTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  dataRowMinHeight: 120,
                  dataRowMaxHeight: 150,
                  border: TableBorder.all(color: Colors.grey, width: 1),
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Aktivitas')),
                    DataColumn(label: Text('Tanggal Aktivitas')),
                    DataColumn(label: Text('Foto Lampiran')),
                    DataColumn(label: Text('Validasi Pembimbing')),
                    DataColumn(label: Text('Catatan Pembimbing')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: filteredLogData.asMap().entries.map<DataRow>((entry) {
                    // index of entry list
                    int index = entry.key;
                    // logbook data
                    LogbookPesertaMagangData data = entry.value;
                    return DataRow(cells: [
                      DataCell(Text('${filteredLogData.length - index}')),
                      DataCell(Text(data.namaAktivitas)),
                      DataCell(Text(data.tanggalAktivitas)),
                      DataCell(showFoto(data)),
                      DataCell(
                        Text(
                          data.validasiPembimbing == 'true'
                              ? 'Disetujui'
                              : (data.validasiPembimbing == 'false'
                                  ? 'Ditolak'
                                  : 'Menunggu'),
                          style: TextStyle(
                            color: data.validasiPembimbing == 'true'
                                ? Colors.green
                                : (data.validasiPembimbing == 'false'
                                    ? Colors.red
                                    : Colors.black),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataCell(Text(data.catatanPembimbing ?? '')),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _deleteLogbookById(data.idLogbook),
                              tooltip: 'Hapus',
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          );
  }

  void _showAddLogBookModal() {
    String labelLogbookFile = "Foto Kegiatan";
    String? uploadedFileName;
    Uint8List? uploadedFileBytes;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Tambah Log Book'),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    buildTextField("Nama Kegiatan", activityController),
                    const SizedBox(height: 20),
                    buildTanggalField(),
                    const SizedBox(height: 10),
                    FileUploading().buildFileField(
                      labelLogbookFile,
                      uploadedFileName,
                      isMobile: true,
                      () => FileUploading().pickFile(
                        setState,
                        labelLogbookFile,
                        true,
                        (field, fileName, fileBytes) {
                          setState(() {
                            uploadedFileName = fileName;
                            uploadedFileBytes = fileBytes;
                          });
                        },
                      ),
                      () => FileUploading().removeFile(
                        setState,
                        labelLogbookFile,
                        (field, _, __) {
                          setState(() {
                            uploadedFileName = null;
                            uploadedFileBytes = null;
                          });
                        },
                      ),
                      () {},
                    ),
                  ],
                ),
              ),
              actions: [
                RoundedRectangleButton(
                  title: "SIMPAN",
                  fontColor: Colors.white,
                  backgroundColor: japfaOrange,
                  onPressed: () async {
                    try {
                      if (uploadedFileBytes == null) {
                        _showErrorDialog(
                            context, "Please upload a file before saving.");
                        return;
                      }

                      if (!validateField(
                        controller: activityController,
                        fieldName: "Nama Kegiatan",
                        fieldType: FieldType.name,
                        context: context,
                      )) {
                        return; // Validation error, message shown in validateField
                      }

                      if (!validateField(
                        controller: dateController,
                        fieldName: "Tanggal Kegiatan",
                        fieldType: FieldType.elseMustFill,
                        context: context,
                      )) {
                        return; // Validation error, message shown in validateField
                      }

                      // Validate file upload and check return value
                      bool fileValidationResult = validateFileUpload(
                        labelLogbookFile,
                        labelLogbookFile,
                        uploadedFileName,
                      );

                      if (!fileValidationResult) {
                        _showErrorDialog(context,
                            'Invalid file upload. Please check your file.');
                        return; // File validation failed, error message shown
                      }

                      // Call the upload file function
                      await _uploadFile(
                        uploadedFileName!,
                        uploadedFileBytes!,
                      );

                      // Ensure the upload was successful
                      if (uploadedFileBytes != null) {
                        addNewLogbook(
                          activityName: activityController.text,
                          tanggalActivity: dateController.text,
                          url: pathLogbookFile,
                        );
                        Navigator.of(context).pop();
                      } else {
                        _showErrorDialog(context, "File upload failed.");
                      }
                    } catch (e) {
                      _showErrorDialog(
                          context, "An error occurred: ${e.toString()}");
                    }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildTanggalField() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => selectDate(context),
        child: AbsorbPointer(
          // Prevent keyboard from showing
          child: TextField(
            controller: dateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: "Tanggal Kegiatan",
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => selectDate(context),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(BuildContext context) async {
    print("DatePicker: Initializing date selection");

    final DateTime now = DateTime.now();
    final DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: oneMonthAgo,
      lastDate: now,
    );

    print(
        "DatePicker: Date selected: ${picked.toString()}"); // Check if this is printed

    if (picked != null) {
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _uploadFile(String fileName, Uint8List fileBytes) async {
    try {
      // Here you replace the URL with your actual endpoint for file uploads
      final uploadFilePath =
          await ApiService().uploadFileToServer(fileBytes, fileName);

      setState(() {
        pathLogbookFile = uploadFilePath;
      });
      print("FILE PATH : $pathLogbookFile");
    } catch (e) {
      print('Error uploading file: $e');
      showSnackBar(context, 'Error uploading file.');
    }
  }

  Future<void> fetchLogbooks() async {
    try {
      final logbooks =
          await ApiService().logbookService.fetchLogbookByEmail(email);

      // Sort logbooks by date in descending order
      logbooks.sort((a, b) {
        DateTime dateA = DateFormat('dd-MM-yyyy').parse(a.tanggalAktivitas);
        DateTime dateB = DateFormat('dd-MM-yyyy').parse(b.tanggalAktivitas);
        return dateB.compareTo(dateA); // Descending order
      });

      setState(() {
        logbookData = logbooks; // Store fetched and sorted data
      });
      print('Fetched logbooks: $logbooks'); // Log fetched data
    } catch (e) {
      print('Error fetching logbooks: $e'); // Log errors
    }
  }

  Future<void> getNamaPembimbing() async {
    try {
      final namaPembimbingFetched =
          await ApiService().pesertaMagangService.fetchPembimbingByEmail(email);
      setState(() {
        namaPembimbing = namaPembimbingFetched!; // Store fetched data
      });
      print('Fetched nama pembimbing : $namaPembimbingFetched');
    } catch (e) {
      print('Error fetching nama pembimbing : $e'); // Log errors
    }
  }

  Future<void> addNewLogbook({
    required String activityName,
    required String tanggalActivity,
    required String url,
  }) async {
    try {
      String newIdLogbook = 'LG_${DateTime.now().millisecondsSinceEpoch}';

      // Create a new logbook entry
      final newLogbook = LogbookPesertaMagangData(
        idLogbook: newIdLogbook,
        namaPeserta: nama,
        email: email,
        departemen: departement,
        namaAktivitas: activityName,
        tanggalAktivitas: tanggalActivity,
        urlLampiran: url,
      );

      await ApiService().logbookService.addLogbook(newLogbook);
      await fetchLogbooks();
    } catch (e) {
      print('Error adding logbook: $e');
    }
  }

  Future<void> _deleteLogbookById(String idLogbook) async {
    try {
      // Call the delete logbook method from your API service
      await ApiService().logbookService.deleteLogbook(idLogbook);

      // Refresh the logbooks after deletion
      await fetchLogbooks();
      print('Logbook deleted successfully!');
    } catch (e) {
      print('Error deleting logbook: $e');
    }
  }

  Widget showFoto(LogbookPesertaMagangData logbook) {
    final img = '$baseUrl${logbook.urlLampiran}';
    return Image.network(
      img,
      height: 120,
      width: 90,
      fit: BoxFit.cover,
      loadingBuilder: (c, child, p) =>
          p == null ? child : const CircularProgressIndicator(),
      errorBuilder: (c, _, __) => const Text('Failed to load image'),
    );
  }

  bool validateFileUpload(
    String field,
    String labelLogbookFile,
    String? uploadedFileName,
  ) {
    String? fileName;
    if (field == labelLogbookFile) {
      fileName = uploadedFileName;
    }

    if (fileName == null) {
      showSnackBar(context, '$field harus diupload');
      return false;
    }

    // Additional check for file extension
    final allowedExtensions = ['jpg', 'jpeg', 'png'];
    final extension = fileName.split('.').last.toLowerCase();

    if (!allowedExtensions.contains(extension)) {
      showSnackBar(context, 'File $field harus berupa JPG, JPEG, atau PNG');
      return false;
    }

    return true;
  }
}
