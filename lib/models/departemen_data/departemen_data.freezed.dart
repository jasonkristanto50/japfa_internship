// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'departemen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DepartemenData {
  @JsonKey(name: 'id_departemen')
  String get idDepartemen;
  @JsonKey(name: 'nama_departemen')
  String get namaDepartemen;
  @JsonKey(name: 'deskripsi')
  String? get deskripsi;
  @JsonKey(name: 'syarat_departemen')
  String get syaratDepartemen;
  @JsonKey(name: 'max_kuota')
  int? get maxKuota;
  @JsonKey(name: 'jumlah_pengajuan')
  int? get jumlahPengajuan;
  @JsonKey(name: 'jumlah_approved')
  int? get jumlahApproved;
  @JsonKey(name: 'jumlah_on_boarding')
  int? get jumlahOnBoarding;
  @JsonKey(name: 'sisa_kuota')
  int? get sisaKuota;

  /// Create a copy of DepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DepartemenDataCopyWith<DepartemenData> get copyWith =>
      _$DepartemenDataCopyWithImpl<DepartemenData>(
          this as DepartemenData, _$identity);

  /// Serializes this DepartemenData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DepartemenData &&
            (identical(other.idDepartemen, idDepartemen) ||
                other.idDepartemen == idDepartemen) &&
            (identical(other.namaDepartemen, namaDepartemen) ||
                other.namaDepartemen == namaDepartemen) &&
            (identical(other.deskripsi, deskripsi) ||
                other.deskripsi == deskripsi) &&
            (identical(other.syaratDepartemen, syaratDepartemen) ||
                other.syaratDepartemen == syaratDepartemen) &&
            (identical(other.maxKuota, maxKuota) ||
                other.maxKuota == maxKuota) &&
            (identical(other.jumlahPengajuan, jumlahPengajuan) ||
                other.jumlahPengajuan == jumlahPengajuan) &&
            (identical(other.jumlahApproved, jumlahApproved) ||
                other.jumlahApproved == jumlahApproved) &&
            (identical(other.jumlahOnBoarding, jumlahOnBoarding) ||
                other.jumlahOnBoarding == jumlahOnBoarding) &&
            (identical(other.sisaKuota, sisaKuota) ||
                other.sisaKuota == sisaKuota));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idDepartemen,
      namaDepartemen,
      deskripsi,
      syaratDepartemen,
      maxKuota,
      jumlahPengajuan,
      jumlahApproved,
      jumlahOnBoarding,
      sisaKuota);

  @override
  String toString() {
    return 'DepartemenData(idDepartemen: $idDepartemen, namaDepartemen: $namaDepartemen, deskripsi: $deskripsi, syaratDepartemen: $syaratDepartemen, maxKuota: $maxKuota, jumlahPengajuan: $jumlahPengajuan, jumlahApproved: $jumlahApproved, jumlahOnBoarding: $jumlahOnBoarding, sisaKuota: $sisaKuota)';
  }
}

/// @nodoc
abstract mixin class $DepartemenDataCopyWith<$Res> {
  factory $DepartemenDataCopyWith(
          DepartemenData value, $Res Function(DepartemenData) _then) =
      _$DepartemenDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_departemen') String idDepartemen,
      @JsonKey(name: 'nama_departemen') String namaDepartemen,
      @JsonKey(name: 'deskripsi') String? deskripsi,
      @JsonKey(name: 'syarat_departemen') String syaratDepartemen,
      @JsonKey(name: 'max_kuota') int? maxKuota,
      @JsonKey(name: 'jumlah_pengajuan') int? jumlahPengajuan,
      @JsonKey(name: 'jumlah_approved') int? jumlahApproved,
      @JsonKey(name: 'jumlah_on_boarding') int? jumlahOnBoarding,
      @JsonKey(name: 'sisa_kuota') int? sisaKuota});
}

