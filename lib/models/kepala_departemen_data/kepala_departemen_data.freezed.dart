// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kepala_departemen_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KepalaDepartemenData {
  @JsonKey(name: 'id_kepala_departemen')
  String get idKepalaDepartemenData;
  @JsonKey(name: 'nama')
  String get nama;
  @JsonKey(name: 'email')
  String get email;
  @JsonKey(name: 'departemen')
  String get departemen;
  @JsonKey(name: 'password')
  String get password;
  @JsonKey(name: 'role')
  String get role;
  @JsonKey(name: 'status')
  String get status;

  /// Create a copy of KepalaDepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KepalaDepartemenDataCopyWith<KepalaDepartemenData> get copyWith =>
      _$KepalaDepartemenDataCopyWithImpl<KepalaDepartemenData>(
          this as KepalaDepartemenData, _$identity);

  /// Serializes this KepalaDepartemenData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KepalaDepartemenData &&
            (identical(other.idKepalaDepartemenData, idKepalaDepartemenData) ||
                other.idKepalaDepartemenData == idKepalaDepartemenData) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idKepalaDepartemenData, nama,
      email, departemen, password, role, status);

  @override
  String toString() {
    return 'KepalaDepartemenData(idKepalaDepartemenData: $idKepalaDepartemenData, nama: $nama, email: $email, departemen: $departemen, password: $password, role: $role, status: $status)';
  }
}

/// @nodoc
abstract mixin class $KepalaDepartemenDataCopyWith<$Res> {
  factory $KepalaDepartemenDataCopyWith(KepalaDepartemenData value,
          $Res Function(KepalaDepartemenData) _then) =
      _$KepalaDepartemenDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'id_kepala_departemen') String idKepalaDepartemenData,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'departemen') String departemen,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'status') String status});
}

/// @nodoc
class _$KepalaDepartemenDataCopyWithImpl<$Res>
    implements $KepalaDepartemenDataCopyWith<$Res> {
  _$KepalaDepartemenDataCopyWithImpl(this._self, this._then);

  final KepalaDepartemenData _self;
  final $Res Function(KepalaDepartemenData) _then;

  /// Create a copy of KepalaDepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idKepalaDepartemenData = null,
    Object? nama = null,
    Object? email = null,
    Object? departemen = null,
    Object? password = null,
    Object? role = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      idKepalaDepartemenData: null == idKepalaDepartemenData
          ? _self.idKepalaDepartemenData
          : idKepalaDepartemenData // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _self.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: null == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _KepalaDepartemenData implements KepalaDepartemenData {
  const _KepalaDepartemenData(
      {@JsonKey(name: 'id_kepala_departemen')
      required this.idKepalaDepartemenData,
      @JsonKey(name: 'nama') required this.nama,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'departemen') required this.departemen,
      @JsonKey(name: 'password') required this.password,
      @JsonKey(name: 'role') required this.role,
      @JsonKey(name: 'status') required this.status});
  factory _KepalaDepartemenData.fromJson(Map<String, dynamic> json) =>
      _$KepalaDepartemenDataFromJson(json);

  @override
  @JsonKey(name: 'id_kepala_departemen')
  final String idKepalaDepartemenData;
  @override
  @JsonKey(name: 'nama')
  final String nama;
  @override
  @JsonKey(name: 'email')
  final String email;
  @override
  @JsonKey(name: 'departemen')
  final String departemen;
  @override
  @JsonKey(name: 'password')
  final String password;
  @override
  @JsonKey(name: 'role')
  final String role;
  @override
  @JsonKey(name: 'status')
  final String status;

  /// Create a copy of KepalaDepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KepalaDepartemenDataCopyWith<_KepalaDepartemenData> get copyWith =>
      __$KepalaDepartemenDataCopyWithImpl<_KepalaDepartemenData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$KepalaDepartemenDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KepalaDepartemenData &&
            (identical(other.idKepalaDepartemenData, idKepalaDepartemenData) ||
                other.idKepalaDepartemenData == idKepalaDepartemenData) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.departemen, departemen) ||
                other.departemen == departemen) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, idKepalaDepartemenData, nama,
      email, departemen, password, role, status);

  @override
  String toString() {
    return 'KepalaDepartemenData(idKepalaDepartemenData: $idKepalaDepartemenData, nama: $nama, email: $email, departemen: $departemen, password: $password, role: $role, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$KepalaDepartemenDataCopyWith<$Res>
    implements $KepalaDepartemenDataCopyWith<$Res> {
  factory _$KepalaDepartemenDataCopyWith(_KepalaDepartemenData value,
          $Res Function(_KepalaDepartemenData) _then) =
      __$KepalaDepartemenDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id_kepala_departemen') String idKepalaDepartemenData,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'departemen') String departemen,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'status') String status});
}

/// @nodoc
class __$KepalaDepartemenDataCopyWithImpl<$Res>
    implements _$KepalaDepartemenDataCopyWith<$Res> {
  __$KepalaDepartemenDataCopyWithImpl(this._self, this._then);

  final _KepalaDepartemenData _self;
  final $Res Function(_KepalaDepartemenData) _then;

  /// Create a copy of KepalaDepartemenData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idKepalaDepartemenData = null,
    Object? nama = null,
    Object? email = null,
    Object? departemen = null,
    Object? password = null,
    Object? role = null,
    Object? status = null,
  }) {
    return _then(_KepalaDepartemenData(
      idKepalaDepartemenData: null == idKepalaDepartemenData
          ? _self.idKepalaDepartemenData
          : idKepalaDepartemenData // ignore: cast_nullable_to_non_nullable
              as String,
      nama: null == nama
          ? _self.nama
          : nama // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      departemen: null == departemen
          ? _self.departemen
          : departemen // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
