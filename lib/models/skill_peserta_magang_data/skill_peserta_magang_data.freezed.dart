// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_peserta_magang_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkillPesertaMagangData {
  @JsonKey(name: 'id_skill')
  String get idSkill;
  @JsonKey(name: 'nama_peserta')
  String get namaPeserta;
  @JsonKey(name: 'departemen')
  String get departemen;
  @JsonKey(name: 'email')
  String get email;
  @JsonKey(name: 'asal_universitas')
  String get asalUniversitas;
  @JsonKey(name: 'nilai_univ')
  double get nilaiUniv;
  @JsonKey(name: 'akreditasi_universitas')
  String get akreditasiUniversitas;
  @JsonKey(name: 'jurusan')
  String get jurusan;
  @JsonKey(name: 'komunikasi')
  String get komunikasi;
  @JsonKey(name: 'kreativitas')
  String get kreativitas;
  @JsonKey(name: 'tanggung_jawab')
  String get tanggungJawab;
  @JsonKey(name: 'kerja_sama')
  String get kerjaSama;
  @JsonKey(name: 'skill_teknis')
  String get skillTeknis;
  @JsonKey(name: 'total_softskill')
  int get totalSoftskill;
  @JsonKey(name: 'banyak_proyek')
  int get banyakProyek;
  @JsonKey(name: 'list_proyek')
  List<String> get listProyek;
  @JsonKey(name: 'url_lampiran')
  String get urlLampiran;
  @JsonKey(name: 'fuzzy_score')
  double get fuzzyScore;

  /// Create a copy of SkillPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SkillPesertaMagangDataCopyWith<SkillPesertaMagangData> get copyWith =>
      _$SkillPesertaMagangDataCopyWithImpl<SkillPesertaMagangData>(
          this as SkillPesertaMagangData, _$identity);

  /// Serializes this SkillPesertaMagangData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SkillPesertaMagangData &&
            (identical(other.idSkill, idSkill) || other.idSkill == idSkill) &&
            (identical(other.namaPeserta, namaPeserta) ||
                other.namaPeserta == namaPeserta) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.nilaiUniv, nilaiUniv) ||
                other.nilaiUniv == nilaiUniv) &&
            (identical(other.akreditasiUniversitas, akreditasiUniversitas) ||
                other.akreditasiUniversitas == akreditasiUniversitas) &&
            (identical(other.jurusan, jurusan) || other.jurusan == jurusan) &&
            (identical(other.komunikasi, komunikasi) ||
                other.komunikasi == komunikasi) &&
            (identical(other.kreativitas, kreativitas) ||
                other.kreativitas == kreativitas) &&
            (identical(other.tanggungJawab, tanggungJawab) ||
                other.tanggungJawab == tanggungJawab) &&
            (identical(other.kerjaSama, kerjaSama) ||
                other.kerjaSama == kerjaSama) &&
            (identical(other.skillTeknis, skillTeknis) ||
                other.skillTeknis == skillTeknis) &&
            (identical(other.totalSoftskill, totalSoftskill) ||
                other.totalSoftskill == totalSoftskill) &&
            (identical(other.banyakProyek, banyakProyek) ||
                other.banyakProyek == banyakProyek) &&
            const DeepCollectionEquality()
                .equals(other.listProyek, listProyek) &&
            (identical(other.urlLampiran, urlLampiran) ||
                other.urlLampiran == urlLampiran) &&
            (identical(other.fuzzyScore, fuzzyScore) ||
                other.fuzzyScore == fuzzyScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idSkill,
      namaPeserta,
      departemen,
      email,
      asalUniversitas,
      nilaiUniv,
      akreditasiUniversitas,
      jurusan,
      komunikasi,
      kreativitas,
      tanggungJawab,
      kerjaSama,
      skillTeknis,
      totalSoftskill,
      banyakProyek,
      const DeepCollectionEquality().hash(listProyek),
      urlLampiran,
      fuzzyScore);

  @override
  String toString() {
    return 'SkillPesertaMagangData(idSkill: $idSkill, namaPeserta: $namaPeserta, departemen: $departemen, email: $email, asalUniversitas: $asalUniversitas, nilaiUniv: $nilaiUniv, akreditasiUniversitas: $akreditasiUniversitas, jurusan: $jurusan, komunikasi: $komunikasi, kreativitas: $kreativitas, tanggungJawab: $tanggungJawab, kerjaSama: $kerjaSama, skillTeknis: $skillTeknis, totalSoftskill: $totalSoftskill, banyakProyek: $banyakProyek, listProyek: $listProyek, urlLampiran: $urlLampiran, fuzzyScore: $fuzzyScore)';
  }
}

