import 'package:freezed_annotation/freezed_annotation.dart';

part 'logbook_peserta_magang_data.freezed.dart';
part 'logbook_peserta_magang_data.g.dart';

@freezed
abstract class LogbookPesertaMagangData with _$LogbookPesertaMagangData {
  const factory LogbookPesertaMagangData({
    @JsonKey(name: 'id_logbook') required String idLogbook,
    @JsonKey(name: 'nama_peserta') required String namaPeserta,
    @JsonKey(name: 'departemen') String? departemen,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'nama_aktivitas') required String namaAktivitas,
    @JsonKey(name: 'tanggal_aktivitas') required String tanggalAktivitas,
    @JsonKey(name: 'url_lampiran') required String urlLampiran,
    @JsonKey(name: 'validasi_pembimbing')
    String? validasiPembimbing, // Can be 'accepted', 'rejected' or NULL.
    @JsonKey(name: 'catatan_pembimbing') String? catatanPembimbing,
  }) = _LogbookPesertaMagangData;

  factory LogbookPesertaMagangData.fromJson(Map<String, dynamic> json) =>
      _$LogbookPesertaMagangDataFromJson(json);
}
