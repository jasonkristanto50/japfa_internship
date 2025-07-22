import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:japfa_internship/function_variable/variable.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/models/kepala_departemen_data/kepala_departemen_data.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/models/logging_data/logging_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';
import 'package:japfa_internship/models/skill_peserta_magang_data/skill_peserta_magang_data.dart';
import 'package:japfa_internship/models/universitas_data/universitas_data.dart';

String baseUrlApi = '$baseUrl/api';

enum EmailMessageType {
  daftarMagang,
  daftarKunjungan,
  statusMagang,
  statusKunjungan,
  tambahLinkMeet,
  tambahPembimbing,
  kirimOtp
}

class ApiService {
  final Dio _dio = Dio();

  final DepartemenService departemenService;
  final PesertaMagangService pesertaMagangService;
  final KunjunganStudiService kunjunganStudiService;
  final KepalaDepartemenService kepalaDepartemenService;
  final LogbookService logbookService;
  final SkillService skillService;
  final UniversitasService universitasService;

  ApiService()
      : departemenService = DepartemenService(Dio()),
        pesertaMagangService = PesertaMagangService(Dio()),
        kunjunganStudiService = KunjunganStudiService(Dio()),
        kepalaDepartemenService = KepalaDepartemenService(Dio()),
        logbookService = LogbookService(Dio()),
        skillService = SkillService(Dio()),
        universitasService = UniversitasService(Dio());

  // Logging Service
  Future<void> addLog({
    required String logUser,
    required String logTable,
    required String logKey,
    required String logKeyValue,
    required String logType,
    required String logDetail,
  }) async {
    try {
      // Create a LoggingData instance
      final loggingData = LoggingData(
        logDate: DateTime.now(),
        logUser: logUser,
        logTable: logTable,
        logKey: logKey,
        logKeyValue: logKeyValue,
        logType: logType,
        logDetail: logDetail,
      );

      // Send the JSON representation of LoggingData
      final response = await _dio.post(
        '$baseUrlApi/logging/add-log',
        data: loggingData.toJson(),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to log action: ${response.data}');
      } else {
        print('Log action recorded successfully: ${response.data}');
      }
    } catch (error) {
      print('Error logging action: $error');
    }
  }

  // SEND EMAIL
  Future<void> sendEmail(
    String email,
    String name,
    String pin,
    EmailMessageType messageType,
  ) async {
    try {
      final response = await _dio.post(
        '$baseUrlApi/email/send-email',
        data: {
          'email': email,
          'name': name,
          'pin': pin,
          'messageType':
              messageType.toString().split('.').last, // Convert enum to string
        },
      );

      if (response.statusCode == 200) {
        print('Email sent successfully: ${response.data}');
      } else {
        throw Exception('Failed to send email');
      }
    } catch (error) {
      print('Error sending email: $error');
      rethrow;
    }
  }

  // UPLOAD FILE
  Future<String> uploadFileToServer(
      Uint8List fileBytes, String fileName) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
    });

    try {
      final response = await Dio().post(
        '$baseUrlApi/file_upload/upload-file',
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['filePath']; // Adjust based on server response
      } else {
        throw Exception('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      // Simplified error handling
      throw Exception('An error occurred while uploading the file: $e');
    }
  }
}

class DepartemenService {
  final Dio _dio;
  final baseUrlDepartemen = '$baseUrlApi/departemen';

  DepartemenService(this._dio);

  Future<void> updateMaxKuotaDepartemen(String id, int maxKuota) async {
    try {
      final response = await Dio().put(
        '$baseUrlDepartemen/update-max-kuota/$id',
        data: {'max_kuota': maxKuota},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update max kuota');
      }
    } catch (e) {
      print('Error updating max kuota: $e');
      rethrow;
    }
  }

