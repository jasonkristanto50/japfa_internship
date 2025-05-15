// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan_peserta_magang_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LaporanPesertaMagangData _$LaporanPesertaMagangDataFromJson(
        Map<String, dynamic> json) =>
    _LaporanPesertaMagangData(
      idLaporan: json['id_laporan'] as String,
      namaPeserta: json['nama_peserta'] as String,
      departemen: json['departemen'] as String?,
      email: json['email'] as String,
      namaAktivitas: json['nama_aktivitas'] as String,
      urlLampiran: json['url_lampiran'] as String,
      validasiPembimbing: json['validasi_pembimbing'] as String?,
      catatanPembimbing: json['catatan_pembimbing'] as String?,
    );

Map<String, dynamic> _$LaporanPesertaMagangDataToJson(
        _LaporanPesertaMagangData instance) =>
    <String, dynamic>{
      'id_laporan': instance.idLaporan,
      'nama_peserta': instance.namaPeserta,
      'departemen': instance.departemen,
      'email': instance.email,
      'nama_aktivitas': instance.namaAktivitas,
      'url_lampiran': instance.urlLampiran,
      'validasi_pembimbing': instance.validasiPembimbing,
      'catatan_pembimbing': instance.catatanPembimbing,
    };
