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
  @JsonKey(name: 'id_kunjungan_studi')
  String get idKunjunganStudi;
  @JsonKey(name: 'nama_perwakilan')
  String get namaPerwakilan;
  @JsonKey(name: 'no_telp')
  String get noTelp;
  @JsonKey(name: 'email')
  String get email;
  @JsonKey(name: 'asal_universitas')
  String get asalUniversitas;
  @JsonKey(name: 'jumlah_anak')
  int get jumlahAnak;
  @JsonKey(name: 'tanggal_kegiatan')
  String get tanggalKegiatan;

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
            (identical(other.idKunjunganStudi, idKunjunganStudi) ||
                other.idKunjunganStudi == idKunjunganStudi) &&
            (identical(other.namaPerwakilan, namaPerwakilan) ||
                other.namaPerwakilan == namaPerwakilan) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.jumlahAnak, jumlahAnak) ||
                other.jumlahAnak == jumlahAnak) &&
            (identical(other.tanggalKegiatan, tanggalKegiatan) ||
                other.tanggalKegiatan == tanggalKegiatan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idKunjunganStudi, namaPerwakilan,
      noTelp, email, asalUniversitas, jumlahAnak, tanggalKegiatan);

  @override
  String toString() {
    return 'KunjunganStudiData(idKunjunganStudi: $idKunjunganStudi, namaPerwakilan: $namaPerwakilan, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, jumlahAnak: $jumlahAnak, tanggalKegiatan: $tanggalKegiatan)';
  }
}

/// @nodoc
abstract mixin class $KunjunganStudiDataCopyWith<$Res> {
  factory $KunjunganStudiDataCopyWith(
          KunjunganStudiData value, $Res Function(KunjunganStudiData) _then) =
      _$KunjunganStudiDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_kunjungan_studi') String idKunjunganStudi,
      @JsonKey(name: 'nama_perwakilan') String namaPerwakilan,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'jumlah_anak') int jumlahAnak,
      @JsonKey(name: 'tanggal_kegiatan') String tanggalKegiatan});
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
    Object? idKunjunganStudi = null,
    Object? namaPerwakilan = null,
    Object? noTelp = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? jumlahAnak = null,
    Object? tanggalKegiatan = null,
  }) {
    return _then(_self.copyWith(
      idKunjunganStudi: null == idKunjunganStudi
          ? _self.idKunjunganStudi
          : idKunjunganStudi // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerwakilan: null == namaPerwakilan
          ? _self.namaPerwakilan
          : namaPerwakilan // ignore: cast_nullable_to_non_nullable
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
      jumlahAnak: null == jumlahAnak
          ? _self.jumlahAnak
          : jumlahAnak // ignore: cast_nullable_to_non_nullable
              as int,
      tanggalKegiatan: null == tanggalKegiatan
          ? _self.tanggalKegiatan
          : tanggalKegiatan // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KunjunganStudiData implements KunjunganStudiData {
  const _KunjunganStudiData(
      {@JsonKey(name: 'id_kunjungan_studi') required this.idKunjunganStudi,
      @JsonKey(name: 'nama_perwakilan') required this.namaPerwakilan,
      @JsonKey(name: 'no_telp') required this.noTelp,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'asal_universitas') required this.asalUniversitas,
      @JsonKey(name: 'jumlah_anak') required this.jumlahAnak,
      @JsonKey(name: 'tanggal_kegiatan') required this.tanggalKegiatan});
  factory _KunjunganStudiData.fromJson(Map<String, dynamic> json) =>
      _$KunjunganStudiDataFromJson(json);

  @override
  @JsonKey(name: 'id_kunjungan_studi')
  final String idKunjunganStudi;
  @override
  @JsonKey(name: 'nama_perwakilan')
  final String namaPerwakilan;
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
  @JsonKey(name: 'jumlah_anak')
  final int jumlahAnak;
  @override
  @JsonKey(name: 'tanggal_kegiatan')
  final String tanggalKegiatan;

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
            (identical(other.idKunjunganStudi, idKunjunganStudi) ||
                other.idKunjunganStudi == idKunjunganStudi) &&
            (identical(other.namaPerwakilan, namaPerwakilan) ||
                other.namaPerwakilan == namaPerwakilan) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.jumlahAnak, jumlahAnak) ||
                other.jumlahAnak == jumlahAnak) &&
            (identical(other.tanggalKegiatan, tanggalKegiatan) ||
                other.tanggalKegiatan == tanggalKegiatan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idKunjunganStudi, namaPerwakilan,
      noTelp, email, asalUniversitas, jumlahAnak, tanggalKegiatan);

  @override
  String toString() {
    return 'KunjunganStudiData(idKunjunganStudi: $idKunjunganStudi, namaPerwakilan: $namaPerwakilan, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, jumlahAnak: $jumlahAnak, tanggalKegiatan: $tanggalKegiatan)';
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
      {@JsonKey(name: 'id_kunjungan_studi') String idKunjunganStudi,
      @JsonKey(name: 'nama_perwakilan') String namaPerwakilan,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'jumlah_anak') int jumlahAnak,
      @JsonKey(name: 'tanggal_kegiatan') String tanggalKegiatan});
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
    Object? idKunjunganStudi = null,
    Object? namaPerwakilan = null,
    Object? noTelp = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? jumlahAnak = null,
    Object? tanggalKegiatan = null,
  }) {
    return _then(_KunjunganStudiData(
      idKunjunganStudi: null == idKunjunganStudi
          ? _self.idKunjunganStudi
          : idKunjunganStudi // ignore: cast_nullable_to_non_nullable
              as String,
      namaPerwakilan: null == namaPerwakilan
          ? _self.namaPerwakilan
          : namaPerwakilan // ignore: cast_nullable_to_non_nullable
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
      jumlahAnak: null == jumlahAnak
          ? _self.jumlahAnak
          : jumlahAnak // ignore: cast_nullable_to_non_nullable
              as int,
      tanggalKegiatan: null == tanggalKegiatan
          ? _self.tanggalKegiatan
          : tanggalKegiatan // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
