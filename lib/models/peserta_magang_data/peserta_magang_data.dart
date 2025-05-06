import 'package:freezed_annotation/freezed_annotation.dart';

part 'peserta_magang_data.freezed.dart';
part 'peserta_magang_data.g.dart';

@freezed
abstract class PesertaMagangData with _$PesertaMagangData {
  const factory PesertaMagangData({
    @JsonKey(name: 'id_magang') required String idMagang,
    @JsonKey(name: 'nama') required String nama,
    @JsonKey(name: 'departemen') String? departemen,
    @JsonKey(name: 'alamat') required String alamat,
    @JsonKey(name: 'no_telp') required String noTelp,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'asal_universitas') required String asalUniversitas,
    @JsonKey(name: 'angkatan') required int angkatan,
    @JsonKey(name: 'nilai_univ') required double nilaiUniv,
    @JsonKey(name: 'jurusan') required String jurusan,
    @JsonKey(name: 'path_cv') required String pathCv,
    @JsonKey(name: 'path_persetujuan_univ') required String pathPersetujuanUniv,
    @JsonKey(name: 'path_transkrip_nilai') required String pathTranskripNilai,
    @JsonKey(name: 'path_foto_diri') required String pathFotoDiri,
    @JsonKey(name: 'status_magang') required String statusMagang,
    @JsonKey(name: 'password_token') String? passwordToken,
    @JsonKey(name: 'path_surat_penerimaan') String? pathSuratPenerimaan,
    @JsonKey(name: 'link_meet_interview') String? linkMeetInterview,
    @JsonKey(name: 'catatan_hr') String? catatanHr,
    @JsonKey(name: 'nilai_akhir_magang') int? nilaiAkhirMagang,
  }) = _PesertaMagangData;

  factory PesertaMagangData.fromJson(Map<String, dynamic> json) =>
      _$PesertaMagangDataFromJson(json);
}
