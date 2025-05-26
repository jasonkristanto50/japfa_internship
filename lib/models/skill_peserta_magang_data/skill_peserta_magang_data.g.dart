// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_peserta_magang_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkillPesertaMagangData _$SkillPesertaMagangDataFromJson(
        Map<String, dynamic> json) =>
    _SkillPesertaMagangData(
      idSkill: json['id_skill'] as String,
      namaPeserta: json['nama_peserta'] as String,
      departemen: json['departemen'] as String,
      email: json['email'] as String,
      asalUniversitas: json['asal_universitas'] as String,
      nilaiUniv: (json['nilai_univ'] as num).toDouble(),
      akreditasiUniversitas: json['akreditasi_universitas'] as String,
      jurusan: json['jurusan'] as String,
      komunikasi: json['komunikasi'] as String,
      kreativitas: json['kreativitas'] as String,
      tanggungJawab: json['tanggung_jawab'] as String,
      kerjaSama: json['kerja_sama'] as String,
      skillTeknis: json['skill_teknis'] as String,
      totalSoftskill: (json['total_softskill'] as num).toInt(),
      banyakProyek: (json['banyak_proyek'] as num).toInt(),
      listProyek: (json['list_proyek'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      urlLampiran: json['url_lampiran'] as String,
      fuzzyScore: (json['fuzzy_score'] as num).toDouble(),
    );

Map<String, dynamic> _$SkillPesertaMagangDataToJson(
        _SkillPesertaMagangData instance) =>
    <String, dynamic>{
      'id_skill': instance.idSkill,
      'nama_peserta': instance.namaPeserta,
      'departemen': instance.departemen,
      'email': instance.email,
      'asal_universitas': instance.asalUniversitas,
      'nilai_univ': instance.nilaiUniv,
      'akreditasi_universitas': instance.akreditasiUniversitas,
      'jurusan': instance.jurusan,
      'komunikasi': instance.komunikasi,
      'kreativitas': instance.kreativitas,
      'tanggung_jawab': instance.tanggungJawab,
      'kerja_sama': instance.kerjaSama,
      'skill_teknis': instance.skillTeknis,
      'total_softskill': instance.totalSoftskill,
      'banyak_proyek': instance.banyakProyek,
      'list_proyek': instance.listProyek,
      'url_lampiran': instance.urlLampiran,
      'fuzzy_score': instance.fuzzyScore,
    };
