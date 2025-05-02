import 'package:dio/dio.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';

class ApiService {
  final Dio _dio = Dio();

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
}
