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
  @JsonKey(name: 'jumlah_peserta')
  int get jumlahPeserta;
  @JsonKey(name: 'tanggal_kegiatan')
  String get tanggalKegiatan;
  @JsonKey(name: 'jam_kegiatan')
  String get jamKegiatan;
  @JsonKey(name: 'path_persetujuan_instansi')
  String get pathPersetujuanInstansi;
  @JsonKey(name: 'status')
  String get status;
  @JsonKey(name: 'password_token')
  String? get passwordToken;

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
            (identical(other.jumlahPeserta, jumlahPeserta) ||
                other.jumlahPeserta == jumlahPeserta) &&
            (identical(other.tanggalKegiatan, tanggalKegiatan) ||
                other.tanggalKegiatan == tanggalKegiatan) &&
            (identical(other.jamKegiatan, jamKegiatan) ||
                other.jamKegiatan == jamKegiatan) &&
            (identical(
                    other.pathPersetujuanInstansi, pathPersetujuanInstansi) ||
                other.pathPersetujuanInstansi == pathPersetujuanInstansi) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.passwordToken, passwordToken) ||
                other.passwordToken == passwordToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idKunjunganStudi,
      namaPerwakilan,
      noTelp,
      email,
      asalUniversitas,
      jumlahPeserta,
      tanggalKegiatan,
      jamKegiatan,
      pathPersetujuanInstansi,
      status,
      passwordToken);

  @override
  String toString() {
    return 'KunjunganStudiData(idKunjunganStudi: $idKunjunganStudi, namaPerwakilan: $namaPerwakilan, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, jumlahPeserta: $jumlahPeserta, tanggalKegiatan: $tanggalKegiatan, jamKegiatan: $jamKegiatan, pathPersetujuanInstansi: $pathPersetujuanInstansi, status: $status, passwordToken: $passwordToken)';
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
      @JsonKey(name: 'jumlah_peserta') int jumlahPeserta,
      @JsonKey(name: 'tanggal_kegiatan') String tanggalKegiatan,
      @JsonKey(name: 'jam_kegiatan') String jamKegiatan,
      @JsonKey(name: 'path_persetujuan_instansi')
      String pathPersetujuanInstansi,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'password_token') String? passwordToken});
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
    Object? jumlahPeserta = null,
    Object? tanggalKegiatan = null,
    Object? jamKegiatan = null,
    Object? pathPersetujuanInstansi = null,
    Object? status = null,
    Object? passwordToken = freezed,
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
      jumlahPeserta: null == jumlahPeserta
          ? _self.jumlahPeserta
          : jumlahPeserta // ignore: cast_nullable_to_non_nullable
              as int,
      tanggalKegiatan: null == tanggalKegiatan
          ? _self.tanggalKegiatan
          : tanggalKegiatan // ignore: cast_nullable_to_non_nullable
              as String,
      jamKegiatan: null == jamKegiatan
          ? _self.jamKegiatan
          : jamKegiatan // ignore: cast_nullable_to_non_nullable
              as String,
      pathPersetujuanInstansi: null == pathPersetujuanInstansi
          ? _self.pathPersetujuanInstansi
          : pathPersetujuanInstansi // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      passwordToken: freezed == passwordToken
          ? _self.passwordToken
          : passwordToken // ignore: cast_nullable_to_non_nullable
              as String?,
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
      @JsonKey(name: 'jumlah_peserta') required this.jumlahPeserta,
      @JsonKey(name: 'tanggal_kegiatan') required this.tanggalKegiatan,
      @JsonKey(name: 'jam_kegiatan') required this.jamKegiatan,
      @JsonKey(name: 'path_persetujuan_instansi')
      required this.pathPersetujuanInstansi,
      @JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'password_token') this.passwordToken});
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
  @JsonKey(name: 'jumlah_peserta')
  final int jumlahPeserta;
  @override
  @JsonKey(name: 'tanggal_kegiatan')
  final String tanggalKegiatan;
  @override
  @JsonKey(name: 'jam_kegiatan')
  final String jamKegiatan;
  @override
  @JsonKey(name: 'path_persetujuan_instansi')
  final String pathPersetujuanInstansi;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'password_token')
  final String? passwordToken;

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
            (identical(other.jumlahPeserta, jumlahPeserta) ||
                other.jumlahPeserta == jumlahPeserta) &&
            (identical(other.tanggalKegiatan, tanggalKegiatan) ||
                other.tanggalKegiatan == tanggalKegiatan) &&
            (identical(other.jamKegiatan, jamKegiatan) ||
                other.jamKegiatan == jamKegiatan) &&
            (identical(
                    other.pathPersetujuanInstansi, pathPersetujuanInstansi) ||
                other.pathPersetujuanInstansi == pathPersetujuanInstansi) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.passwordToken, passwordToken) ||
                other.passwordToken == passwordToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      idKunjunganStudi,
      namaPerwakilan,
      noTelp,
      email,
      asalUniversitas,
      jumlahPeserta,
      tanggalKegiatan,
      jamKegiatan,
      pathPersetujuanInstansi,
      status,
      passwordToken);

  @override
  String toString() {
    return 'KunjunganStudiData(idKunjunganStudi: $idKunjunganStudi, namaPerwakilan: $namaPerwakilan, noTelp: $noTelp, email: $email, asalUniversitas: $asalUniversitas, jumlahPeserta: $jumlahPeserta, tanggalKegiatan: $tanggalKegiatan, jamKegiatan: $jamKegiatan, pathPersetujuanInstansi: $pathPersetujuanInstansi, status: $status, passwordToken: $passwordToken)';
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
      @JsonKey(name: 'jumlah_peserta') int jumlahPeserta,
      @JsonKey(name: 'tanggal_kegiatan') String tanggalKegiatan,
      @JsonKey(name: 'jam_kegiatan') String jamKegiatan,
      @JsonKey(name: 'path_persetujuan_instansi')
      String pathPersetujuanInstansi,
      @JsonKey(name: 'status') String status,
      @JsonKey(name: 'password_token') String? passwordToken});
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
    Object? jumlahPeserta = null,
    Object? tanggalKegiatan = null,
    Object? jamKegiatan = null,
    Object? pathPersetujuanInstansi = null,
    Object? status = null,
    Object? passwordToken = freezed,
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
      jumlahPeserta: null == jumlahPeserta
          ? _self.jumlahPeserta
          : jumlahPeserta // ignore: cast_nullable_to_non_nullable
              as int,
      tanggalKegiatan: null == tanggalKegiatan
          ? _self.tanggalKegiatan
          : tanggalKegiatan // ignore: cast_nullable_to_non_nullable
              as String,
      jamKegiatan: null == jamKegiatan
          ? _self.jamKegiatan
          : jamKegiatan // ignore: cast_nullable_to_non_nullable
              as String,
      pathPersetujuanInstansi: null == pathPersetujuanInstansi
          ? _self.pathPersetujuanInstansi
          : pathPersetujuanInstansi // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      passwordToken: freezed == passwordToken
          ? _self.passwordToken
          : passwordToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
