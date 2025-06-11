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
  TextEditingController editedTanggalController = TextEditingController();
  String? currentStatus = "Semua"; // Default status filter

  @override
  void initState() {
    super.initState();
    _fetchKunjunganData();
  }

  @override
  Widget build(BuildContext context) {
    // Filter kunjunganData based on search query
    List<KunjunganStudiData> filteredKunjunganData =
        kunjunganList.where((kunjungan) {
      bool matchesUniversity = kunjungan.asalUniversitas
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      bool matchesStatus =
          currentStatus == "Semua" || kunjungan.status == currentStatus;

      return matchesUniversity && matchesStatus;
    }).toList();

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
            _buildKunjunganStatusFilterButton(),
            _buildKunjunganStudiTable(filteredKunjunganData),
          ],
        ),
      ),
    );
  }

  // Build buttons to filter by status
  Widget _buildKunjunganStatusFilterButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedRectangleButton(
            title: "Semua",
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor:
                currentStatus == "Semua" ? japfaOrange : Colors.grey,
            outlineColor:
                currentStatus == "Semua" ? japfaOrange : Colors.transparent,
            onPressed: () {
              setState(() {
                currentStatus = "Semua";
              });
            },
          ),
          const SizedBox(width: 10),
          // DITERIMA
          RoundedRectangleButton(
            title: statusKunjunganDiterima,
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusKunjunganDiterima
                ? Colors.green
                : Colors.grey,
            onPressed: () {
              setState(() {
                currentStatus = statusKunjunganDiterima;
              });
            },
          ),
          const SizedBox(width: 10),
          // DITOLAK
          RoundedRectangleButton(
            title: statusKunjunganDitolak,
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusKunjunganDitolak
                ? Colors.red
                : Colors.grey,
            onPressed: () {
              setState(() {
                currentStatus = statusKunjunganDitolak;
              });
            },
          ),
          const SizedBox(width: 10),
          // MENUNGGU
          RoundedRectangleButton(
            title: statusKunjunganMenunggu,
            style: bold14,
            width: 130.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusKunjunganMenunggu
                ? Colors.orange
                : Colors.grey,
            onPressed: () {
              setState(() {
                currentStatus = statusKunjunganMenunggu; // Filter by "Menunggu"
              });
            },
          ),
          const SizedBox(width: 10),
          RoundedRectangleButton(
            title: statusKunjunganSelesai,
            style: bold14,
            width: 120.w,
            height: 40.h,
            fontColor: Colors.white,
            backgroundColor: currentStatus == statusKunjunganSelesai
                ? Colors.blue
                : Colors.grey,
            onPressed: () {
              setState(() {
                currentStatus = statusKunjunganSelesai;
              });
            },
          ),
        ],
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
                  scrollDirection: Axis.vertical,
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
                        String infoJamDariSesi =
                            kunjungan.jamKegiatan == 'sesi1'
                                ? 'Sesi 1 ($durasiSesi1)'
                                : (kunjungan.jamKegiatan == 'sesi2'
                                    ? 'Sesi 2 ($durasiSesi2)'
                                    : '');
                        return DataRow(
                          cells: [
                            DataCell(Text(kunjungan.asalUniversitas,
                                textAlign: TextAlign.center)),
                            DataCell(Text(kunjungan.tanggalKegiatan,
                                textAlign: TextAlign.center)),
                            DataCell(Text(infoJamDariSesi,
                                textAlign: TextAlign.center)),
                            DataCell(Text(kunjungan.namaPerwakilan,
                                textAlign: TextAlign.center)),
                            DataCell(Text(kunjungan.jumlahPeserta.toString(),
                                textAlign: TextAlign.center)),
                            DataCell(Text(
                              kunjungan.status,
                              textAlign: TextAlign.center,
                              style: bold18.copyWith(
                                color:
                                    getStatusKunjunganColor(kunjungan.status),
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
                                      title: "UPLOAD",
                                      style: regular16,
                                      backgroundColor: lightOrange,
                                      height: 30,
                                      width: 100,
                                      rounded: 5,
                                      onPressed: () =>
                                          _showDialogUploadFileRespon(
                                              kunjungan),
                                    ),
                                    SizedBox(width: 8.w),
                                    RoundedRectangleButton(
                                      title: "RESPON",
                                      style: regular16,
                                      backgroundColor:
                                          getColorButtonRespondKunjungan(
                                              kunjungan.status),
                                      height: 30,
                                      width: 100,
                                      rounded: 5,
                                      onPressed: () =>
                                          _showRespondDialog(kunjungan),
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
            ),
          );
  }

  Future<void> _fetchKunjunganData() async {
    try {
      final data =
          await ApiService().kunjunganStudiService.fetchKunjunganData();
      setState(() {
        kunjunganList = data; // Update state with the fetched data
      });
    } catch (e) {
      print('Error loading data: $e');
      showSnackBar(context, "Gagal mengambil data kunjungan");
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        onPressed: () => _showEditTanggalDialog(kunjungan),
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

  void _showRespondDialog(KunjunganStudiData kunjungan) async {
    if (kunjungan.status == statusKunjunganMenunggu) {
      await showCustomConfirmRejectDialogWithNote(
        context: context,
        title: "Berikan Respon",
        message: "Mau menerima / menolak kunjungan ?",
        withNote: true,
        cancelColor: Colors.green,
        cancelText: "Terima",
        // DITERIMA
        onCancel: () {
          _handleResponse(kunjungan, true);
          showSnackBar(
            context,
            "Kunjungan Diterima",
            backgroundColor: darkGrey,
          );
        },
        // DITOLAK
        // Note hanya dikirim ke pengaju saat ditolak
        onReject: (note) {
          if (note == null) {
            _handleResponse(kunjungan, false);
            showSnackBar(
              context,
              "Kunjungan Ditolak",
              backgroundColor: darkGrey,
            );
          } else {
            _handleResponseWithNote(kunjungan, false, note);
            showSnackBar(
              context,
              "Kunjungan Ditolak",
              backgroundColor: darkGrey,
            );
          }
        },
      );
    } else if (kunjungan.status == statusKunjunganDiterima) {
      await showCustomConfirmRejectDialogWithNote(
        context: context,
        title: "Selesaikan Kunjungan",
        message: "Konfirmasi Kunjungan selesai ?",
        rejectColor: darkGrey,
        rejectText: "Selesai",
        withNote: false,
        onCancel: () {},
        // Note hanya dikirim ke pengaju saat ditolak
        onReject: (note) {
          _setKunjunganSelesai(kunjungan);
        },
      );
    }

    setState(() {});
  }

  void _setKunjunganSelesai(KunjunganStudiData kunjungan) async {
    // Update status locally first
    setState(() {
      kunjungan = kunjungan.copyWith(
        status: statusKunjunganSelesai,
      );
    });

    // Prepare data payload
    final dataToUpdate = {
      'status': kunjungan.status, // Send the updated status
    };

    // Call the API to update the status in the backend
    try {
      final response = await Dio().put(
        '$baseUrl/api/kunjungan_studi/update_status/${kunjungan.idKunjunganStudi}',
        data: dataToUpdate,
      );

      // Send email with password token
      await ApiService().sendEmail(
        kunjungan.email,
        kunjungan.namaPerwakilan,
        kunjungan.passwordToken!,
        EmailMessageType.statusKunjungan,
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
        '$baseUrl/api/kunjungan_studi/update_status/${kunjungan.idKunjunganStudi}',
        data: dataToUpdate,
      );

      // Send email with password token
      await ApiService().sendEmail(
        kunjungan.email,
        kunjungan.namaPerwakilan,
        kunjungan.passwordToken!,
        EmailMessageType.statusKunjungan,
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
        '$baseUrl/api/kunjungan_studi/update_status-catatan/${kunjungan.idKunjunganStudi}',
        data: dataToUpdate,
      );

      // Send email with password token
      await ApiService().sendEmail(
        kunjungan.email,
        kunjungan.namaPerwakilan,
        kunjungan.passwordToken!,
        EmailMessageType.statusKunjungan,
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

  void _showEditTanggalDialog(KunjunganStudiData kunjungan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: "Edit Tanggal Kegiatan",
          numberOfField: 1,
          controllers: [editedTanggalController],
          labels: const ["Tanggal Kegiatan Baru"],
          fieldTypes: const [
            BuildFieldTypeController.date,
          ],
          onSave: () {
            _updateTanggal(kunjungan, editedTanggalController.text);
            Navigator.of(context).pop(); // Close input tanggal page
            Navigator.of(context).pop(); // Close the detail page
          },
        );
      },
    );
  }

  // New function to handle updating the tanggal
  Future<void> _updateTanggal(
      KunjunganStudiData kunjungan, String newTanggalKegiatan) async {
    if (newTanggalKegiatan.isNotEmpty) {
      try {
        // Call the API to update the tanggal
        await ApiService().kunjunganStudiService.updateTanggalKegiatan(
            kunjungan.idKunjunganStudi, newTanggalKegiatan);

        // Refresh the list after updating
        await _fetchKunjunganData();
        showSnackBar(
          context,
          'Tanggal berhasil diperbarui!',
          backgroundColor: Colors.green,
        );
      } catch (e) {
        print('Error updating tanggal: $e');
        showSnackBar(context, 'Gagal memperbarui tanggal.');
      }
    } else {
      showSnackBar(context, 'Tanggal tidak boleh kosong.');
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
