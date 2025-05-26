import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_peserta_magang_data.freezed.dart';
part 'skill_peserta_magang_data.g.dart';

@freezed
abstract class SkillPesertaMagangData with _$SkillPesertaMagangData {
  const factory SkillPesertaMagangData({
    @JsonKey(name: 'id_skill') required String idSkill,
    @JsonKey(name: 'nama_peserta') required String namaPeserta,
    @JsonKey(name: 'departemen') required String departemen,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'asal_universitas') required String asalUniversitas,
    @JsonKey(name: 'nilai_univ') required double nilaiUniv,
    @JsonKey(name: 'akreditasi_universitas')
    required String akreditasiUniversitas,
    @JsonKey(name: 'jurusan') required String jurusan,
    @JsonKey(name: 'komunikasi') required String komunikasi,
    @JsonKey(name: 'kreativitas') required String kreativitas,
    @JsonKey(name: 'tanggung_jawab') required String tanggungJawab,
    @JsonKey(name: 'kerja_sama') required String kerjaSama,
    @JsonKey(name: 'skill_teknis') required String skillTeknis,
    @JsonKey(name: 'banyak_proyek') required int banyakProyek,
    @JsonKey(name: 'list_proyek') required List<String> listProyek,
    @JsonKey(name: 'url_lampiran') required String urlLampiran,
  }) = _SkillPesertaMagangData;

  factory SkillPesertaMagangData.fromJson(Map<String, dynamic> json) =>
      _$SkillPesertaMagangDataFromJson(json);
}
