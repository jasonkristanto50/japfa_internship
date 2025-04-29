// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'peserta_magang_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PesertaMagangData {
  @JsonKey(name: 'id_magang')
  String get idMagang;
  @JsonKey(name: 'nama')
  String get nama;
  @JsonKey(name: 'departemen')
  String? get departemen;
  @JsonKey(name: 'alamat')
  String get alamat;
  @JsonKey(name: 'no_telp')
  String get noTelp;
  @JsonKey(name: 'email')
  String get email;
  @JsonKey(name: 'asal_universitas')
  String get asalUniversitas;
  @JsonKey(name: 'angkatan')
  int get angkatan;
  @JsonKey(name: 'nilai_univ')
  double get nilaiUniv;
  @JsonKey(name: 'jurusan')
  String get jurusan;
  @JsonKey(name: 'path_cv')
  String get pathCv;
  @JsonKey(name: 'path_persetujuan_univ')
  String get pathPersetujuanUniv;
  @JsonKey(name: 'path_transkrip_nilai')
  String get pathTranskripNilai;
  @JsonKey(name: 'status_magang')
  String get statusMagang;
  @JsonKey(name: 'nilai_akhir_magang')
  int? get nilaiAkhirMagang;

  /// Create a copy of PesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PesertaMagangDataCopyWith<PesertaMagangData> get copyWith =>
      _$PesertaMagangDataCopyWithImpl<PesertaMagangData>(
          this as PesertaMagangData, _$identity);

  /// Serializes this PesertaMagangData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PesertaMagangData &&
            (identical(other.idMagang, idMagang) ||
                other.idMagang == idMagang) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.alamat, alamat) || other.alamat == alamat) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.angkatan, angkatan) ||
                other.angkatan == angkatan) &&
            (identical(other.nilaiUniv, nilaiUniv) ||
                other.nilaiUniv == nilaiUniv) &&
            (identical(other.jurusan, jurusan) || other.jurusan == jurusan) &&
            (identical(other.pathCv, pathCv) || other.pathCv == pathCv) &&
            (identical(other.pathPersetujuanUniv, pathPersetujuanUniv) ||
                other.pathPersetujuanUniv == pathPersetujuanUniv) &&
            (identical(other.pathTranskripNilai, pathTranskripNilai) ||
                other.pathTranskripNilai == pathTranskripNilai) &&
            (identical(other.statusMagang, statusMagang) ||
                other.statusMagang == statusMagang) &&
            (identical(other.nilaiAkhirMagang, nilaiAkhirMagang) ||
                other.nilaiAkhirMagang == nilaiAkhirMagang));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idMagang,
      nama,
      departemen,
      alamat,
      noTelp,
      email,
      asalUniversitas,
      angkatan,
      nilaiUniv,
      jurusan,
      pathCv,
      pathPersetujuanUniv,
      pathTranskripNilai,
      statusMagang,
      nilaiAkhirMagang);

  @override
  String toString() {
    return 'PesertaMagangData(idMagang: $idMagang, nama: $nama, departemen: $departemen, alamat: $alamat, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, angkatan: $angkatan, nilaiUniv: $nilaiUniv, jurusan: $jurusan, pathCv: $pathCv, pathPersetujuanUniv: $pathPersetujuanUniv, pathTranskripNilai: $pathTranskripNilai, statusMagang: $statusMagang, nilaiAkhirMagang: $nilaiAkhirMagang)';
  }
}

/// @nodoc
abstract mixin class $PesertaMagangDataCopyWith<$Res> {
  factory $PesertaMagangDataCopyWith(
          PesertaMagangData value, $Res Function(PesertaMagangData) _then) =
      _$PesertaMagangDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_magang') String idMagang,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'departemen') String? departemen,
      @JsonKey(name: 'alamat') String alamat,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'angkatan') int angkatan,
      @JsonKey(name: 'nilai_univ') double nilaiUniv,
      @JsonKey(name: 'jurusan') String jurusan,
      @JsonKey(name: 'path_cv') String pathCv,
      @JsonKey(name: 'path_persetujuan_univ') String pathPersetujuanUniv,
      @JsonKey(name: 'path_transkrip_nilai') String pathTranskripNilai,
      @JsonKey(name: 'status_magang') String statusMagang,
      @JsonKey(name: 'nilai_akhir_magang') int? nilaiAkhirMagang});
}

