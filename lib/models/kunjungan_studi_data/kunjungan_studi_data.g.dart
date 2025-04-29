// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kunjungan_studi_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KunjunganStudiData _$KunjunganStudiDataFromJson(Map<String, dynamic> json) =>
    _KunjunganStudiData(
      idKunjunganStudi: json['id_kunjungan_studi'] as String,
      namaPerwakilan: json['nama_perwakilan'] as String,
      noTelp: json['no_telp'] as String,
      email: json['email'] as String,
      asalUniversitas: json['asal_universitas'] as String,
      jumlahAnak: (json['jumlah_anak'] as num).toInt(),
      tanggalKegiatan: json['tanggal_kegiatan'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$KunjunganStudiDataToJson(_KunjunganStudiData instance) =>
    <String, dynamic>{
      'id_kunjungan_studi': instance.idKunjunganStudi,
      'nama_perwakilan': instance.namaPerwakilan,
      'no_telp': instance.noTelp,
      'email': instance.email,
      'asal_universitas': instance.asalUniversitas,
      'jumlah_anak': instance.jumlahAnak,
      'tanggal_kegiatan': instance.tanggalKegiatan,
      'status': instance.status,
    };
