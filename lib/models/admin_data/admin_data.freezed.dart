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
  @JsonKey(name: 'id_admin')
  String get idAdmin;
  @JsonKey(name: 'nama')
  String get nama;
  @JsonKey(name: 'no_telp')
  String get noTelp;
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
      {@JsonKey(name: 'id_admin') String idAdmin,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'departemen') String departemen,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'status') String status});
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
      {@JsonKey(name: 'id_admin') required this.idAdmin,
      @JsonKey(name: 'nama') required this.nama,
      @JsonKey(name: 'no_telp') required this.noTelp,
      @JsonKey(name: 'email') required this.email,
      @JsonKey(name: 'departemen') required this.departemen,
      @JsonKey(name: 'password') required this.password,
      @JsonKey(name: 'role') required this.role,
      @JsonKey(name: 'status') required this.status});
  factory _AdminData.fromJson(Map<String, dynamic> json) =>
      _$AdminDataFromJson(json);

  @override
  @JsonKey(name: 'id_admin')
  final String idAdmin;
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
      {@JsonKey(name: 'id_admin') String idAdmin,
      @JsonKey(name: 'nama') String nama,
      @JsonKey(name: 'no_telp') String noTelp,
      @JsonKey(name: 'email') String email,
      @JsonKey(name: 'departemen') String departemen,
      @JsonKey(name: 'password') String password,
      @JsonKey(name: 'role') String role,
      @JsonKey(name: 'status') String status});
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
