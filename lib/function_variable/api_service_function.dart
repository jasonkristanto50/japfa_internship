import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';

class ApiService {
  final Dio _dio = Dio();

  /////////////////////////////////////////////// UPLOAD FILE ///////////////////////////////////////////

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

  ////////////////////////////////////////////// PESERTA MAGANG  //////////////////////////////////////////////////

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

  /// GET /fetch-peserta-data/:email
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

  //////////////////////////////////////////  DEPARTEMEN   ///////////////////////////////////////////////////////////

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
}