/// @nodoc
abstract mixin class $SkillPesertaMagangDataCopyWith<$Res> {
  factory $SkillPesertaMagangDataCopyWith(SkillPesertaMagangData value,
          $Res Function(SkillPesertaMagangData) _then) =
      _$SkillPesertaMagangDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_skill') String idSkill,
      @JsonKey(name: 'nama_peserta') String namaPeserta,
      @JsonKey(name: 'departemen') String departemen,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'nilai_univ') double nilaiUniv,
      @JsonKey(name: 'akreditasi_universitas') String akreditasiUniversitas,
      @JsonKey(name: 'jurusan') String jurusan,
      @JsonKey(name: 'komunikasi') String komunikasi,
      @JsonKey(name: 'kreativitas') String kreativitas,
      @JsonKey(name: 'tanggung_jawab') String tanggungJawab,
      @JsonKey(name: 'kerja_sama') String kerjaSama,
      @JsonKey(name: 'skill_teknis') String skillTeknis,
      @JsonKey(name: 'total_softskill') int totalSoftskill,
      @JsonKey(name: 'banyak_proyek') int banyakProyek,
      @JsonKey(name: 'list_proyek') List<String> listProyek,
      @JsonKey(name: 'url_lampiran') String urlLampiran,
      @JsonKey(name: 'fuzzy_score') double fuzzyScore});
}

