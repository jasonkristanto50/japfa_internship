// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peserta_magang_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PesertaMagangData _$PesertaMagangDataFromJson(Map<String, dynamic> json) =>
    _PesertaMagangData(
      idMagang: json['id_magang'] as String,
      nama: json['nama'] as String,
      departemen: json['departemen'] as String?,
      alamat: json['alamat'] as String,
      noTelp: json['no_telp'] as String,
      email: json['email'] as String,
      asalUniversitas: json['asal_universitas'] as String,
      angkatan: (json['angkatan'] as num).toInt(),
      nilaiUniv: (json['nilai_univ'] as num).toDouble(),
      jurusan: json['jurusan'] as String,
      pathCv: json['path_cv'] as String,
      pathPersetujuanUniv: json['path_persetujuan_univ'] as String,
      pathTranskripNilai: json['path_transkrip_nilai'] as String,
      pathFotoDiri: json['path_foto_diri'] as String,
      statusMagang: json['status_magang'] as String,
      passwordToken: json['password_token'] as String?,
      pathSuratPenerimaan: json['path_surat_penerimaan'] as String?,
      linkMeetInterview: json['link_meet_interview'] as String?,
      catatanHr: json['catatan_hr'] as String?,
      nilaiAkhirMagang: (json['nilai_akhir_magang'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PesertaMagangDataToJson(_PesertaMagangData instance) =>
    <String, dynamic>{
      'id_magang': instance.idMagang,
      'nama': instance.nama,
      'departemen': instance.departemen,
      'alamat': instance.alamat,
      'no_telp': instance.noTelp,
      'email': instance.email,
      'asal_universitas': instance.asalUniversitas,
      'angkatan': instance.angkatan,
      'nilai_univ': instance.nilaiUniv,
      'jurusan': instance.jurusan,
      'path_cv': instance.pathCv,
      'path_persetujuan_univ': instance.pathPersetujuanUniv,
      'path_transkrip_nilai': instance.pathTranskripNilai,
      'path_foto_diri': instance.pathFotoDiri,
      'status_magang': instance.statusMagang,
      'password_token': instance.passwordToken,
      'path_surat_penerimaan': instance.pathSuratPenerimaan,
      'link_meet_interview': instance.linkMeetInterview,
      'catatan_hr': instance.catatanHr,
      'nilai_akhir_magang': instance.nilaiAkhirMagang,
    };
