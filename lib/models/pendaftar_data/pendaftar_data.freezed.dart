// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pendaftar_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PendaftarData {
  @JsonKey(name: 'id_pendaftar')
  String get idPendaftar;
  @JsonKey(name: 'nama')
  String get nama;
  @JsonKey(name: 'no_telp')
  String get noTelp;
  @JsonKey(name: 'email')
  String get email;
  @JsonKey(name: 'asal_universitas')
  String get asalUniversitas;
  @JsonKey(name: 'password')
  String get password;
  @JsonKey(name: 'role')
  String get role;

  /// Create a copy of PendaftarData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PendaftarDataCopyWith<PendaftarData> get copyWith =>
      _$PendaftarDataCopyWithImpl<PendaftarData>(
          this as PendaftarData, _$identity);

  /// Serializes this PendaftarData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PendaftarData &&
            (identical(other.idPendaftar, idPendaftar) ||
                other.idPendaftar == idPendaftar) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idPendaftar, nama, noTelp, email,
      asalUniversitas, password, role);

  @override
  String toString() {
    return 'PendaftarData(idPendaftar: $idPendaftar, nama: $nama, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, password: $password, role: $role)';
  }
}

/// @nodoc
abstract mixin class $PendaftarDataCopyWith<$Res> {
  factory $PendaftarDataCopyWith(
          PendaftarData value, $Res Function(PendaftarData) _then) =
      _$PendaftarDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_pendaftar') String idPendaftar,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'role') String role});
}

/// @nodoc
class _$PendaftarDataCopyWithImpl<$Res>
    implements $PendaftarDataCopyWith<$Res> {
  _$PendaftarDataCopyWithImpl(this._self, this._then);

  final PendaftarData _self;
  final $Res Function(PendaftarData) _then;

  /// Create a copy of PendaftarData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPendaftar = null,
    Object? nama = null,
    Object? noTelp = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? password = null,
    Object? role = null,
  }) {
    return _then(_self.copyWith(
      idPendaftar: null == idPendaftar
          ? _self.idPendaftar
          : idPendaftar // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _self.nama
          : nama // ignore: cast_nullable_to_non_nullable
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
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _PendaftarData implements PendaftarData {
  const _PendaftarData(
      {@JsonKey(name: 'id_pendaftar') required this.idPendaftar,
      @JsonKey(name: 'nama') required this.nama,
      @JsonKey(name: 'no_telp') required this.noTelp,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'asal_universitas') required this.asalUniversitas,
      @JsonKey(name: 'password') required this.password,
      @JsonKey(name: 'role') required this.role});
  factory _PendaftarData.fromJson(Map<String, dynamic> json) =>
      _$PendaftarDataFromJson(json);

  @override
  @JsonKey(name: 'id_pendaftar')
  final String idPendaftar;
  @override
  @JsonKey(name: 'nama')
  final String nama;
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
  @JsonKey(name: 'password')
  final String password;
  @override
  @JsonKey(name: 'role')
  final String role;

  /// Create a copy of PendaftarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PendaftarDataCopyWith<_PendaftarData> get copyWith =>
      __$PendaftarDataCopyWithImpl<_PendaftarData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PendaftarDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PendaftarData &&
            (identical(other.idPendaftar, idPendaftar) ||
                other.idPendaftar == idPendaftar) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.asalUniversitas, asalUniversitas) ||
                other.asalUniversitas == asalUniversitas) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idPendaftar, nama, noTelp, email,
      asalUniversitas, password, role);

  @override
  String toString() {
    return 'PendaftarData(idPendaftar: $idPendaftar, nama: $nama, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, password: $password, role: $role)';
  }
}

/// @nodoc
abstract mixin class _$PendaftarDataCopyWith<$Res>
    implements $PendaftarDataCopyWith<$Res> {
  factory _$PendaftarDataCopyWith(
          _PendaftarData value, $Res Function(_PendaftarData) _then) =
      __$PendaftarDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_pendaftar') String idPendaftar,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'asal_universitas') String asalUniversitas,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'role') String role});
}

/// @nodoc
class __$PendaftarDataCopyWithImpl<$Res>
    implements _$PendaftarDataCopyWith<$Res> {
  __$PendaftarDataCopyWithImpl(this._self, this._then);

  final _PendaftarData _self;
  final $Res Function(_PendaftarData) _then;

  /// Create a copy of PendaftarData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idPendaftar = null,
    Object? nama = null,
    Object? noTelp = null,
    Object? email = null,
    Object? asalUniversitas = null,
    Object? password = null,
    Object? role = null,
  }) {
    return _then(_PendaftarData(
      idPendaftar: null == idPendaftar
          ? _self.idPendaftar
          : idPendaftar // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _self.nama
          : nama // ignore: cast_nullable_to_non_nullable
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
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
