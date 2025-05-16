// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logbook_peserta_magang_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LogbookPesertaMagangData _$LogbookPesertaMagangDataFromJson(
        Map<String, dynamic> json) =>
    _LogbookPesertaMagangData(
      idLogbook: json['id_logbook'] as String,
      namaPeserta: json['nama_peserta'] as String,
      departemen: json['departemen'] as String?,
      email: json['email'] as String,
      namaAktivitas: json['nama_aktivitas'] as String,
      tanggalAktivitas: json['tanggal_aktivitas'] as String,
      urlLampiran: json['url_lampiran'] as String,
      validasiPembimbing: json['validasi_pembimbing'] as String?,
      catatanPembimbing: json['catatan_pembimbing'] as String?,
    );

Map<String, dynamic> _$LogbookPesertaMagangDataToJson(
        _LogbookPesertaMagangData instance) =>
    <String, dynamic>{
      'id_logbook': instance.idLogbook,
      'nama_peserta': instance.namaPeserta,
      'departemen': instance.departemen,
      'email': instance.email,
      'nama_aktivitas': instance.namaAktivitas,
      'tanggal_aktivitas': instance.tanggalAktivitas,
      'url_lampiran': instance.urlLampiran,
      'validasi_pembimbing': instance.validasiPembimbing,
      'catatan_pembimbing': instance.catatanPembimbing,
    };