/// @nodoc
class _$DepartemenDataCopyWithImpl<$Res>
    implements $DepartemenDataCopyWith<$Res> {
  _$DepartemenDataCopyWithImpl(this._self, this._then);

  final DepartemenData _self;
  final $Res Function(DepartemenData) _then;

  /// Create a copy of DepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idDepartemen = null,
    Object? namaDepartemen = null,
    Object? deskripsi = freezed,
    Object? syaratDepartemen = null,
    Object? maxKuota = freezed,
    Object? jumlahPengajuan = freezed,
    Object? jumlahApproved = freezed,
    Object? jumlahOnBoarding = freezed,
    Object? sisaKuota = freezed,
  }) {
    return _then(_self.copyWith(
      idDepartemen: null == idDepartemen
          ? _self.idDepartemen
          : idDepartemen // ignore: cast_nullable_to_non_nullable
              as String,
      namaDepartemen: null == namaDepartemen
          ? _self.namaDepartemen
          : namaDepartemen // ignore: cast_nullable_to_non_nullable
              as String,
      deskripsi: freezed == deskripsi
          ? _self.deskripsi
          : deskripsi // ignore: cast_nullable_to_non_nullable
              as String?,
      syaratDepartemen: null == syaratDepartemen
          ? _self.syaratDepartemen
          : syaratDepartemen // ignore: cast_nullable_to_non_nullable
              as String,
      maxKuota: freezed == maxKuota
          ? _self.maxKuota
          : maxKuota // ignore: cast_nullable_to_non_nullable
              as int?,
      jumlahPengajuan: freezed == jumlahPengajuan
          ? _self.jumlahPengajuan
          : jumlahPengajuan // ignore: cast_nullable_to_non_nullable
              as int?,
      jumlahApproved: freezed == jumlahApproved
          ? _self.jumlahApproved
          : jumlahApproved // ignore: cast_nullable_to_non_nullable
              as int?,
      jumlahOnBoarding: freezed == jumlahOnBoarding
          ? _self.jumlahOnBoarding
          : jumlahOnBoarding // ignore: cast_nullable_to_non_nullable
              as int?,
      sisaKuota: freezed == sisaKuota
          ? _self.sisaKuota
          : sisaKuota // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DepartemenData implements DepartemenData {
  const _DepartemenData(
      {@JsonKey(name: 'id_departemen') required this.idDepartemen,
      @JsonKey(name: 'nama_departemen') required this.namaDepartemen,
      @JsonKey(name: 'deskripsi') this.deskripsi,
      @JsonKey(name: 'syarat_departemen') required this.syaratDepartemen,
      @JsonKey(name: 'max_kuota') this.maxKuota,
      @JsonKey(name: 'jumlah_pengajuan') this.jumlahPengajuan,
      @JsonKey(name: 'jumlah_approved') this.jumlahApproved,
      @JsonKey(name: 'jumlah_on_boarding') this.jumlahOnBoarding,
      @JsonKey(name: 'sisa_kuota') this.sisaKuota});
  factory _DepartemenData.fromJson(Map<String, dynamic> json) =>
      _$DepartemenDataFromJson(json);

  @override
  @JsonKey(name: 'id_departemen')
  final String idDepartemen;
  @override
  @JsonKey(name: 'nama_departemen')
  final String namaDepartemen;
  @override
  @JsonKey(name: 'deskripsi')
  final String? deskripsi;
  @override
  @JsonKey(name: 'syarat_departemen')
  final String syaratDepartemen;
  @override
  @JsonKey(name: 'max_kuota')
  final int? maxKuota;
  @override
  @JsonKey(name: 'jumlah_pengajuan')
  final int? jumlahPengajuan;
  @override
  @JsonKey(name: 'jumlah_approved')
  final int? jumlahApproved;
  @override
  @JsonKey(name: 'jumlah_on_boarding')
  final int? jumlahOnBoarding;
  @override
  @JsonKey(name: 'sisa_kuota')
  final int? sisaKuota;

  /// Create a copy of DepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DepartemenDataCopyWith<_DepartemenData> get copyWith =>
      __$DepartemenDataCopyWithImpl<_DepartemenData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DepartemenDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DepartemenData &&
            (identical(other.idDepartemen, idDepartemen) ||
                other.idDepartemen == idDepartemen) &&
            (identical(other.namaDepartemen, namaDepartemen) ||
                other.namaDepartemen == namaDepartemen) &&
            (identical(other.deskripsi, deskripsi) ||
                other.deskripsi == deskripsi) &&
            (identical(other.syaratDepartemen, syaratDepartemen) ||
                other.syaratDepartemen == syaratDepartemen) &&
            (identical(other.maxKuota, maxKuota) ||
                other.maxKuota == maxKuota) &&
            (identical(other.jumlahPengajuan, jumlahPengajuan) ||
                other.jumlahPengajuan == jumlahPengajuan) &&
            (identical(other.jumlahApproved, jumlahApproved) ||
                other.jumlahApproved == jumlahApproved) &&
            (identical(other.jumlahOnBoarding, jumlahOnBoarding) ||
                other.jumlahOnBoarding == jumlahOnBoarding) &&
            (identical(other.sisaKuota, sisaKuota) ||
                other.sisaKuota == sisaKuota));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idDepartemen,
      namaDepartemen,
      deskripsi,
      syaratDepartemen,
      maxKuota,
      jumlahPengajuan,
      jumlahApproved,
      jumlahOnBoarding,
      sisaKuota);

  @override
  String toString() {
    return 'DepartemenData(idDepartemen: $idDepartemen, namaDepartemen: $namaDepartemen, deskripsi: $deskripsi, syaratDepartemen: $syaratDepartemen, maxKuota: $maxKuota, jumlahPengajuan: $jumlahPengajuan, jumlahApproved: $jumlahApproved, jumlahOnBoarding: $jumlahOnBoarding, sisaKuota: $sisaKuota)';
  }
}