  // Fetch all department data with count data updated
  Future<List<DepartemenData>> fetchDepartemenDataUpdateCount() async {
    try {
      final response = await _dio
          .get('$baseUrlDepartemen/fetch-all-departemen-data-updated');

      if (response.statusCode == 200) {
        List<DepartemenData> departemenList = (response.data as List)
            .map((item) => DepartemenData.fromJson(item))
            .toList();

        return departemenList; // Return the updated list from the server
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      print('Error fetching departments: $e');
      rethrow; // Rethrow the exception for handling in the widget
    }
  }

  // Function to update deskripsi and syarat for a department
  Future<DepartemenData> updateDepartemenDeskripsiSyarat(String departmentName,
      String deskripsi, List<String> syaratDepartemen) async {
    try {
      final response = await _dio.put(
        '$baseUrlDepartemen/update-deskripsi-syarat/$departmentName',
        data: {
          'deskripsi': deskripsi,
          'syarat_departemen': syaratDepartemen,
        },
      );

      if (response.statusCode == 200) {
        // Map the response data to the DepartemenData object
        return DepartemenData.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to update department');
      }
    } catch (e) {
      print('Error updating department: $e');
      rethrow; // Rethrow the exception for handling in the widget
    }
  }
}

class PesertaMagangService {
  final Dio _dio;
  final baseUrlPesertaMagang = '$baseUrlApi/peserta_magang';

  PesertaMagangService(this._dio);

