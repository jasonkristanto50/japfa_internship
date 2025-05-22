import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/models/kepala_departemen_data/kepala_departemen_data.dart';
import 'package:japfa_internship/models/kunjungan_studi_data/kunjungan_studi_data.dart';
import 'package:japfa_internship/models/logbook_peserta_magang_data/logbook_peserta_magang_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';

class ApiService {
  final Dio _dio = Dio();

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////// SEND EMAIL ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> sendEmail(String email, String name, String pin) async {
    try {
      final response = await _dio.post(
        'http://localhost:3000/api/email/send-email',
        data: {
          'email': email,
          'name': name,
          'pin': pin,
        },
      );

      if (response.statusCode == 200) {
        print('Email sent successfully: ${response.data}');
      } else {
        throw Exception('Failed to send email');
      }
    } catch (error) {
      print('Error sending email: $error');
      rethrow; // Rethrow error for further handling if needed
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////// UPLOAD FILE ////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<String> uploadFileToServer(
      Uint8List fileBytes, String fileName) async {
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(fileBytes, filename: fileName),
    });

    try {
      final response = await Dio().post(
        'http://localhost:3000/api/file_upload/upload-file',
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

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////////////// PESERTA MAGANG  ////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Submit peserta magang
  Future<void> submitPesertaMagang(PesertaMagangData data) async {
    try {
      // Replace the URL with your actual endpoint
      final response = await _dio.post(
        'http://localhost:3000/api/peserta_magang/submit-peserta-magang',
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
      final response = await _dio.get(
          'http://localhost:3000/api/peserta_magang/fetch-all-peserta-data');
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
        'http://localhost:3000/api/peserta_magang/fetch-peserta-data/$encodedEmail',
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
          'http://localhost:3000/api/peserta_magang/fetch-data-by-pembimbing/$namaPembimbing');
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
        'http://localhost:3000/api/peserta_magang/update-password-token/$email',
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

  // Update URL Laporan Akhir
  Future<void> updateUrlLaporanAkhir(
      String email, String urlLaporanAkhir) async {
    final url =
        'http://localhost:3000/api/peserta_magang/update-url-laporan-akhir-email/$email';

    try {
      final response = await _dio.put(
        url,
        data: {
          'url_laporan_akhir': urlLaporanAkhir,
        },
      );

      if (response.statusCode == 200) {
        print('URL updated successfully');
      } else {
        throw Exception('Failed to update URL: ${response.data}');
      }
    } catch (e) {
      print('Error updating URL: $e');
      rethrow; // Optionally, rethrow the error for handling at a higher level
    }
  }

  Future<int> countPesertaMagang() async {
    try {
      final response =
          await _dio.get('http://localhost:3000/api/peserta_magang/count');
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
          'http://localhost:3000/api/peserta_magang/count-pengajuan-for-department/$departmentName');
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
          'http://localhost:3000/api/peserta_magang/count-approved-for-department/$departmentName');
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
    final url =
        'http://localhost:3000/api/peserta_magang/update-status/$idMagang';

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
      'http://localhost:3000/api/peserta_magang/update_status-catatan/$idMagang',
      data: payload,
    );

    return res.statusCode == 200;
  }

  // Update Peserta Magang LINK WAWANCARA by ID
  Future<void> updateLinkMeet(String id, String newLink) async {
    try {
      final response = await _dio.put(
        'http://localhost:3000/api/peserta_magang/update-link-meet/$id',
        data: {
          'link_meet_interview': newLink,
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

  Future<String?> fetchPembimbingByEmail(String email) async {
    try {
      final response = await _dio.get(
          'http://localhost:3000/api/peserta_magang/fetch-pembimbing-by-email/$email');
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
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////  DEPARTEMEN   ///////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> updateMaxKuotaDepartemen(String id, int maxKuota) async {
    try {
      final response = await Dio().put(
        'http://localhost:3000/api/departemen/update-max-kuota/$id',
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

  Future<List<DepartemenData>> fetchDepartemen() async {
    try {
      final response = await _dio
          .get('http://localhost:3000/api/departemen/fetch-all-departemen');
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((json) => DepartemenData.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Fetch all department data with count data updated
  Future<List<DepartemenData>> fetchDepartemenDataUpdateCount() async {
    try {
      final response = await _dio.get(
          'http://localhost:3000/api/departemen/fetch-all-departemen-data-updated');

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
        'http://localhost:3000/api/departemen/update-deskripsi-syarat/$departmentName',
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

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ////////////////////////////////////// KUNJUNGAN STUDI /////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Submit kunjungan studi
  Future<Response> submitKunjunganStudi(
      KunjunganStudiData kunjunganStudi) async {
    const String url =
        'http://localhost:3000/api/kunjungan_studi/submit-kunjungan-studi';

    return await Dio().post(
      url,
      data: kunjunganStudi.toJson(),
      options: Options(contentType: 'application/json'),
    );
  }

  // Fetch Kunjungan Studi Data by Email
  Future<List<KunjunganStudiData>> fetchKunjunganDataByEmail(
    String email,
  ) async {
    final response = await _dio.get(
        'http://localhost:3000/api/kunjungan_studi/fetch-kunjungan-data/$email');

    if (response.statusCode == 200) {
      // Assuming that the response is a list of kunjungan studi data
      final List<dynamic> data = response.data;
      return data.map((json) => KunjunganStudiData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Kunjungan Studi data');
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////// LOGBOOK ///////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///  // Method to add a new logbook
  Future<void> addLogbook(LogbookPesertaMagangData logbook) async {
    try {
      final response = await _dio.post(
          'http://localhost:3000/api/logbook/add-logbook',
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
    final url =
        'http://localhost:3000/api/logbook/update-logbook/${logbook.idLogbook}';

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
      final response = await _dio
          .get('http://localhost:3000/api/logbook/fetch-by-email/$email');
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
      final response =
          await _dio.get('http://localhost:3000/api/logbook/count-logbooks');
      if (response.statusCode == 200) {
        return response.data['total']; // Return total count
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
      await _dio.patch(
          'http://localhost:3000/api/logbook/validasi-logbook/$idLogbook',
          data: {
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
      await _dio.patch(
          'http://localhost:3000/api/logbook/catatan-logbook/$idLogbook',
          data: {
            'catatan_pembimbing': catatanPembimbing,
          });
      print('Catatan updated successfully'); // Optional logging
    } on DioException catch (e) {
      print('Error updating catatan: ${e.message}');
      throw Exception('Failed to update catatan');
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////// LOGBOOK ///////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Function to create a new kepala departemen
  Future<void> addKepalaDepartemen(KepalaDepartemenData data) async {
    try {
      final response = await _dio.post(
          'http://localhost:3000/api/kepala_departemen/add-new-kepala-departemen',
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
      final response = await _dio.get(
          'http://localhost:3000/api/kepala_departemen/fetch-all-kepala-departemen');
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
      final response = await _dio.get(
          'http://localhost:3000/api/kepala_departemen/count-jumlah-kepala-departemen');
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
}
