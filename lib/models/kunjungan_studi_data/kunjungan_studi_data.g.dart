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
      jumlahPeserta: (json['jumlah_peserta'] as num).toInt(),
      tanggalKegiatan: json['tanggal_kegiatan'] as String,
      jamKegiatan: json['jam_kegiatan'] as String,
      pathPersetujuanInstansi: json['path_persetujuan_instansi'] as String,
      status: json['status'] as String,
      pathFileResponJapfa: json['path_file_respon_japfa'] as String?,
      catatanHr: json['catatan_hr'] as String?,
      passwordToken: json['password_token'] as String?,
    );

Map<String, dynamic> _$KunjunganStudiDataToJson(_KunjunganStudiData instance) =>
    <String, dynamic>{
      'id_kunjungan_studi': instance.idKunjunganStudi,
      'nama_perwakilan': instance.namaPerwakilan,
      'no_telp': instance.noTelp,
      'email': instance.email,
      'asal_universitas': instance.asalUniversitas,
      'jumlah_peserta': instance.jumlahPeserta,
      'tanggal_kegiatan': instance.tanggalKegiatan,
      'jam_kegiatan': instance.jamKegiatan,
      'path_persetujuan_instansi': instance.pathPersetujuanInstansi,
      'status': instance.status,
      'path_file_respon_japfa': instance.pathFileResponJapfa,
      'catatan_hr': instance.catatanHr,
      'password_token': instance.passwordToken,
    };
