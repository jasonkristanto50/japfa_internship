// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendaftar_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendaftarData _$PendaftarDataFromJson(Map<String, dynamic> json) =>
    _PendaftarData(
      idPendaftar: json['id_pendaftar'] as String,
      nama: json['nama'] as String,
      noTelp: json['no_telp'] as String,
      email: json['email'] as String,
      asalUniversitas: json['asal_universitas'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$PendaftarDataToJson(_PendaftarData instance) =>
    <String, dynamic>{
      'id_pendaftar': instance.idPendaftar,
      'nama': instance.nama,
      'no_telp': instance.noTelp,
      'email': instance.email,
      'asal_universitas': instance.asalUniversitas,
      'password': instance.password,
      'role': instance.role,
    };
