// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendaftar_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PendaftarData _$PendaftarDataFromJson(Map<String, dynamic> json) =>
    _PendaftarData(
      idPendaftar: json['idPendaftar'] as String,
      nama: json['nama'] as String,
      noTelp: json['noTelp'] as String,
      email: json['email'] as String,
      asalUniversitas: json['asalUniversitas'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$PendaftarDataToJson(_PendaftarData instance) =>
    <String, dynamic>{
      'idPendaftar': instance.idPendaftar,
      'nama': instance.nama,
      'noTelp': instance.noTelp,
      'email': instance.email,
      'asalUniversitas': instance.asalUniversitas,
      'password': instance.password,
      'role': instance.role,
    };
