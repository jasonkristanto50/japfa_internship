import 'package:freezed_annotation/freezed_annotation.dart';

part 'laporan_peserta_magang_data.freezed.dart';
part 'laporan_peserta_magang_data.g.dart';

@freezed
abstract class LaporanPesertaMagangData with _$LaporanPesertaMagangData {
  const factory LaporanPesertaMagangData({
    @JsonKey(name: 'id_laporan') required String idLaporan,
    @JsonKey(name: 'nama_peserta') required String namaPeserta,
    @JsonKey(name: 'departemen') String? departemen,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'nama_aktivitas') required String namaAktivitas,
    @JsonKey(name: 'url_lampiran') required String urlLampiran,
    @JsonKey(name: 'validasi_pembimbing')
    String? validasiPembimbing, // Can be 'accepted', 'rejected' or NULL.
    @JsonKey(name: 'catatan_pembimbing') String? catatanPembimbing,
  }) = _LaporanPesertaMagangData;

  factory LaporanPesertaMagangData.fromJson(Map<String, dynamic> json) =>
      _$LaporanPesertaMagangDataFromJson(json);
}
