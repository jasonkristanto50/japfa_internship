// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kunjungan_studi_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KunjunganStudiData _$KunjunganStudiDataFromJson(Map<String, dynamic> json) =>
    _KunjunganStudiData(
      id_kunjungan_studi: json['id_kunjungan_studi'] as String,
      nama_perwakilan: json['nama_perwakilan'] as String,
      no_telp: json['no_telp'] as String,
      email: json['email'] as String,
      asal_universitas: json['asal_universitas'] as String,
      jumlah_anak: (json['jumlah_anak'] as num).toInt(),
      tanggal_kegiatan: json['tanggal_kegiatan'] as String,
    );

Map<String, dynamic> _$KunjunganStudiDataToJson(_KunjunganStudiData instance) =>
    <String, dynamic>{
      'id_kunjungan_studi': instance.id_kunjungan_studi,
      'nama_perwakilan': instance.nama_perwakilan,
      'no_telp': instance.no_telp,
      'email': instance.email,
      'asal_universitas': instance.asal_universitas,
      'jumlah_anak': instance.jumlah_anak,
      'tanggal_kegiatan': instance.tanggal_kegiatan,
    };
