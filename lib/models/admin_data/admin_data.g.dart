// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminData _$AdminDataFromJson(Map<String, dynamic> json) => _AdminData(
      idAdmin: json['id_admin'] as String,
      nama: json['nama'] as String,
      noTelp: json['no_telp'] as String,
      email: json['email'] as String,
      departemen: json['departemen'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AdminDataToJson(_AdminData instance) =>
    <String, dynamic>{
      'id_admin': instance.idAdmin,
      'nama': instance.nama,
      'no_telp': instance.noTelp,
      'email': instance.email,
      'departemen': instance.departemen,
      'password': instance.password,
      'role': instance.role,
      'status': instance.status,
    };
