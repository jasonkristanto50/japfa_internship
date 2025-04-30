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