/// @nodoc
class _$PesertaMagangDataCopyWithImpl<$Res>
    implements $PesertaMagangDataCopyWith<$Res> {
  _$PesertaMagangDataCopyWithImpl(this._self, this._then);

  final PesertaMagangData _self;
  final $Res Function(PesertaMagangData) _then;

  /// Create a copy of PesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idMagang = null,
    Object? nama = null,
    Object? departemen = freezed,
    Object? alamat = null,
    Object? noTelp = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? angkatan = null,
    Object? nilaiUniv = null,
    Object? jurusan = null,
    Object? pathCv = null,
    Object? pathPersetujuanUniv = null,
    Object? pathTranskripNilai = null,
    Object? statusMagang = null,
    Object? nilaiAkhirMagang = freezed,
  }) {
    return _then(_self.copyWith(
      idMagang: null == idMagang
          ? _self.idMagang
          : idMagang // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _self.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: freezed == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String?,
      alamat: null == alamat
          ? _self.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String,
      noTelp: null == noTelp
          ? _self.noTelp
          : noTelp // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      asalUniversitas: null == asalUniversitas
          ? _self.asalUniversitas
          : asalUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      angkatan: null == angkatan
          ? _self.angkatan
          : angkatan // ignore: cast_nullable_to_non_nullable
              as int,
      nilaiUniv: null == nilaiUniv
          ? _self.nilaiUniv
          : nilaiUniv // ignore: cast_nullable_to_non_nullable
              as double,
      jurusan: null == jurusan
          ? _self.jurusan
          : jurusan // ignore: cast_nullable_to_non_nullable
              as String,
      pathCv: null == pathCv
          ? _self.pathCv
          : pathCv // ignore: cast_nullable_to_non_nullable
              as String,
      pathPersetujuanUniv: null == pathPersetujuanUniv
          ? _self.pathPersetujuanUniv
          : pathPersetujuanUniv // ignore: cast_nullable_to_non_nullable
              as String,
      pathTranskripNilai: null == pathTranskripNilai
          ? _self.pathTranskripNilai
          : pathTranskripNilai // ignore: cast_nullable_to_non_nullable
              as String,
      statusMagang: null == statusMagang
          ? _self.statusMagang
          : statusMagang // ignore: cast_nullable_to_non_nullable
              as String,
      nilaiAkhirMagang: freezed == nilaiAkhirMagang
          ? _self.nilaiAkhirMagang
          : nilaiAkhirMagang // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PesertaMagangData implements PesertaMagangData {
  const _PesertaMagangData(
      {@JsonKey(name: 'id_magang') required this.idMagang,
      @JsonKey(name: 'nama') required this.nama,
      @JsonKey(name: 'departemen') this.departemen,
      @JsonKey(name: 'alamat') required this.alamat,
      @JsonKey(name: 'no_telp') required this.noTelp,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'asal_universitas') required this.asalUniversitas,
      @JsonKey(name: 'angkatan') required this.angkatan,
      @JsonKey(name: 'nilai_univ') required this.nilaiUniv,
      @JsonKey(name: 'jurusan') required this.jurusan,
      @JsonKey(name: 'path_cv') required this.pathCv,
      @JsonKey(name: 'path_persetujuan_univ') required this.pathPersetujuanUniv,
      @JsonKey(name: 'path_transkrip_nilai') required this.pathTranskripNilai,
      @JsonKey(name: 'status_magang') required this.statusMagang,
      @JsonKey(name: 'nilai_akhir_magang') this.nilaiAkhirMagang});
  factory _PesertaMagangData.fromJson(Map<String, dynamic> json) =>
      _$PesertaMagangDataFromJson(json);

  @override
  @JsonKey(name: 'id_magang')
  final String idMagang;
  @override
  @JsonKey(name: 'nama')
  final String nama;
  @override
  @JsonKey(name: 'departemen')
  final String? departemen;
  @override
  @JsonKey(name: 'alamat')
  final String alamat;
  @override
  @JsonKey(name: 'no_telp')
  final String noTelp;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'asal_universitas')
  final String asalUniversitas;
  @override
  @JsonKey(name: 'angkatan')
  final int angkatan;
  @override
  @JsonKey(name: 'nilai_univ')
  final double nilaiUniv;
  @override
  @JsonKey(name: 'jurusan')
  final String jurusan;
  @override
  @JsonKey(name: 'path_cv')
  final String pathCv;
  @override
  @JsonKey(name: 'path_persetujuan_univ')
  final String pathPersetujuanUniv;
  @override
  @JsonKey(name: 'path_transkrip_nilai')
  final String pathTranskripNilai;
  @override
  @JsonKey(name: 'status_magang')
  final String statusMagang;
  @override
  @JsonKey(name: 'nilai_akhir_magang')
  final int? nilaiAkhirMagang;

  /// Create a copy of PesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PesertaMagangDataCopyWith<_PesertaMagangData> get copyWith =>
      __$PesertaMagangDataCopyWithImpl<_PesertaMagangData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PesertaMagangDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PesertaMagangData &&
            (identical(other.idMagang, idMagang) ||
                other.idMagang == idMagang) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.alamat, alamat) || other.alamat == alamat) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.angkatan, angkatan) ||
                other.angkatan == angkatan) &&
            (identical(other.nilaiUniv, nilaiUniv) ||
                other.nilaiUniv == nilaiUniv) &&
            (identical(other.jurusan, jurusan) || other.jurusan == jurusan) &&
            (identical(other.pathCv, pathCv) || other.pathCv == pathCv) &&
            (identical(other.pathPersetujuanUniv, pathPersetujuanUniv) ||
                other.pathPersetujuanUniv == pathPersetujuanUniv) &&
            (identical(other.pathTranskripNilai, pathTranskripNilai) ||
                other.pathTranskripNilai == pathTranskripNilai) &&
            (identical(other.statusMagang, statusMagang) ||
                other.statusMagang == statusMagang) &&
            (identical(other.nilaiAkhirMagang, nilaiAkhirMagang) ||
                other.nilaiAkhirMagang == nilaiAkhirMagang));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idMagang,
      nama,
      departemen,
      alamat,
      noTelp,
      email,
      asalUniversitas,
      angkatan,
      nilaiUniv,
      jurusan,
      pathCv,
      pathPersetujuanUniv,
      pathTranskripNilai,
      statusMagang,
      nilaiAkhirMagang);

  @override
  String toString() {
    return 'PesertaMagangData(idMagang: $idMagang, nama: $nama, departemen: $departemen, alamat: $alamat, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, angkatan: $angkatan, nilaiUniv: $nilaiUniv, jurusan: $jurusan, pathCv: $pathCv, pathPersetujuanUniv: $pathPersetujuanUniv, pathTranskripNilai: $pathTranskripNilai, statusMagang: $statusMagang, nilaiAkhirMagang: $nilaiAkhirMagang)';
  }
}

