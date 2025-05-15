// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laporan_peserta_magang_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LaporanPesertaMagangData {
  @JsonKey(name: 'id_laporan')
  String get idLaporan;
  @JsonKey(name: 'nama_peserta')
  String get namaPeserta;
  @JsonKey(name: 'departemen')
  String? get departemen;
  @JsonKey(name: 'email')
  String get email;
  @JsonKey(name: 'nama_aktivitas')
  String get namaAktivitas;
  @JsonKey(name: 'url_lampiran')
  String get urlLampiran;
  @JsonKey(name: 'validasi_pembimbing')
  String? get validasiPembimbing; // Can be 'accepted', 'rejected' or NULL.
  @JsonKey(name: 'catatan_pembimbing')
  String? get catatanPembimbing;

  /// Create a copy of LaporanPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LaporanPesertaMagangDataCopyWith<LaporanPesertaMagangData> get copyWith =>
      _$LaporanPesertaMagangDataCopyWithImpl<LaporanPesertaMagangData>(
          this as LaporanPesertaMagangData, _$identity);

  /// Serializes this LaporanPesertaMagangData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LaporanPesertaMagangData &&
            (identical(other.idLaporan, idLaporan) ||
                other.idLaporan == idLaporan) &&
            (identical(other.namaPeserta, namaPeserta) ||
                other.namaPeserta == namaPeserta) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.namaAktivitas, namaAktivitas) ||
                other.namaAktivitas == namaAktivitas) &&
            (identical(other.urlLampiran, urlLampiran) ||
                other.urlLampiran == urlLampiran) &&
            (identical(other.validasiPembimbing, validasiPembimbing) ||
                other.validasiPembimbing == validasiPembimbing) &&
            (identical(other.catatanPembimbing, catatanPembimbing) ||
                other.catatanPembimbing == catatanPembimbing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idLaporan,
      namaPeserta,
      departemen,
      email,
      namaAktivitas,
      urlLampiran,
      validasiPembimbing,
      catatanPembimbing);

  @override
  String toString() {
    return 'LaporanPesertaMagangData(idLaporan: $idLaporan, namaPeserta: $namaPeserta, departemen: $departemen, email: $email, namaAktivitas: $namaAktivitas, urlLampiran: $urlLampiran, validasiPembimbing: $validasiPembimbing, catatanPembimbing: $catatanPembimbing)';
  }
}

/// @nodoc
abstract mixin class $LaporanPesertaMagangDataCopyWith<$Res> {
  factory $LaporanPesertaMagangDataCopyWith(LaporanPesertaMagangData value,
          $Res Function(LaporanPesertaMagangData) _then) =
      _$LaporanPesertaMagangDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_laporan') String idLaporan,
      @JsonKey(name: 'nama_peserta') String namaPeserta,
      @JsonKey(name: 'departemen') String? departemen,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'nama_aktivitas') String namaAktivitas,
      @JsonKey(name: 'url_lampiran') String urlLampiran,
      @JsonKey(name: 'validasi_pembimbing') String? validasiPembimbing,
      @JsonKey(name: 'catatan_pembimbing') String? catatanPembimbing});
}

