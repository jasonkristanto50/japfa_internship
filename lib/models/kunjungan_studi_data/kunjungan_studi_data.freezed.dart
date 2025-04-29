// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kunjungan_studi_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KunjunganStudiData {
  String get id_kunjungan_studi;
  String get nama_perwakilan;
  String get no_telp;
  String get email;
  String get asal_universitas;
  int get jumlah_anak;
  String get tanggal_kegiatan;

  /// Create a copy of KunjunganStudiData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KunjunganStudiDataCopyWith<KunjunganStudiData> get copyWith =>
      _$KunjunganStudiDataCopyWithImpl<KunjunganStudiData>(
          this as KunjunganStudiData, _$identity);

  /// Serializes this KunjunganStudiData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KunjunganStudiData &&
            (identical(other.id_kunjungan_studi, id_kunjungan_studi) ||
                other.id_kunjungan_studi == id_kunjungan_studi) &&
            (identical(other.nama_perwakilan, nama_perwakilan) ||
                other.nama_perwakilan == nama_perwakilan) &&
            (identical(other.no_telp, no_telp) || other.no_telp == no_telp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asal_universitas, asal_universitas) ||
                other.asal_universitas == asal_universitas) &&
            (identical(other.jumlah_anak, jumlah_anak) ||
                other.jumlah_anak == jumlah_anak) &&
            (identical(other.tanggal_kegiatan, tanggal_kegiatan) ||
                other.tanggal_kegiatan == tanggal_kegiatan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id_kunjungan_studi,
      nama_perwakilan,
      no_telp,
      email,
      asal_universitas,
      jumlah_anak,
      tanggal_kegiatan);

  @override
  String toString() {
    return 'KunjunganStudiData(id_kunjungan_studi: $id_kunjungan_studi, nama_perwakilan: $nama_perwakilan, no_telp: $no_telp, email: $email, asal_universitas: $asal_universitas, jumlah_anak: $jumlah_anak, tanggal_kegiatan: $tanggal_kegiatan)';
  }
}

/// @nodoc
abstract mixin class $KunjunganStudiDataCopyWith<$Res> {
  factory $KunjunganStudiDataCopyWith(
          KunjunganStudiData value, $Res Function(KunjunganStudiData) _then) =
      _$KunjunganStudiDataCopyWithImpl;
  @useResult
  $Res call(
      {String id_kunjungan_studi,
      String nama_perwakilan,
      String no_telp,
      String email,
      String asal_universitas,
      int jumlah_anak,
      String tanggal_kegiatan});
}

