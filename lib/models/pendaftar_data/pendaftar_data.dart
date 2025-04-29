import 'package:freezed_annotation/freezed_annotation.dart';

part 'pendaftar_data.freezed.dart';
part 'pendaftar_data.g.dart';

@freezed
sealed class PendaftarData with _$PendaftarData {
  const factory PendaftarData({
    required String idPelamar,
    required String nama,
    required String noTelp,
    required String email,
    required String asalUniversitas,
    required String password,
    required String role,
  }) = _PendaftarData;

  factory PendaftarData.fromJson(Map<String, dynamic> json) =>
      _$PendaftarDataFromJson(json);
}
