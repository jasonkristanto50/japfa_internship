import 'package:freezed_annotation/freezed_annotation.dart';

part 'kunjungan_studi_data.freezed.dart';
part 'kunjungan_studi_data.g.dart';

@freezed
abstract class KunjunganStudiData with _$KunjunganStudiData {
  const factory KunjunganStudiData({
    @JsonKey(name: 'id_kunjungan_studi') required String idKunjunganStudi,
    @JsonKey(name: 'nama_perwakilan') required String namaPerwakilan,
    @JsonKey(name: 'no_telp') required String noTelp,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'asal_universitas') required String asalUniversitas,
    @JsonKey(name: 'jumlah_anak') required int jumlahAnak,
    @JsonKey(name: 'tanggal_kegiatan') required String tanggalKegiatan,
  }) = _KunjunganStudiData;

  factory KunjunganStudiData.fromJson(Map<String, dynamic> json) =>
      _$KunjunganStudiDataFromJson(json);
}