/// @nodoc
abstract mixin class _$PesertaMagangDataCopyWith<$Res>
    implements $PesertaMagangDataCopyWith<$Res> {
  factory _$PesertaMagangDataCopyWith(
          _PesertaMagangData value, $Res Function(_PesertaMagangData) _then) =
      __$PesertaMagangDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_magang') String idMagang,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'departemen') String? departemen,
      @JsonKey(name: 'alamat') String alamat,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'angkatan') int angkatan,
      @JsonKey(name: 'nilai_univ') double nilaiUniv,
      @JsonKey(name: 'jurusan') String jurusan,
      @JsonKey(name: 'path_cv') String pathCv,
      @JsonKey(name: 'path_persetujuan_univ') String pathPersetujuanUniv,
      @JsonKey(name: 'path_transkrip_nilai') String pathTranskripNilai,
      @JsonKey(name: 'status_magang') String statusMagang,
      @JsonKey(name: 'nilai_akhir_magang') int? nilaiAkhirMagang});
}

/// @nodoc
class __$PesertaMagangDataCopyWithImpl<$Res>
    implements _$PesertaMagangDataCopyWith<$Res> {
  __$PesertaMagangDataCopyWithImpl(this._self, this._then);

  final _PesertaMagangData _self;
  final $Res Function(_PesertaMagangData) _then;

  /// Create a copy of PesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idMagang = null,
    Object? nama = null,
    Object? departemen = freezed,
    Object? alamat = null,
    Object? noTelp = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? angkatan = null,
    Object? nilaiUniv = null,
    Object? jurusan = null,
    Object? pathCv = null,
    Object? pathPersetujuanUniv = null,
    Object? pathTranskripNilai = null,
    Object? statusMagang = null,
    Object? nilaiAkhirMagang = freezed,
  }) {
    return _then(_PesertaMagangData(
      idMagang: null == idMagang
          ? _self.idMagang
          : idMagang // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _self.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: freezed == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String?,
      alamat: null == alamat
          ? _self.alamat
          : alamat // ignore: cast_nullable_to_non_nullable
              as String,
      noTelp: null == noTelp
          ? _self.noTelp
          : noTelp // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      asalUniversitas: null == asalUniversitas
          ? _self.asalUniversitas
          : asalUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      angkatan: null == angkatan
          ? _self.angkatan
          : angkatan // ignore: cast_nullable_to_non_nullable
              as int,
      nilaiUniv: null == nilaiUniv
          ? _self.nilaiUniv
          : nilaiUniv // ignore: cast_nullable_to_non_nullable
              as double,
      jurusan: null == jurusan
          ? _self.jurusan
          : jurusan // ignore: cast_nullable_to_non_nullable
              as String,
      pathCv: null == pathCv
          ? _self.pathCv
          : pathCv // ignore: cast_nullable_to_non_nullable
              as String,
      pathPersetujuanUniv: null == pathPersetujuanUniv
          ? _self.pathPersetujuanUniv
          : pathPersetujuanUniv // ignore: cast_nullable_to_non_nullable
              as String,
      pathTranskripNilai: null == pathTranskripNilai
          ? _self.pathTranskripNilai
          : pathTranskripNilai // ignore: cast_nullable_to_non_nullable
              as String,
      statusMagang: null == statusMagang
          ? _self.statusMagang
          : statusMagang // ignore: cast_nullable_to_non_nullable
              as String,
      nilaiAkhirMagang: freezed == nilaiAkhirMagang
          ? _self.nilaiAkhirMagang
          : nilaiAkhirMagang // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