/// @nodoc
abstract mixin class _$DepartemenDataCopyWith<$Res>
    implements $DepartemenDataCopyWith<$Res> {
  factory _$DepartemenDataCopyWith(
          _DepartemenData value, $Res Function(_DepartemenData) _then) =
      __$DepartemenDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_departemen') String idDepartemen,
      @JsonKey(name: 'nama_departemen') String namaDepartemen,
      @JsonKey(name: 'deskripsi') String? deskripsi,
      @JsonKey(name: 'syarat_departemen') String syaratDepartemen,
      @JsonKey(name: 'max_kuota') int? maxKuota,
      @JsonKey(name: 'jumlah_pengajuan') int? jumlahPengajuan,
      @JsonKey(name: 'jumlah_approved') int? jumlahApproved,
      @JsonKey(name: 'jumlah_on_boarding') int? jumlahOnBoarding,
      @JsonKey(name: 'sisa_kuota') int? sisaKuota});
}

/// @nodoc
class __$DepartemenDataCopyWithImpl<$Res>
    implements _$DepartemenDataCopyWith<$Res> {
  __$DepartemenDataCopyWithImpl(this._self, this._then);

  final _DepartemenData _self;
  final $Res Function(_DepartemenData) _then;

  /// Create a copy of DepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idDepartemen = null,
    Object? namaDepartemen = null,
    Object? deskripsi = freezed,
    Object? syaratDepartemen = null,
    Object? maxKuota = freezed,
    Object? jumlahPengajuan = freezed,
    Object? jumlahApproved = freezed,
    Object? jumlahOnBoarding = freezed,
    Object? sisaKuota = freezed,
  }) {
    return _then(_DepartemenData(
      idDepartemen: null == idDepartemen
          ? _self.idDepartemen
          : idDepartemen // ignore: cast_nullable_to_non_nullable
              as String,
      namaDepartemen: null == namaDepartemen
          ? _self.namaDepartemen
          : namaDepartemen // ignore: cast_nullable_to_non_nullable
              as String,
      deskripsi: freezed == deskripsi
          ? _self.deskripsi
          : deskripsi // ignore: cast_nullable_to_non_nullable
              as String?,
      syaratDepartemen: null == syaratDepartemen
          ? _self.syaratDepartemen
          : syaratDepartemen // ignore: cast_nullable_to_non_nullable
              as String,
      maxKuota: freezed == maxKuota
          ? _self.maxKuota
          : maxKuota // ignore: cast_nullable_to_non_nullable
              as int?,
      jumlahPengajuan: freezed == jumlahPengajuan
          ? _self.jumlahPengajuan
          : jumlahPengajuan // ignore: cast_nullable_to_non_nullable
              as int?,
      jumlahApproved: freezed == jumlahApproved
          ? _self.jumlahApproved
          : jumlahApproved // ignore: cast_nullable_to_non_nullable
              as int?,
      jumlahOnBoarding: freezed == jumlahOnBoarding
          ? _self.jumlahOnBoarding
          : jumlahOnBoarding // ignore: cast_nullable_to_non_nullable
              as int?,
      sisaKuota: freezed == sisaKuota
          ? _self.sisaKuota
          : sisaKuota // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
