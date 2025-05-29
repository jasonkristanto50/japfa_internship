import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:japfa_internship/function_variable/api_service_function.dart';
import 'package:japfa_internship/function_variable/file_uploading.dart';
import 'package:japfa_internship/function_variable/public_function.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/navbar.dart';
import 'package:japfa_internship/components/widget_component.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class KunjunganStudiDashboard extends StatefulWidget {
  const KunjunganStudiDashboard({super.key});

  @override
  State<KunjunganStudiDashboard> createState() =>
      _KunjunganStudiDashboardState();
}

class _KunjunganStudiDashboardState extends State<KunjunganStudiDashboard> {
  String searchQuery = "";
  List<KunjunganStudiData> kunjunganList = [];
  String pathFileResponJapfa = '-';

  @override
  void initState() {
    super.initState();
    _fetchKunjunganData();
  }

  @override
  Widget build(BuildContext context) {
    // Filter kunjunganData based on search query
    List<KunjunganStudiData> filteredKunjunganData = kunjunganList
        .where((kunjungan) => kunjungan.asalUniversitas
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: Navbar(
        context: context,
        title: appName,
      ),
      body: Container(
        decoration: buildJapfaLogoBackground(),
        child: Column(
          children: [
            // Search bar
            CustomSearchBar(
              labelSearchBar: "Ketikkan nama universitas",
              widthValue: 1500.w,
              onChanged: (value) {
                setState(() {
                  searchQuery = value; // Update search query
                });
              },
            ),
            // Table Section - Centered
            _buildKunjunganStudiTable(filteredKunjunganData),
          ],
        ),
      ),
    );
  }