/// @nodoc
class _$SkillPesertaMagangDataCopyWithImpl<$Res>
    implements $SkillPesertaMagangDataCopyWith<$Res> {
  _$SkillPesertaMagangDataCopyWithImpl(this._self, this._then);

  final SkillPesertaMagangData _self;
  final $Res Function(SkillPesertaMagangData) _then;

  /// Create a copy of SkillPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idSkill = null,
    Object? namaPeserta = null,
    Object? departemen = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? nilaiUniv = null,
    Object? akreditasiUniversitas = null,
    Object? jurusan = null,
    Object? komunikasi = null,
    Object? kreativitas = null,
    Object? tanggungJawab = null,
    Object? kerjaSama = null,
    Object? skillTeknis = null,
    Object? totalSoftskill = null,
    Object? banyakProyek = null,
    Object? listProyek = null,
    Object? urlLampiran = null,
    Object? fuzzyScore = null,
  }) {
    return _then(_self.copyWith(
      idSkill: null == idSkill
          ? _self.idSkill
          : idSkill // ignore: cast_nullable_to_non_nullable
              as String,
      namaPeserta: null == namaPeserta
          ? _self.namaPeserta
          : namaPeserta // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: null == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      asalUniversitas: null == asalUniversitas
          ? _self.asalUniversitas
          : asalUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      nilaiUniv: null == nilaiUniv
          ? _self.nilaiUniv
          : nilaiUniv // ignore: cast_nullable_to_non_nullable
              as double,
      akreditasiUniversitas: null == akreditasiUniversitas
          ? _self.akreditasiUniversitas
          : akreditasiUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      jurusan: null == jurusan
          ? _self.jurusan
          : jurusan // ignore: cast_nullable_to_non_nullable
              as String,
      komunikasi: null == komunikasi
          ? _self.komunikasi
          : komunikasi // ignore: cast_nullable_to_non_nullable
              as String,
      kreativitas: null == kreativitas
          ? _self.kreativitas
          : kreativitas // ignore: cast_nullable_to_non_nullable
              as String,
      tanggungJawab: null == tanggungJawab
          ? _self.tanggungJawab
          : tanggungJawab // ignore: cast_nullable_to_non_nullable
              as String,
      kerjaSama: null == kerjaSama
          ? _self.kerjaSama
          : kerjaSama // ignore: cast_nullable_to_non_nullable
              as String,
      skillTeknis: null == skillTeknis
          ? _self.skillTeknis
          : skillTeknis // ignore: cast_nullable_to_non_nullable
              as String,
      totalSoftskill: null == totalSoftskill
          ? _self.totalSoftskill
          : totalSoftskill // ignore: cast_nullable_to_non_nullable
              as int,
      banyakProyek: null == banyakProyek
          ? _self.banyakProyek
          : banyakProyek // ignore: cast_nullable_to_non_nullable
              as int,
      listProyek: null == listProyek
          ? _self.listProyek
          : listProyek // ignore: cast_nullable_to_non_nullable
              as List<String>,
      urlLampiran: null == urlLampiran
          ? _self.urlLampiran
          : urlLampiran // ignore: cast_nullable_to_non_nullable
              as String,
      fuzzyScore: null == fuzzyScore
          ? _self.fuzzyScore
          : fuzzyScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SkillPesertaMagangData implements SkillPesertaMagangData {
  const _SkillPesertaMagangData(
      {@JsonKey(name: 'id_skill') required this.idSkill,
      @JsonKey(name: 'nama_peserta') required this.namaPeserta,
      @JsonKey(name: 'departemen') required this.departemen,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'asal_universitas') required this.asalUniversitas,
      @JsonKey(name: 'nilai_univ') required this.nilaiUniv,
      @JsonKey(name: 'akreditasi_universitas')
      required this.akreditasiUniversitas,
      @JsonKey(name: 'jurusan') required this.jurusan,
      @JsonKey(name: 'komunikasi') required this.komunikasi,
      @JsonKey(name: 'kreativitas') required this.kreativitas,
      @JsonKey(name: 'tanggung_jawab') required this.tanggungJawab,
      @JsonKey(name: 'kerja_sama') required this.kerjaSama,
      @JsonKey(name: 'skill_teknis') required this.skillTeknis,
      @JsonKey(name: 'total_softskill') required this.totalSoftskill,
      @JsonKey(name: 'banyak_proyek') required this.banyakProyek,
      @JsonKey(name: 'list_proyek') required final List<String> listProyek,
      @JsonKey(name: 'url_lampiran') required this.urlLampiran,
      @JsonKey(name: 'fuzzy_score') required this.fuzzyScore})
      : _listProyek = listProyek;
  factory _SkillPesertaMagangData.fromJson(Map<String, dynamic> json) =>
      _$SkillPesertaMagangDataFromJson(json);

  @override
  @JsonKey(name: 'id_skill')
  final String idSkill;
  @override
  @JsonKey(name: 'nama_peserta')
  final String namaPeserta;
  @override
  @JsonKey(name: 'departemen')
  final String departemen;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'asal_universitas')
  final String asalUniversitas;
  @override
  @JsonKey(name: 'nilai_univ')
  final double nilaiUniv;
  @override
  @JsonKey(name: 'akreditasi_universitas')
  final String akreditasiUniversitas;
  @override
  @JsonKey(name: 'jurusan')
  final String jurusan;
  @override
  @JsonKey(name: 'komunikasi')
  final String komunikasi;
  @override
  @JsonKey(name: 'kreativitas')
  final String kreativitas;
  @override
  @JsonKey(name: 'tanggung_jawab')
  final String tanggungJawab;
  @override
  @JsonKey(name: 'kerja_sama')
  final String kerjaSama;
  @override
  @JsonKey(name: 'skill_teknis')
  final String skillTeknis;
  @override
  @JsonKey(name: 'total_softskill')
  final int totalSoftskill;
  @override
  @JsonKey(name: 'banyak_proyek')
  final int banyakProyek;
  final List<String> _listProyek;
  @override
  @JsonKey(name: 'list_proyek')
  List<String> get listProyek {
    if (_listProyek is EqualUnmodifiableListView) return _listProyek;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listProyek);
  }

  @override
  @JsonKey(name: 'url_lampiran')
  final String urlLampiran;
  @override
  @JsonKey(name: 'fuzzy_score')
  final double fuzzyScore;

  /// Create a copy of SkillPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SkillPesertaMagangDataCopyWith<_SkillPesertaMagangData> get copyWith =>
      __$SkillPesertaMagangDataCopyWithImpl<_SkillPesertaMagangData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SkillPesertaMagangDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SkillPesertaMagangData &&
            (identical(other.idSkill, idSkill) || other.idSkill == idSkill) &&
            (identical(other.namaPeserta, namaPeserta) ||
                other.namaPeserta == namaPeserta) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.nilaiUniv, nilaiUniv) ||
                other.nilaiUniv == nilaiUniv) &&
            (identical(other.akreditasiUniversitas, akreditasiUniversitas) ||
                other.akreditasiUniversitas == akreditasiUniversitas) &&
            (identical(other.jurusan, jurusan) || other.jurusan == jurusan) &&
            (identical(other.komunikasi, komunikasi) ||
                other.komunikasi == komunikasi) &&
            (identical(other.kreativitas, kreativitas) ||
                other.kreativitas == kreativitas) &&
            (identical(other.tanggungJawab, tanggungJawab) ||
                other.tanggungJawab == tanggungJawab) &&
            (identical(other.kerjaSama, kerjaSama) ||
                other.kerjaSama == kerjaSama) &&
            (identical(other.skillTeknis, skillTeknis) ||
                other.skillTeknis == skillTeknis) &&
            (identical(other.totalSoftskill, totalSoftskill) ||
                other.totalSoftskill == totalSoftskill) &&
            (identical(other.banyakProyek, banyakProyek) ||
                other.banyakProyek == banyakProyek) &&
            const DeepCollectionEquality()
                .equals(other._listProyek, _listProyek) &&
            (identical(other.urlLampiran, urlLampiran) ||
                other.urlLampiran == urlLampiran) &&
            (identical(other.fuzzyScore, fuzzyScore) ||
                other.fuzzyScore == fuzzyScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idSkill,
      namaPeserta,
      departemen,
      email,
      asalUniversitas,
      nilaiUniv,
      akreditasiUniversitas,
      jurusan,
      komunikasi,
      kreativitas,
      tanggungJawab,
      kerjaSama,
      skillTeknis,
      totalSoftskill,
      banyakProyek,
      const DeepCollectionEquality().hash(_listProyek),
      urlLampiran,
      fuzzyScore);

  @override
  String toString() {
    return 'SkillPesertaMagangData(idSkill: $idSkill, namaPeserta: $namaPeserta, departemen: $departemen, email: $email, asalUniversitas: $asalUniversitas, nilaiUniv: $nilaiUniv, akreditasiUniversitas: $akreditasiUniversitas, jurusan: $jurusan, komunikasi: $komunikasi, kreativitas: $kreativitas, tanggungJawab: $tanggungJawab, kerjaSama: $kerjaSama, skillTeknis: $skillTeknis, totalSoftskill: $totalSoftskill, banyakProyek: $banyakProyek, listProyek: $listProyek, urlLampiran: $urlLampiran, fuzzyScore: $fuzzyScore)';
  }
}

