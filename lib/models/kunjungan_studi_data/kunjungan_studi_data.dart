import 'package:freezed_annotation/freezed_annotation.dart';

part 'kunjungan_studi_data.freezed.dart';
part 'kunjungan_studi_data.g.dart';

@freezed
sealed class KunjunganStudiData with _$KunjunganStudiData {
  const factory KunjunganStudiData({
    required String id_kunjungan_studi,
    required String nama_perwakilan,
    required String no_telp,
    required String email,
    required String asal_universitas,
    required int jumlah_anak,
    required String tanggal_kegiatan,
  }) = _KunjunganStudiData;

  factory KunjunganStudiData.fromJson(Map<String, dynamic> json) =>
      _$KunjunganStudiDataFromJson(json);
}
