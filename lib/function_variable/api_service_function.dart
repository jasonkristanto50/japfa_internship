import 'package:dio/dio.dart';
import 'package:japfa_internship/models/departemen_data/departemen_data.dart';
import 'package:japfa_internship/models/peserta_magang_data/peserta_magang_data.dart';

class ApiService {
  final Dio _dio = Dio();

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
