// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departemen_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DepartemenData _$DepartemenDataFromJson(Map<String, dynamic> json) =>
    _DepartemenData(
      idDepartemen: json['id_departemen'] as String,
      namaDepartemen: json['nama_departemen'] as String,
      deskripsi: json['deskripsi'] as String?,
      syaratDepartemen: (json['syarat_departemen'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pathImage: json['path_image'] as String,
      maxKuota: (json['max_kuota'] as num?)?.toInt(),
      jumlahPengajuan: (json['jumlah_pengajuan'] as num?)?.toInt(),
      jumlahApproved: (json['jumlah_approved'] as num?)?.toInt(),
      jumlahOnBoarding: (json['jumlah_on_boarding'] as num?)?.toInt(),
      sisaKuota: (json['sisa_kuota'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DepartemenDataToJson(_DepartemenData instance) =>
    <String, dynamic>{
      'id_departemen': instance.idDepartemen,
      'nama_departemen': instance.namaDepartemen,
      'deskripsi': instance.deskripsi,
      'syarat_departemen': instance.syaratDepartemen,
      'path_image': instance.pathImage,
      'max_kuota': instance.maxKuota,
      'jumlah_pengajuan': instance.jumlahPengajuan,
      'jumlah_approved': instance.jumlahApproved,
      'jumlah_on_boarding': instance.jumlahOnBoarding,
      'sisa_kuota': instance.sisaKuota,
    };
