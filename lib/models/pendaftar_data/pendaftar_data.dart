import 'package:freezed_annotation/freezed_annotation.dart';

part 'pendaftar.freezed.dart';
part 'pendaftar.g.dart';

@freezed
sealed class Pendaftar with _$Pendaftar {
  const factory Pendaftar({
    required String idPelamar,
    required String nama,
    required String noTelp,
    required String email,
    required String asalUniversitas,
    required String password,
    required String role,
  }) = _Pendaftar;

  factory Pendaftar.fromJson(Map<String, dynamic> json) =>
      _$PendaftarFromJson(json);
}