  Widget _buildKunjunganStudiTable(
    List<KunjunganStudiData> filteredKunjunganData,
  ) {
    return filteredKunjunganData.isEmpty
        ? buildEmptyDataMessage(dataName: "Kunjungan Studi")
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 700.h, // Set the maximum height
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: filteredKunjunganData.isEmpty
                      ? [] // Remove shadows if no data
                      : [
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
                      DataColumn(label: Text('Asal Universitas')),
                      DataColumn(label: Text('Tanggal')),
                      DataColumn(label: Text('Jam Kegiatan')),
                      DataColumn(label: Text('Nama Perwakilan')),
                      DataColumn(label: Text('Peserta')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Aksi')),
                    ],
                    rows: filteredKunjunganData.map((kunjungan) {
                      String infoJamDariSesi = kunjungan.jamKegiatan == 'sesi1'
                          ? 'Sesi 1 ($durasiSesi1)'
                          : (kunjungan.jamKegiatan == 'sesi2'
                              ? 'Sesi 2 ($durasiSesi2)'
                              : '');
                      return DataRow(
                        cells: [
                          DataCell(Text(
                            kunjungan.asalUniversitas,
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            kunjungan.tanggalKegiatan,
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            infoJamDariSesi,
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            kunjungan.namaPerwakilan,
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            kunjungan.jumlahPeserta.toString(),
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            kunjungan.status,
                            textAlign: TextAlign.center,
                            style: bold18.copyWith(
                              color: kunjungan.status == 'Diterima'
                                  ? Colors.green
                                  : kunjungan.status == 'Ditolak'
                                      ? Colors.red
                                      : kunjungan.status == 'Menunggu'
                                          ? Colors.orange
                                          : Colors.black,
                            ),
                          )),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RoundedRectangleButton(
                                    title: "DETAIL",
                                    style: regular16,
                                    backgroundColor: lightOrange,
                                    height: 30,
                                    width: 100,
                                    rounded: 5,
                                    onPressed: () => _showDetail(kunjungan),
                                  ),
                                  SizedBox(width: 8.w),
                                  RoundedRectangleButton(
                                    title: "BIAYA",
                                    style: regular16,
                                    backgroundColor: lightOrange,
                                    height: 30,
                                    width: 100,
                                    rounded: 5,
                                    onPressed: () {},
                                  ),
                                  SizedBox(width: 8.w),
                                  RoundedRectangleButton(
                                    title: "UPLOAD",
                                    style: regular16,
                                    backgroundColor: lightOrange,
                                    height: 30,
                                    width: 100,
                                    rounded: 5,
                                    onPressed: () =>
                                        _showDialogUploadFileRespon(kunjungan),
                                  ),
                                  SizedBox(width: 8.w),
                                  RoundedRectangleButton(
                                    title: "RESPON",
                                    style: regular16,
                                    backgroundColor: lightBlue,
                                    height: 30,
                                    width: 100,
                                    rounded: 5,
                                    onPressed: () => _respond(kunjungan),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
  }

  // Fetch Kunjungan Studi data from API or Local source
  Future<void> _fetchKunjunganData() async {
    try {
      final response = await Dio().get(
          'http://localhost:3000/api/kunjungan_studi/fetch-all-kunjungan-data');
      final List<dynamic> data = response.data;

      setState(() {
        kunjunganList = data
            .map((item) => KunjunganStudiData.fromJson(
                item)) // Deserialize into KunjunganStudiData
            .toList();

        // Sort by date (tanggalKegiatan) in descending order (latest first)
        kunjunganList.sort((a, b) {
          // Parse the date format 'DD-MM-YYYY'
          final dateA =
              DateTime.parse(a.tanggalKegiatan.split('-').reversed.join('-'));
          final dateB =
              DateTime.parse(b.tanggalKegiatan.split('-').reversed.join('-'));
          return dateA.compareTo(dateB); // To sort in ascending order
        });
      });
    } catch (e) {
      print('Error fetching kunjungan studi data: $e');
    }
  }

  void _showDetail(KunjunganStudiData kunjungan) {
    String infoJamDariSesi = getInfoJamDariSesi(kunjungan.jamKegiatan);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Detail Kunjungan Studi',
              style: bold24,
            ),
          ),
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Left Column for Data
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDataInfoField(
                        label: 'Asal Universitas',
                        value: kunjungan.asalUniversitas,
                        verticalPadding: 5,
                      ),
                      buildDataInfoField(
                        label: 'Nama Perwakilan',
                        value: kunjungan.namaPerwakilan,
                        verticalPadding: 5,
                      ),
                      buildDataInfoField(
                        label: 'Tanggal Kegiatan',
                        value: kunjungan.tanggalKegiatan,
                        verticalPadding: 5,
                      ),
                      buildDataInfoField(
                        label: 'Jam Kegiatan',
                        value: infoJamDariSesi,
                        verticalPadding: 5,
                      ),
                      buildDataInfoField(
                        label: 'Jumlah Peserta',
                        value: kunjungan.jumlahPeserta.toString(),
                        verticalPadding: 5,
                      ),
                      buildDataInfoField(
                        label: 'Email',
                        value: kunjungan.email,
                        verticalPadding: 5,
                      ),
                      buildDataInfoField(
                        label: 'No. Telepon',
                        value: kunjungan.noTelp,
                        verticalPadding: 5,
                      ),
                      buildDataInfoField(
                        label: 'Status',
                        value: kunjungan.status,
                        verticalPadding: 5,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                // Right Column for Buttons
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildFileButton('Persetujuan Kampus', () {
                        launchURLImagePath(kunjungan.pathPersetujuanInstansi);
                      }),
                      const SizedBox(height: 20),
                      if (kunjungan.pathFileResponJapfa != null) ...[
                        buildFileButton('File Respon Japfa', () {
                          launchURLImagePath(kunjungan.pathFileResponJapfa!);
                        }),
                      ] else ...[
                        buildFileButton(
                          'Belum Ada Respon Japfa ',
                          backgroundColor: Colors.grey,
                          buttonText: "Tidak Ada File",
                          () {},
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ensure it takes minimum space
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the buttons
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center the row
                    children: [
                      RoundedRectangleButton(
                        title: "Tutup",
                        fontColor: japfaOrange,
                        backgroundColor: Colors.white,
                        outlineColor: japfaOrange,
                        width: 200.h,
                        height: 50.h,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 10),
                      RoundedRectangleButton(
                        title: "EDIT Tanggal",
                        style: regular14,
                        fontColor: Colors.white,
                        backgroundColor: japfaOrange,
                        width: 150,
                        height: 35,
                        rounded: 5,
                        // TODO: Buat Edit Tanggal
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _respond(KunjunganStudiData kunjungan) async {
    await showCustomConfirmRejectDialogWithNote(
      context: context,
      title: "Berikan Respon",
      message: "Mau menerima / menolak kunjungan ?",
      withNote: true,
      cancelColor: Colors.green,
      cancelText: "Terima",
      // Accepted actually
      onCancel: () {
        _handleResponse(kunjungan, true);
      },
      // Note hanya dikirim ke pengaju saat ditolak
      onReject: (note) {
        if (note == null) {
          _handleResponse(kunjungan, false);
        } else {
          _handleResponseWithNote(kunjungan, false, note);
        }
      },
    );
    setState(() {});
  }

  void _handleResponse(KunjunganStudiData kunjungan, bool isAccepted) async {
    // Update status locally first
    setState(() {
      kunjungan = kunjungan.copyWith(
        status: isAccepted ? statusKunjunganDiterima : statusKunjunganDitolak,
      );
    });

    // Prepare data payload
    final dataToUpdate = {
      'status': kunjungan.status, // Send the updated status
    };

    // Call the API to update the status in the backend
    try {
      final response = await Dio().put(
        'http://localhost:3000/api/kunjungan_studi/update_status/${kunjungan.idKunjunganStudi}',
        data: dataToUpdate,
      );

      if (response.statusCode == 200) {
        // Optionally, show a success message or handle UI updates
        print('Status updated to: ${kunjungan.status}');
        // Refresh data
        _fetchKunjunganData();
      } else {
        print('Failed to update status');
      }
    } catch (e) {
      print('Error updating status: $e');
      setState(() {
        kunjungan =
            kunjungan.copyWith(status: 'Pending'); // Clear the note on error
      });
    }
  }

  void _handleResponseWithNote(
      KunjunganStudiData kunjungan, bool isAccepted, String catatan) async {
    // Update status locally first
    setState(() {
      kunjungan = kunjungan.copyWith(
        status: isAccepted ? statusKunjunganDiterima : statusKunjunganDitolak,
        catatanHr: catatan, // Include the note here
      );
    });

    // Prepare data payload
    final dataToUpdate = {
      'status': kunjungan.status, // Send the updated status
      'catatan_hr': kunjungan.catatanHr
    };

    // Call the API to update the status in the backend
    try {
      final response = await Dio().put(
        'http://localhost:3000/api/kunjungan_studi/update_status-catatan/${kunjungan.idKunjunganStudi}',
        data: dataToUpdate,
      );

      if (response.statusCode == 200) {
        // Optionally, show a success message or handle UI updates
        print('Status updated to: ${kunjungan.status}');
        print('catatan_hr updated to: ${kunjungan.catatanHr}');
        // Refresh data
        _fetchKunjunganData();
      } else {
        print('Failed to update status');
      }
    } catch (e) {
      print('Error updating status: $e');
      setState(() {
        kunjungan = kunjungan.copyWith(
            status: 'Pending', catatanHr: null); // Clear the note on error
      });
    }
  }

  void _showDialogUploadFileRespon(KunjunganStudiData kunjungan) {
    String labelFieldPersetujuan = "File Respon";
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
                "UPLOAD FILE",
                style: bold20,
              )),
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    FileUploading().buildFileField(
                      labelFieldPersetujuan,
                      uploadedFileName,
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
                            backgroundColor: japfaOrange,
                            height: 50.h,
                            onPressed: () async {
                              if (uploadedFileBytes != null) {
                                // Call the upload file function
                                await _uploadFile(
                                  uploadedFileName!,
                                  uploadedFileBytes!,
                                );

                                // Call the API function to update the file path in the database
                                await updateFileResponJapfa(
                                  kunjungan.idKunjunganStudi,
                                  pathFileResponJapfa,
                                );

                                Navigator.of(context).pop(); // Close the dialog
                              } else {
                                showSnackBar(
                                    context, 'Please select a file to upload');
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
        pathFileResponJapfa = uploadFilePath;
      });
      print("FILE PATH : $pathFileResponJapfa");
    } catch (e) {
      print('Error uploading file: $e');
      showSnackBar(context, 'Error uploading file.');
    }
  }

  Future<void> updateFileResponJapfa(
      String id, String pathFileResponJapfa) async {
    try {
      await ApiService()
          .kunjunganStudiService
          .updatePathFileResponJapfa(id, pathFileResponJapfa);
    } catch (error) {
      print('Error while updating file response: $error');
      // You could handle further logic here, like showing a snackbar or alert
    }
  }
}