/// @nodoc
class _$LaporanPesertaMagangDataCopyWithImpl<$Res>
    implements $LaporanPesertaMagangDataCopyWith<$Res> {
  _$LaporanPesertaMagangDataCopyWithImpl(this._self, this._then);

  final LaporanPesertaMagangData _self;
  final $Res Function(LaporanPesertaMagangData) _then;

  /// Create a copy of LaporanPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idLaporan = null,
    Object? namaPeserta = null,
    Object? departemen = freezed,
    Object? email = null,
    Object? namaAktivitas = null,
    Object? urlLampiran = null,
    Object? validasiPembimbing = freezed,
    Object? catatanPembimbing = freezed,
  }) {
    return _then(_self.copyWith(
      idLaporan: null == idLaporan
          ? _self.idLaporan
          : idLaporan // ignore: cast_nullable_to_non_nullable
              as String,
      namaPeserta: null == namaPeserta
          ? _self.namaPeserta
          : namaPeserta // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: freezed == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      namaAktivitas: null == namaAktivitas
          ? _self.namaAktivitas
          : namaAktivitas // ignore: cast_nullable_to_non_nullable
              as String,
      urlLampiran: null == urlLampiran
          ? _self.urlLampiran
          : urlLampiran // ignore: cast_nullable_to_non_nullable
              as String,
      validasiPembimbing: freezed == validasiPembimbing
          ? _self.validasiPembimbing
          : validasiPembimbing // ignore: cast_nullable_to_non_nullable
              as String?,
      catatanPembimbing: freezed == catatanPembimbing
          ? _self.catatanPembimbing
          : catatanPembimbing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LaporanPesertaMagangData implements LaporanPesertaMagangData {
  const _LaporanPesertaMagangData(
      {@JsonKey(name: 'id_laporan') required this.idLaporan,
      @JsonKey(name: 'nama_peserta') required this.namaPeserta,
      @JsonKey(name: 'departemen') this.departemen,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'nama_aktivitas') required this.namaAktivitas,
      @JsonKey(name: 'url_lampiran') required this.urlLampiran,
      @JsonKey(name: 'validasi_pembimbing') this.validasiPembimbing,
      @JsonKey(name: 'catatan_pembimbing') this.catatanPembimbing});
  factory _LaporanPesertaMagangData.fromJson(Map<String, dynamic> json) =>
      _$LaporanPesertaMagangDataFromJson(json);

  @override
  @JsonKey(name: 'id_laporan')
  final String idLaporan;
  @override
  @JsonKey(name: 'nama_peserta')
  final String namaPeserta;
  @override
  @JsonKey(name: 'departemen')
  final String? departemen;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'nama_aktivitas')
  final String namaAktivitas;
  @override
  @JsonKey(name: 'url_lampiran')
  final String urlLampiran;
  @override
  @JsonKey(name: 'validasi_pembimbing')
  final String? validasiPembimbing;
// Can be 'accepted', 'rejected' or NULL.
  @override
  @JsonKey(name: 'catatan_pembimbing')
  final String? catatanPembimbing;

  /// Create a copy of LaporanPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LaporanPesertaMagangDataCopyWith<_LaporanPesertaMagangData> get copyWith =>
      __$LaporanPesertaMagangDataCopyWithImpl<_LaporanPesertaMagangData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LaporanPesertaMagangDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LaporanPesertaMagangData &&
            (identical(other.idLaporan, idLaporan) ||
                other.idLaporan == idLaporan) &&
            (identical(other.namaPeserta, namaPeserta) ||
                other.namaPeserta == namaPeserta) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.namaAktivitas, namaAktivitas) ||
                other.namaAktivitas == namaAktivitas) &&
            (identical(other.urlLampiran, urlLampiran) ||
                other.urlLampiran == urlLampiran) &&
            (identical(other.validasiPembimbing, validasiPembimbing) ||
                other.validasiPembimbing == validasiPembimbing) &&
            (identical(other.catatanPembimbing, catatanPembimbing) ||
                other.catatanPembimbing == catatanPembimbing));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idLaporan,
      namaPeserta,
      departemen,
      email,
      namaAktivitas,
      urlLampiran,
      validasiPembimbing,
      catatanPembimbing);

  @override
  String toString() {
    return 'LaporanPesertaMagangData(idLaporan: $idLaporan, namaPeserta: $namaPeserta, departemen: $departemen, email: $email, namaAktivitas: $namaAktivitas, urlLampiran: $urlLampiran, validasiPembimbing: $validasiPembimbing, catatanPembimbing: $catatanPembimbing)';
  }
}

/// @nodoc
abstract mixin class _$LaporanPesertaMagangDataCopyWith<$Res>
    implements $LaporanPesertaMagangDataCopyWith<$Res> {
  factory _$LaporanPesertaMagangDataCopyWith(_LaporanPesertaMagangData value,
          $Res Function(_LaporanPesertaMagangData) _then) =
      __$LaporanPesertaMagangDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_laporan') String idLaporan,
      @JsonKey(name: 'nama_peserta') String namaPeserta,
      @JsonKey(name: 'departemen') String? departemen,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'nama_aktivitas') String namaAktivitas,
      @JsonKey(name: 'url_lampiran') String urlLampiran,
      @JsonKey(name: 'validasi_pembimbing') String? validasiPembimbing,
      @JsonKey(name: 'catatan_pembimbing') String? catatanPembimbing});
}

/// @nodoc
class __$LaporanPesertaMagangDataCopyWithImpl<$Res>
    implements _$LaporanPesertaMagangDataCopyWith<$Res> {
  __$LaporanPesertaMagangDataCopyWithImpl(this._self, this._then);

  final _LaporanPesertaMagangData _self;
  final $Res Function(_LaporanPesertaMagangData) _then;

  /// Create a copy of LaporanPesertaMagangData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idLaporan = null,
    Object? namaPeserta = null,
    Object? departemen = freezed,
    Object? email = null,
    Object? namaAktivitas = null,
    Object? urlLampiran = null,
    Object? validasiPembimbing = freezed,
    Object? catatanPembimbing = freezed,
  }) {
    return _then(_LaporanPesertaMagangData(
      idLaporan: null == idLaporan
          ? _self.idLaporan
          : idLaporan // ignore: cast_nullable_to_non_nullable
              as String,
      namaPeserta: null == namaPeserta
          ? _self.namaPeserta
          : namaPeserta // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: freezed == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String?,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      namaAktivitas: null == namaAktivitas
          ? _self.namaAktivitas
          : namaAktivitas // ignore: cast_nullable_to_non_nullable
              as String,
      urlLampiran: null == urlLampiran
          ? _self.urlLampiran
          : urlLampiran // ignore: cast_nullable_to_non_nullable
              as String,
      validasiPembimbing: freezed == validasiPembimbing
          ? _self.validasiPembimbing
          : validasiPembimbing // ignore: cast_nullable_to_non_nullable
              as String?,
      catatanPembimbing: freezed == catatanPembimbing
          ? _self.catatanPembimbing
          : catatanPembimbing // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