/// @nodoc
class _$KunjunganStudiDataCopyWithImpl<$Res>
    implements $KunjunganStudiDataCopyWith<$Res> {
  _$KunjunganStudiDataCopyWithImpl(this._self, this._then);

  final KunjunganStudiData _self;
  final $Res Function(KunjunganStudiData) _then;

  /// Create a copy of KunjunganStudiData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id_kunjungan_studi = null,
    Object? nama_perwakilan = null,
    Object? no_telp = null,
    Object? email = null,
    Object? asal_universitas = null,
    Object? jumlah_anak = null,
    Object? tanggal_kegiatan = null,
  }) {
    return _then(_self.copyWith(
      id_kunjungan_studi: null == id_kunjungan_studi
          ? _self.id_kunjungan_studi
          : id_kunjungan_studi // ignore: cast_nullable_to_non_nullable
              as String,
      nama_perwakilan: null == nama_perwakilan
          ? _self.nama_perwakilan
          : nama_perwakilan // ignore: cast_nullable_to_non_nullable
              as String,
      no_telp: null == no_telp
          ? _self.no_telp
          : no_telp // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      asal_universitas: null == asal_universitas
          ? _self.asal_universitas
          : asal_universitas // ignore: cast_nullable_to_non_nullable
              as String,
      jumlah_anak: null == jumlah_anak
          ? _self.jumlah_anak
          : jumlah_anak // ignore: cast_nullable_to_non_nullable
              as int,
      tanggal_kegiatan: null == tanggal_kegiatan
          ? _self.tanggal_kegiatan
          : tanggal_kegiatan // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KunjunganStudiData implements KunjunganStudiData {
  const _KunjunganStudiData(
      {required this.id_kunjungan_studi,
      required this.nama_perwakilan,
      required this.no_telp,
      required this.email,
      required this.asal_universitas,
      required this.jumlah_anak,
      required this.tanggal_kegiatan});
  factory _KunjunganStudiData.fromJson(Map<String, dynamic> json) =>
      _$KunjunganStudiDataFromJson(json);

  @override
  final String id_kunjungan_studi;
  @override
  final String nama_perwakilan;
  @override
  final String no_telp;
  @override
  final String email;
  @override
  final String asal_universitas;
  @override
  final int jumlah_anak;
  @override
  final String tanggal_kegiatan;

  /// Create a copy of KunjunganStudiData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KunjunganStudiDataCopyWith<_KunjunganStudiData> get copyWith =>
      __$KunjunganStudiDataCopyWithImpl<_KunjunganStudiData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KunjunganStudiDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KunjunganStudiData &&
            (identical(other.id_kunjungan_studi, id_kunjungan_studi) ||
                other.id_kunjungan_studi == id_kunjungan_studi) &&
            (identical(other.nama_perwakilan, nama_perwakilan) ||
                other.nama_perwakilan == nama_perwakilan) &&
            (identical(other.no_telp, no_telp) || other.no_telp == no_telp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asal_universitas, asal_universitas) ||
                other.asal_universitas == asal_universitas) &&
            (identical(other.jumlah_anak, jumlah_anak) ||
                other.jumlah_anak == jumlah_anak) &&
            (identical(other.tanggal_kegiatan, tanggal_kegiatan) ||
                other.tanggal_kegiatan == tanggal_kegiatan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id_kunjungan_studi,
      nama_perwakilan,
      no_telp,
      email,
      asal_universitas,
      jumlah_anak,
      tanggal_kegiatan);

  @override
  String toString() {
    return 'KunjunganStudiData(id_kunjungan_studi: $id_kunjungan_studi, nama_perwakilan: $nama_perwakilan, no_telp: $no_telp, email: $email, asal_universitas: $asal_universitas, jumlah_anak: $jumlah_anak, tanggal_kegiatan: $tanggal_kegiatan)';
  }
}

/// @nodoc
abstract mixin class _$KunjunganStudiDataCopyWith<$Res>
    implements $KunjunganStudiDataCopyWith<$Res> {
  factory _$KunjunganStudiDataCopyWith(
          _KunjunganStudiData value, $Res Function(_KunjunganStudiData) _then) =
      __$KunjunganStudiDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id_kunjungan_studi,
      String nama_perwakilan,
      String no_telp,
      String email,
      String asal_universitas,
      int jumlah_anak,
      String tanggal_kegiatan});
}

/// @nodoc
class __$KunjunganStudiDataCopyWithImpl<$Res>
    implements _$KunjunganStudiDataCopyWith<$Res> {
  __$KunjunganStudiDataCopyWithImpl(this._self, this._then);

  final _KunjunganStudiData _self;
  final $Res Function(_KunjunganStudiData) _then;

  /// Create a copy of KunjunganStudiData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id_kunjungan_studi = null,
    Object? nama_perwakilan = null,
    Object? no_telp = null,
    Object? email = null,
    Object? asal_universitas = null,
    Object? jumlah_anak = null,
    Object? tanggal_kegiatan = null,
  }) {
    return _then(_KunjunganStudiData(
      id_kunjungan_studi: null == id_kunjungan_studi
          ? _self.id_kunjungan_studi
          : id_kunjungan_studi // ignore: cast_nullable_to_non_nullable
              as String,
      nama_perwakilan: null == nama_perwakilan
          ? _self.nama_perwakilan
          : nama_perwakilan // ignore: cast_nullable_to_non_nullable
              as String,
      no_telp: null == no_telp
          ? _self.no_telp
          : no_telp // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      asal_universitas: null == asal_universitas
          ? _self.asal_universitas
          : asal_universitas // ignore: cast_nullable_to_non_nullable
              as String,
      jumlah_anak: null == jumlah_anak
          ? _self.jumlah_anak
          : jumlah_anak // ignore: cast_nullable_to_non_nullable
              as int,
      tanggal_kegiatan: null == tanggal_kegiatan
          ? _self.tanggal_kegiatan
          : tanggal_kegiatan // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