  // Submit peserta magang
  Future<void> submitPesertaMagang(PesertaMagangData data) async {
    try {
      // Replace the URL with your actual endpoint
      final response = await _dio.post(
        '$baseUrlPesertaMagang/submit-peserta-magang',
        data: data.toJson(),
      );

      if (response.statusCode == 201) {
        print('Peserta Magang submitted successfully!');
      } else {
        print('Failed to submit Peserta Magang');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<List<PesertaMagangData>> fetchPesertaMagangData() async {
    try {
      final response =
          await _dio.get('$baseUrlPesertaMagang/fetch-all-peserta-data');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data; // Adjust based on your API response
        return data.map((item) => PesertaMagangData.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      rethrow;
    }
  }

  /// Get peserta magang data by EMAIL
  Future<PesertaMagangData> fetchPesertaMagangByEmail(String email) async {
    try {
      final encodedEmail = Uri.encodeComponent(email);

      final response = await _dio.get(
        '$baseUrlPesertaMagang/fetch-peserta-data/$encodedEmail',
      );

      if (response.statusCode == 200) {
        final body = response.data;

        // server returns a single object  { ... }
        if (body is Map<String, dynamic>) {
          return PesertaMagangData.fromJson(body);
        }

        // server returns an array with one object  [ { ... } ]
        if (body is List &&
            body.isNotEmpty &&
            body.first is Map<String, dynamic>) {
          return PesertaMagangData.fromJson(body.first as Map<String, dynamic>);
        }
      }

      throw Exception('No Peserta Magang found for $email');
    } on DioException catch (e) {
      final msg = e.response?.data?['error'] ?? e.message;
      throw Exception('Failed to fetch Peserta Magang data: $msg');
    }
  }

  // Get peserta by pembimbing
  Future<List<PesertaMagangData>> fetchDataByPembimbing(
      String namaPembimbing) async {
    try {
      final response = await _dio.get(
          '$baseUrlPesertaMagang/fetch-data-by-pembimbing/$namaPembimbing');
      final List<dynamic> data = response.data;

      return data.map((item) => PesertaMagangData.fromJson(item)).toList();
    } on DioException catch (e) {
      print('Error fetching data: ${e.message}');
      // Handle errors appropriately (e.g. throw custom exception)
      throw Exception('Failed to fetch data');
    }
  }

  // Update Password Token
  Future<PesertaMagangData> updatePesertaMagangPasswordToken(
      String email, String passwordToken) async {
    try {
      // Check if passwordToken is null before proceeding
      // ignore: unnecessary_null_comparison
      if (passwordToken == null) {
        throw Exception('Password token cannot be null');
      }

      final response = await _dio.put(
        '$baseUrlPesertaMagang/update-password-token/$email',
        data: {'password_token': passwordToken},
      );

      if (response.statusCode == 200) {
        // If the response structure contains password_token
        return PesertaMagangData.fromJson(response.data);
      } else {
        throw Exception('Failed to update password token: ${response.data}');
      }
    } catch (error) {
      print('Error updating password token: $error'); // Log the error
      throw Exception('Error updating password token: $error');
    }
  }

  // Update path Laporan Akhir
  Future<void> updatePathLaporanAkhir(
      String email, String pathLaporanAkhir) async {
    final path = '$baseUrlPesertaMagang/update-path-laporan-akhir-email/$email';

    try {
      final response = await _dio.put(
        path,
        data: {
          'path_laporan_akhir': pathLaporanAkhir,
        },
      );

      if (response.statusCode == 200) {
        print('path updated successfully');
      } else {
        throw Exception('Failed to update path: ${response.data}');
      }
    } catch (e) {
      print('Error updating path: $e');
      rethrow;
    }
  }

  Future<int> countPesertaMagang() async {
    try {
      final response = await _dio.get('$baseUrlPesertaMagang/count');
      if (response.statusCode == 200) {
        return response.data['count']; // Adjust according to your API response
      } else {
        throw Exception('Failed to fetch count');
      }
    } catch (e) {
      print('Error fetching count: $e');
      rethrow; // Rethrow the error for handling in the caller
    }
  }

  // Fetch peserta magang count with specific department
  Future<int> fetchPengajuanCount(String departmentName) async {
    try {
      final response = await _dio.get(
          '$baseUrlPesertaMagang/count-pengajuan-for-department/$departmentName');
      if (response.statusCode == 200) {
        return response.data['data']['total_count'];
      } else {
        throw Exception('Failed to fetch pengajuan count');
      }
    } catch (e) {
      print('Error fetching pengajuan count: $e');
      return 0; // Return 0 if error occurs
    }
  }

  // Fetch peserta magang Approved count with specific department
  Future<int> fetchApprovedCount(String departmentName) async {
    try {
      final response = await _dio.get(
          '$baseUrlPesertaMagang/count-approved-for-department/$departmentName');
      if (response.statusCode == 200) {
        return response.data['data']['total_approved'];
      } else {
        throw Exception('Failed to fetch approved count');
      }
    } catch (e) {
      print('Error fetching approved count: $e');
      return 0; // Return 0 if error occurs
    }
  }

  Future<PesertaMagangData?> updatePesertaMagangStatus(
      String idMagang, String newStatus) async {
    final url = '$baseUrlPesertaMagang/update-status/$idMagang';

    try {
      final response = await _dio.put(
        url,
        data: {
          'status_magang': newStatus,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Return the updated PesertaMagangData
        return PesertaMagangData.fromJson(response.data['data']);
      } else {
        // Handle other status codes appropriately
        return null; // or handle accordingly
      }
    } catch (e) {
      // Handle Dio errors: you can log or throw exceptions here
      print('Dio error: $e');
      return null; // or handle accordingly
    }
  }

  Future<bool> updatePesertaMagangStatusWithNote({
    required String idMagang,
    required String status,
    required String? catatanHr,
  }) async {
    final payload = {
      'status_magang': status,
      'catatan_hr': catatanHr,
    };

    final Response res = await _dio.put(
      '$baseUrlPesertaMagang/update_status-catatan/$idMagang',
      data: payload,
    );

    return res.statusCode == 200;
  }

// Update Peserta Magang LINK WAWANCARA by ID
  Future<void> updateLinkMeet(String id, String newLink,
      String tanggalInterview, String jamInterview) async {
    try {
      final response = await _dio.put(
        '$baseUrlPesertaMagang/update-link-meet/$id',
        data: {
          'link_meet_interview': newLink,
          'tanggal_interview': tanggalInterview,
          'jam_interview': jamInterview,
        },
      );

      if (response.statusCode == 200) {
        // Handle success, e.g., update local data or notify user
        print('Link updated successfully: ${response.data}');
      } else {
        throw Exception('Failed to update link: ${response.data}');
      }
    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        print('Error: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      rethrow; // Rethrow or handle as needed
    } catch (e) {
      // Handle other errors
      print('Error: ${e.toString()}');
      rethrow;
    }
  }

  // Update Catatan Hasil Wawancara by ID
  Future<void> updateCatatanHasilInterview(
      String id, String catatanHasilInterview) async {
    try {
      final response = await _dio.post(
        '$baseUrlPesertaMagang/update-catatan-hasil-interview/$id',
        data: {
          'catatan_hasil_interview': catatanHasilInterview,
        },
      );

      if (response.statusCode == 200) {
        // Handle success, e.g., update local data or notify user
        print('Catatan updated successfully: ${response.data}');
      } else {
        throw Exception('Failed to update catatan: ${response.data}');
      }
    } on DioException catch (e) {
      // Handle Dio errors
      if (e.response != null) {
        print('Error: ${e.response?.data}');
      } else {
        print('Error: ${e.message}');
      }
      rethrow; // Rethrow or handle as needed
    } catch (e) {
      // Handle other errors
      print('Error: ${e.toString()}');
      rethrow;
    }
  }

  Future<String?> fetchPembimbingByEmail(String email) async {
    try {
      final response = await _dio
          .get('$baseUrlPesertaMagang/fetch-pembimbing-by-email/$email');
      if (response.statusCode == 200) {
        return response.data['nama_pembimbing'];
      } else {
        print('Error: ${response.data['nama_pembimbing']}');
        return null; // or handle not found scenario
      }
    } catch (e) {
      print('Error fetching pembimbing: $e');
      return null; // Handle error appropriately
    }
  }

  // Set Pembimbing to Peserta
  Future<void> updateNamaPembimbing(String id, String namaPembimbing) async {
    try {
      final response = await _dio.put(
        '$baseUrlPesertaMagang/update-nama-pembimbing/$id',
        data: {
          'nama_pembimbing': namaPembimbing,
        },
      );

      if (response.statusCode == 200) {
        print('Nama pembimbing updated successfully: ${response.data}');
      } else {
        print('Failed to update nama pembimbing: ${response.data}');
      }
    } on DioException catch (e) {
      // Handle Dio error
      print('Error updating nama pembimbing: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
      }
    } catch (e) {
      // Handle any other errors
      print('Unexpected error: $e');
    }
  }

  // Update validasi_laporan_akhir by ID
  Future<void> validasiLaporanAkhir(
    String idMagang,
    String statusValidasi,
  ) async {
    try {
      final response = await _dio.put(
        '$baseUrlPesertaMagang/validasi-laporan-akhir/$idMagang',
        data: {
          'validasi_laporan_akhir': statusValidasi,
        },
      );

      if (response.statusCode == 200) {
        print('Laporan Akhir validated successfully: ${response.data}');
      } else {
        throw Exception('Failed to validate laporan akhir: ${response.data}');
      }
    } catch (e) {
      print('Error validating laporan akhir: $e');
      throw Exception('Error validating laporan akhir: $e');
    }
  }
}

class KunjunganStudiService {
  final Dio _dio;
  final baseUrlKunjunganStudi = '$baseUrlApi/kunjungan_studi';

  KunjunganStudiService(this._dio);

  // Submit kunjungan studi
  Future<Response> submitKunjunganStudi(
      KunjunganStudiData kunjunganStudi) async {
    String url = '$baseUrlKunjunganStudi/submit-kunjungan-studi';

    return await Dio().post(
      url,
      data: kunjunganStudi.toJson(),
      options: Options(contentType: 'application/json'),
    );
  }

  // Fetch Kunjungan Studi data
  Future<List<KunjunganStudiData>> fetchKunjunganData() async {
    try {
      final response =
          await _dio.get('$baseUrlKunjunganStudi/fetch-all-kunjungan-data');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        // Deserialize into KunjunganStudiData
        List<KunjunganStudiData> kunjunganList =
            data.map((item) => KunjunganStudiData.fromJson(item)).toList();

        // Sort by date (tanggalKegiatan) in descending order (latest first)
        kunjunganList.sort((a, b) {
          final dateA =
              DateTime.parse(a.tanggalKegiatan.split('-').reversed.join('-'));
          final dateB =
              DateTime.parse(b.tanggalKegiatan.split('-').reversed.join('-'));
          return dateB.compareTo(dateA); // To sort in descending order
        });

        return kunjunganList; // Return the sorted list
      } else {
        throw Exception('Failed to fetch Kunjungan Studi data');
      }
    } catch (e) {
      print('Error fetching kunjungan studi data: $e');
      rethrow; // Rethrow the exception for higher-level handling
    }
  }

  // Fetch Kunjungan Studi Data by Email
  Future<List<KunjunganStudiData>> fetchKunjunganDataByEmail(
    String email,
  ) async {
    final response =
        await _dio.get('$baseUrlKunjunganStudi/fetch-kunjungan-data/$email');

    if (response.statusCode == 200) {
      // Assuming that the response is a list of kunjungan studi data
      final List<dynamic> data = response.data;
      return data.map((json) => KunjunganStudiData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Kunjungan Studi data');
    }
  }

  // Method to update the path_file_respon_japfa
  Future<void> updatePathFileResponJapfa(
      String id, String pathFileResponJapfa) async {
    try {
      final response = await _dio.put(
        '$baseUrlKunjunganStudi/update_path_file_respon_japfa/$id',
        data: {
          'path_file_respon_japfa': pathFileResponJapfa,
        },
      );

      if (response.statusCode == 200) {
        // Handle success
        print('File response updated successfully: ${response.data}');
      } else {
        // Handle error
        print('Failed to update file response: ${response.data}');
      }
    } catch (e) {
      print('Error updating file response: $e');
      rethrow; // Rethrow the exception for further handling
    }
  }

  // Method to update the tanggal_kegiatan
  Future<void> updateTanggalKegiatan(String id, String tanggalKegiatan) async {
    try {
      final response = await _dio.put(
        '$baseUrlKunjunganStudi/update-tanggal/$id',
        data: {
          'tanggal_kegiatan': tanggalKegiatan,
        },
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Tanggal updated successfully: ${response.data}');
      } else {
        // Handle error
        print('Failed to update tanggal: ${response.data}');
      }
    } catch (e) {
      print('Error updating tanggal: $e');
      rethrow; // Rethrow the exception for further handling
    }
  }

  // Fetch the current count of kunjungan studi
  Future<int> fetchCurrentCount() async {
    try {
      final countResponse = await _dio.get('$baseUrlKunjunganStudi/count');
      if (countResponse.statusCode == 200) {
        return int.parse(countResponse.data['count']);
      } else {
        throw Exception('Failed to fetch current count');
      }
    } catch (e) {
      print('Error fetching current count: $e');
      rethrow; // Rethrow the exception for higher-level handling
    }
  }
}

class KepalaDepartemenService {
  final Dio _dio;
  final baseUrlKepalaDepartemen = '$baseUrlApi/kepala_departemen';

  KepalaDepartemenService(this._dio);

  // Function to create a new kepala departemen
  Future<void> addKepalaDepartemen(KepalaDepartemenData data) async {
    try {
      final response = await _dio.post(
          '$baseUrlKepalaDepartemen/add-new-kepala-departemen',
          data: data.toJson());
      if (response.statusCode == 201) {
        print('Kepala Departemen created successfully!');
      } else {
        throw Exception('Failed to create Kepala Departemen');
      }
    } catch (error) {
      print('Error creating kepala departemen: $error');
      rethrow; // Rethrow error for further handling if needed
    }
  }

  Future<List<KepalaDepartemenData>> fetchAllKepalaDepartemen() async {
    try {
      final response = await _dio
          .get('$baseUrlKepalaDepartemen/fetch-all-kepala-departemen');
      if (response.statusCode == 200) {
        // Parse the JSON response to a list of KepalaDepartemen instances
        final List<dynamic> data = response.data;
        return data.map((item) => KepalaDepartemenData.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load kepala departemen');
      }
    } catch (error) {
      print('Error fetching kepala departemen: $error');
      rethrow; // Rethrow the error for further handling if needed
    }
  }

  // Function to fetch the count of kepala departemen
  Future<int> fetchKepalaDepartemenCount() async {
    try {
      final response = await _dio
          .get('$baseUrlKepalaDepartemen/count-jumlah-kepala-departemen');
      if (response.statusCode == 200) {
        return response.data['count']; // Return the count
      } else {
        throw Exception('Failed to fetch count');
      }
    } catch (error) {
      print('Error fetching count: $error');
      rethrow; // Rethrow error for further handling if needed
    }
  }

  // Endpoint to update kepala departemen status
  Future<void> updateKepalaDepartemenStatus(String id, String status) async {
    try {
      final response = await _dio.put(
        '$baseUrlKepalaDepartemen/update-status/$id',
        data: {'status': status},
      );

      if (response.statusCode == 200) {
        print('Status updated successfully: ${response.data}');
      } else {
        throw Exception('Failed to update status: ${response.data}');
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data ?? e.message}');
      throw Exception('Error updating status');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Error updating status');
    }
  }
}

class LogbookService {
  final Dio _dio;
  final baseUrlLogbook = '$baseUrlApi/logbook';

  LogbookService(this._dio);

  ///  // Method to add a new logbook
  Future<void> addLogbook(LogbookPesertaMagangData logbook) async {
    try {
      final response = await _dio.post('$baseUrlLogbook/add-logbook',
          data: logbook.toJson());

      if (response.statusCode == 201) {
        print('Logbook created successfully!');
      } else {
        throw Exception('Failed to create logbook: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error adding logbook: $e');
      rethrow; // Re-throw the error for further handling
    }
  }

  Future<void> updateLogbook(LogbookPesertaMagangData logbook) async {
    final url = '$baseUrlLogbook/update-logbook/${logbook.idLogbook}';

    try {
      final response = await _dio.put(
        url,
        data: {
          'nama_aktivitas': logbook.namaAktivitas,
          'tanggal': logbook.tanggalAktivitas,
          'url': logbook.urlLampiran,
        },
      );

      if (response.statusCode == 200) {
        print('Logbook updated successfully');
      } else {
        throw Exception('Failed to update logbook: ${response.data}');
      }
    } catch (e) {
      print('Error updating logbook: $e');
      rethrow; // Optionally, rethrow the error for handling at a higher level
    }
  }

  // Method to fetch logbook data by email
  Future<List<LogbookPesertaMagangData>> fetchLogbookByEmail(
      String email) async {
    try {
      final response = await _dio.get('$baseUrlLogbook/fetch-by-email/$email');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((item) => LogbookPesertaMagangData.fromJson(item))
            .toList(); // Returning the fetched logbooks as a list of LogbookPesertaMagangData
      } else {
        throw Exception('Failed to fetch logbooks: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching logbooks: $e');
      rethrow; // Re-throw the error for further handling
    }
  }

  // Method to get the count of logbook entries
  Future<int?> countLogbooks() async {
    try {
      final response = await _dio.get('$baseUrlLogbook/count-logbooks');
      if (response.statusCode == 200) {
        return int.tryParse(response.data['total']) ?? 0; // Return total count
      } else {
        throw Exception('Failed to fetch logbook count');
      }
    } catch (e) {
      print('Error getting logbook count: $e');
      return null; // Return null if there's an error
    }
  }

  // Validasi logbook
  Future<void> updateLogbookValidation(
    String idLogbook,
    bool validasiPembimbing,
  ) async {
    try {
      await _dio.patch('$baseUrlLogbook/validasi-logbook/$idLogbook', data: {
        'validasi_pembimbing': validasiPembimbing,
      });
      print('Validasi updated successfully'); // Optional logging
    } on DioException catch (e) {
      print('Error updating validation: ${e.message}');
      // Handle errors appropriately (e.g., throw custom exception)
      throw Exception('Failed to update validation');
    }
  }

  Future<void> updateCatatanPembimbing(
    String idLogbook,
    String catatanPembimbing,
  ) async {
    try {
      await _dio.patch('$baseUrlLogbook/catatan-logbook/$idLogbook', data: {
        'catatan_pembimbing': catatanPembimbing,
      });
      print('Catatan updated successfully'); // Optional logging
    } on DioException catch (e) {
      print('Error updating catatan: ${e.message}');
      throw Exception('Failed to update catatan');
    }
  }

  // Delete logbook by id
  Future<void> deleteLogbook(String idLogbook) async {
    try {
      final response =
          await _dio.delete('$baseUrlLogbook/delete-logbook/$idLogbook');

      if (response.statusCode == 200) {
        print('Logbook deleted successfully!');
      } else {
        throw Exception('Failed to delete logbook: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error deleting logbook: $e');
      rethrow; // Re-throw the error for further handling
    }
  }
}

class SkillService {
  final Dio _dio;
  final baseUrlSkill = '$baseUrlApi/skill_peserta';

  SkillService(this._dio);

  // FUZZY LOGIC ----------------------------------------------------------------------------------
  Future<Map<String, dynamic>> calculateFuzzyScores({
    required int totalSoftskill,
    required int banyakProyek,
    required double nilaiUniv,
    required String akreditasiUniversitas,
    required String jurusan,
  }) async {
    try {
      final response = await _dio.post('$baseUrlSkill/fuzzy-scale', data: {
        'total_softskill': totalSoftskill,
        'banyak_proyek': banyakProyek,
        'nilai_univ': nilaiUniv,
        'akreditasi_universitas': akreditasiUniversitas,
        'jurusan': jurusan,
      });

      // Return the response data
      return response.data;
    } on DioException catch (e) {
      // Handle error and return informative message
      if (e.response != null) {
        print('Error: ${e.response?.data}');
        throw Exception('Error: ${e.response?.data['error']}');
      } else {
        print('Error: ${e.message}');
        throw Exception('Error: ${e.message}');
      }
    }
  }

  // Function to add a new skill
  Future<void> addSkill(SkillPesertaMagangData skill) async {
    try {
      final response = await _dio.post(
        '$baseUrlSkill/add-skill',
        data: skill.toJson(), // Convert to JSON
      );
      print('Skill added successfully: ${response.data}');
    } catch (e) {
      print('Error adding skill: $e');
    }
  }

// Function to fetch all skills
  Future<List<SkillPesertaMagangData>> fetchAllSkills() async {
    try {
      final response = await _dio.get('$baseUrlSkill/fetch-all-skills');

      // Assuming the response data is a list of objects
      List<dynamic> data = response.data;

      // Parse the data into a list of SkillPesertaMagangData objects
      List<SkillPesertaMagangData> skills =
          data.map((item) => SkillPesertaMagangData.fromJson(item)).toList();

      print(
          'Fetched skills: ${skills.map((skill) => skill.namaPeserta).toList()}');
      return skills; // Return the list of skills
    } catch (e) {
      print('Error fetching skills: $e');
      return []; // Return an empty list in case of an error
    }
  }

// Function to fetch skill by email
  Future<SkillPesertaMagangData> fetchSkillByEmail(String email) async {
    try {
      final response =
          await _dio.get('$baseUrlSkill/fetch-skill-by-email/$email');

      if (response.statusCode == 200) {
        final body = response.data;

        // Check if the response body is a map and parse it
        if (body is Map<String, dynamic>) {
          return SkillPesertaMagangData.fromJson(body);
        }

        // If the response is a list, handle the first object in the list
        if (body is List &&
            body.isNotEmpty &&
            body.first is Map<String, dynamic>) {
          return SkillPesertaMagangData.fromJson(
              body.first as Map<String, dynamic>);
        }

        throw Exception('No valid skill data found');
      } else {
        throw Exception('Failed to fetch skill data');
      }
    } catch (e) {
      print('Error fetching skill by email: $e');
      throw Exception('Error fetching skill by email: $e');
    }
  }

  // Function to count all skills
  Future<int> countSkills() async {
    try {
      final response = await _dio.get('$baseUrlSkill/count-skills');

      if (response.statusCode == 200) {
        final count = response.data['count'] as int;
        print('Total skills count: $count');
        return count;
      } else {
        print('Failed to count skills: ${response.statusCode}');
        return 0;
      }
    } catch (e) {
      print('Error counting skills: $e');
      return 0;
    }
  }

  // Function to update a skill by email
  Future<void> updateSkillByEmail(
      String email, SkillPesertaMagangData skill) async {
    try {
      final response = await _dio.put(
        '$baseUrlSkill/update-skill-by-email/$email',
        data: skill.toJson(),
      );
      print('Skill updated successfully: ${response.data}');
    } catch (e) {
      print('Error updating skill: $e');
    }
  }

  // Function to delete all skills
  Future<void> deleteAllSkills() async {
    try {
      final response = await _dio.delete('$baseUrlSkill/delete-all-skills');
      print('All skills deleted: ${response.data}');
    } catch (e) {
      print('Error deleting all skills: $e');
    }
  }

  // Function to delete a skill by ID
  Future<void> deleteSkillById(String idSkill) async {
    try {
      final response = await _dio.delete('$baseUrlSkill/delete-skill/$idSkill');
      print('Skill deleted successfully: ${response.data}');
    } catch (e) {
      print('Error deleting skill: $e');
    }
  }
}

class UniversitasService {
  final Dio _dio;
  final baseUrlUniversitas = '$baseUrlApi/universitas';
  UniversitasService(this._dio);

  // Fetch all universitas
  Future<List<UniversitasData>> fetchUniversitasData() async {
    try {
      final response =
          await _dio.get('$baseUrlUniversitas/fetch-all-universitas');

      if (response.statusCode == 200) {
        List<UniversitasData> universitasList = (response.data as List)
            .map((item) => UniversitasData.fromJson(item))
            .toList();

        return universitasList; // Return the updated list from the server
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      print('Error fetching departments: $e');
      rethrow; // Rethrow the exception for handling in the widget
    }
  }
}
