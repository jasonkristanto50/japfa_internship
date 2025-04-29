import 'package:freezed_annotation/freezed_annotation.dart';

part 'pendaftar_data.freezed.dart';
part 'pendaftar_data.g.dart';

@freezed
sealed class PendaftarData with _$PendaftarData {
  const factory PendaftarData({
    @JsonKey(name: 'id_pendaftar') required String idPendaftar,
    @JsonKey(name: 'nama') required String nama,
    @JsonKey(name: 'no_telp') required String noTelp,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'asal_universitas') required String asalUniversitas,
    @JsonKey(name: 'password') required String password,
    @JsonKey(name: 'role') required String role,
  }) = _PendaftarData;

  factory PendaftarData.fromJson(Map<String, dynamic> json) =>
      _$PendaftarDataFromJson(json);
}