/// @nodoc
abstract mixin class _$SkillPesertaMagangDataCopyWith<$Res>
    implements $SkillPesertaMagangDataCopyWith<$Res> {
  factory _$SkillPesertaMagangDataCopyWith(_SkillPesertaMagangData value,
          $Res Function(_SkillPesertaMagangData) _then) =
      __$SkillPesertaMagangDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_skill') String idSkill,
      @JsonKey(name: 'nama_peserta') String namaPeserta,
      @JsonKey(name: 'departemen') String departemen,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'nilai_univ') double nilaiUniv,
      @JsonKey(name: 'akreditasi_universitas') String akreditasiUniversitas,
      @JsonKey(name: 'jurusan') String jurusan,
      @JsonKey(name: 'komunikasi') String komunikasi,
      @JsonKey(name: 'kreativitas') String kreativitas,
      @JsonKey(name: 'tanggung_jawab') String tanggungJawab,
      @JsonKey(name: 'kerja_sama') String kerjaSama,
      @JsonKey(name: 'skill_teknis') String skillTeknis,
      @JsonKey(name: 'total_softskill') int totalSoftskill,
      @JsonKey(name: 'banyak_proyek') int banyakProyek,
      @JsonKey(name: 'list_proyek') List<String> listProyek,
      @JsonKey(name: 'url_lampiran') String urlLampiran,
      @JsonKey(name: 'fuzzy_score') double fuzzyScore});
}

