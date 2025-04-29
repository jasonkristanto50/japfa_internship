// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminData {
  String get idAdmin;
  String get nama;
  String get noTelp;
  String get email;
  String get departemen;
  String get password;
  String get role;
  String get status;

  /// Create a copy of AdminData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AdminDataCopyWith<AdminData> get copyWith =>
      _$AdminDataCopyWithImpl<AdminData>(this as AdminData, _$identity);

  /// Serializes this AdminData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AdminData &&
            (identical(other.idAdmin, idAdmin) || other.idAdmin == idAdmin) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
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
  int get hashCode => Object.hash(runtimeType, idAdmin, nama, noTelp, email,
      departemen, password, role, status);

  @override
  String toString() {
    return 'AdminData(idAdmin: $idAdmin, nama: $nama, noTelp: $noTelp, email: $email, departemen: $departemen, password: $password, role: $role, status: $status)';
  }
}

/// @nodoc
abstract mixin class $AdminDataCopyWith<$Res> {
  factory $AdminDataCopyWith(AdminData value, $Res Function(AdminData) _then) =
      _$AdminDataCopyWithImpl;
  @useResult
  $Res call(
      {String idAdmin,
      String nama,
      String noTelp,
      String email,
      String departemen,
      String password,
      String role,
      String status});
}

/// @nodoc
class _$AdminDataCopyWithImpl<$Res> implements $AdminDataCopyWith<$Res> {
  _$AdminDataCopyWithImpl(this._self, this._then);

  final AdminData _self;
  final $Res Function(AdminData) _then;

  /// Create a copy of AdminData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idAdmin = null,
    Object? nama = null,
    Object? noTelp = null,
    Object? email = null,
    Object? departemen = null,
    Object? password = null,
    Object? role = null,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      idAdmin: null == idAdmin
          ? _self.idAdmin
          : idAdmin // ignore: cast_nullable_to_non_nullable
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
class _AdminData implements AdminData {
  const _AdminData(
      {required this.idAdmin,
      required this.nama,
      required this.noTelp,
      required this.email,
      required this.departemen,
      required this.password,
      required this.role,
      required this.status});
  factory _AdminData.fromJson(Map<String, dynamic> json) =>
      _$AdminDataFromJson(json);

  @override
  final String idAdmin;
  @override
  final String nama;
  @override
  final String noTelp;
  @override
  final String email;
  @override
  final String departemen;
  @override
  final String password;
  @override
  final String role;
  @override
  final String status;

  /// Create a copy of AdminData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AdminDataCopyWith<_AdminData> get copyWith =>
      __$AdminDataCopyWithImpl<_AdminData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AdminDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AdminData &&
            (identical(other.idAdmin, idAdmin) || other.idAdmin == idAdmin) &&
            (identical(other.nama, nama) || other.nama == nama) &&
            (identical(other.noTelp, noTelp) || other.noTelp == noTelp) &&
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
  int get hashCode => Object.hash(runtimeType, idAdmin, nama, noTelp, email,
      departemen, password, role, status);

  @override
  String toString() {
    return 'AdminData(idAdmin: $idAdmin, nama: $nama, noTelp: $noTelp, email: $email, departemen: $departemen, password: $password, role: $role, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$AdminDataCopyWith<$Res>
    implements $AdminDataCopyWith<$Res> {
  factory _$AdminDataCopyWith(
          _AdminData value, $Res Function(_AdminData) _then) =
      __$AdminDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String idAdmin,
      String nama,
      String noTelp,
      String email,
      String departemen,
      String password,
      String role,
      String status});
}

/// @nodoc
class __$AdminDataCopyWithImpl<$Res> implements _$AdminDataCopyWith<$Res> {
  __$AdminDataCopyWithImpl(this._self, this._then);

  final _AdminData _self;
  final $Res Function(_AdminData) _then;

  /// Create a copy of AdminData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? idAdmin = null,
    Object? nama = null,
    Object? noTelp = null,
    Object? email = null,
    Object? departemen = null,
    Object? password = null,
    Object? role = null,
    Object? status = null,
  }) {
    return _then(_AdminData(
      idAdmin: null == idAdmin
          ? _self.idAdmin
          : idAdmin // ignore: cast_nullable_to_non_nullable
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
