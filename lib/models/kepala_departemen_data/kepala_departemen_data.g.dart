// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kepala_departemen_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KepalaDepartemenData _$KepalaDepartemenDataFromJson(
        Map<String, dynamic> json) =>
    _KepalaDepartemenData(
      idKepalaDepartemenData: json['id_kepala_departemen'] as String,
      nama: json['nama'] as String,
      email: json['email'] as String,
      departemen: json['departemen'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$KepalaDepartemenDataToJson(
        _KepalaDepartemenData instance) =>
    <String, dynamic>{
      'id_kepala_departemen': instance.idKepalaDepartemenData,
      'nama': instance.nama,
      'email': instance.email,
      'departemen': instance.departemen,
      'password': instance.password,
      'role': instance.role,
      'status': instance.status,
    };