/// @nodoc
class __$SkillPesertaMagangDataCopyWithImpl<$Res>
    implements _$SkillPesertaMagangDataCopyWith<$Res> {
  __$SkillPesertaMagangDataCopyWithImpl(this._self, this._then);

  final _SkillPesertaMagangData _self;
  final $Res Function(_SkillPesertaMagangData) _then;

  /// Create a copy of SkillPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idSkill = null,
    Object? namaPeserta = null,
    Object? departemen = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? nilaiUniv = null,
    Object? akreditasiUniversitas = null,
    Object? jurusan = null,
    Object? komunikasi = null,
    Object? kreativitas = null,
    Object? tanggungJawab = null,
    Object? kerjaSama = null,
    Object? skillTeknis = null,
    Object? totalSoftskill = null,
    Object? banyakProyek = null,
    Object? listProyek = null,
    Object? urlLampiran = null,
    Object? fuzzyScore = null,
  }) {
    return _then(_SkillPesertaMagangData(
      idSkill: null == idSkill
          ? _self.idSkill
          : idSkill // ignore: cast_nullable_to_non_nullable
              as String,
      namaPeserta: null == namaPeserta
          ? _self.namaPeserta
          : namaPeserta // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: null == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      asalUniversitas: null == asalUniversitas
          ? _self.asalUniversitas
          : asalUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      nilaiUniv: null == nilaiUniv
          ? _self.nilaiUniv
          : nilaiUniv // ignore: cast_nullable_to_non_nullable
              as double,
      akreditasiUniversitas: null == akreditasiUniversitas
          ? _self.akreditasiUniversitas
          : akreditasiUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      jurusan: null == jurusan
          ? _self.jurusan
          : jurusan // ignore: cast_nullable_to_non_nullable
              as String,
      komunikasi: null == komunikasi
          ? _self.komunikasi
          : komunikasi // ignore: cast_nullable_to_non_nullable
              as String,
      kreativitas: null == kreativitas
          ? _self.kreativitas
          : kreativitas // ignore: cast_nullable_to_non_nullable
              as String,
      tanggungJawab: null == tanggungJawab
          ? _self.tanggungJawab
          : tanggungJawab // ignore: cast_nullable_to_non_nullable
              as String,
      kerjaSama: null == kerjaSama
          ? _self.kerjaSama
          : kerjaSama // ignore: cast_nullable_to_non_nullable
              as String,
      skillTeknis: null == skillTeknis
          ? _self.skillTeknis
          : skillTeknis // ignore: cast_nullable_to_non_nullable
              as String,
      totalSoftskill: null == totalSoftskill
          ? _self.totalSoftskill
          : totalSoftskill // ignore: cast_nullable_to_non_nullable
              as int,
      banyakProyek: null == banyakProyek
          ? _self.banyakProyek
          : banyakProyek // ignore: cast_nullable_to_non_nullable
              as int,
      listProyek: null == listProyek
          ? _self._listProyek
          : listProyek // ignore: cast_nullable_to_non_nullable
              as List<String>,
      urlLampiran: null == urlLampiran
          ? _self.urlLampiran
          : urlLampiran // ignore: cast_nullable_to_non_nullable
              as String,
      fuzzyScore: null == fuzzyScore
          ? _self.fuzzyScore
          : fuzzyScore // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
