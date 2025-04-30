import 'package:dio/dio.dart';
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
}
