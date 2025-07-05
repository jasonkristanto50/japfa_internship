// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'universitas_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UniversitasData {
  @JsonKey(name: 'nama_universitas')
  String get namaUniversitas;
  @JsonKey(name: 'akreditasi')
  String get akreditasi;

  /// Create a copy of UniversitasData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UniversitasDataCopyWith<UniversitasData> get copyWith =>
      _$UniversitasDataCopyWithImpl<UniversitasData>(
          this as UniversitasData, _$identity);

  /// Serializes this UniversitasData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UniversitasData &&
            (identical(other.namaUniversitas, namaUniversitas) ||
                other.namaUniversitas == namaUniversitas) &&
            (identical(other.akreditasi, akreditasi) ||
                other.akreditasi == akreditasi));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, namaUniversitas, akreditasi);

  @override
  String toString() {
    return 'UniversitasData(namaUniversitas: $namaUniversitas, akreditasi: $akreditasi)';
  }
}

/// @nodoc
abstract mixin class $UniversitasDataCopyWith<$Res> {
  factory $UniversitasDataCopyWith(
          UniversitasData value, $Res Function(UniversitasData) _then) =
      _$UniversitasDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'nama_universitas') String namaUniversitas,
      @JsonKey(name: 'akreditasi') String akreditasi});
}

/// @nodoc
class _$UniversitasDataCopyWithImpl<$Res>
    implements $UniversitasDataCopyWith<$Res> {
  _$UniversitasDataCopyWithImpl(this._self, this._then);

  final UniversitasData _self;
  final $Res Function(UniversitasData) _then;

  /// Create a copy of UniversitasData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namaUniversitas = null,
    Object? akreditasi = null,
  }) {
    return _then(_self.copyWith(
      namaUniversitas: null == namaUniversitas
          ? _self.namaUniversitas
          : namaUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      akreditasi: null == akreditasi
          ? _self.akreditasi
          : akreditasi // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UniversitasData implements UniversitasData {
  const _UniversitasData(
      {@JsonKey(name: 'nama_universitas') required this.namaUniversitas,
      @JsonKey(name: 'akreditasi') required this.akreditasi});
  factory _UniversitasData.fromJson(Map<String, dynamic> json) =>
      _$UniversitasDataFromJson(json);

  @override
  @JsonKey(name: 'nama_universitas')
  final String namaUniversitas;
  @override
  @JsonKey(name: 'akreditasi')
  final String akreditasi;

  /// Create a copy of UniversitasData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UniversitasDataCopyWith<_UniversitasData> get copyWith =>
      __$UniversitasDataCopyWithImpl<_UniversitasData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UniversitasDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UniversitasData &&
            (identical(other.namaUniversitas, namaUniversitas) ||
                other.namaUniversitas == namaUniversitas) &&
            (identical(other.akreditasi, akreditasi) ||
                other.akreditasi == akreditasi));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, namaUniversitas, akreditasi);

  @override
  String toString() {
    return 'UniversitasData(namaUniversitas: $namaUniversitas, akreditasi: $akreditasi)';
  }
}

/// @nodoc
abstract mixin class _$UniversitasDataCopyWith<$Res>
    implements $UniversitasDataCopyWith<$Res> {
  factory _$UniversitasDataCopyWith(
          _UniversitasData value, $Res Function(_UniversitasData) _then) =
      __$UniversitasDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'nama_universitas') String namaUniversitas,
      @JsonKey(name: 'akreditasi') String akreditasi});
}

/// @nodoc
class __$UniversitasDataCopyWithImpl<$Res>
    implements _$UniversitasDataCopyWith<$Res> {
  __$UniversitasDataCopyWithImpl(this._self, this._then);

  final _UniversitasData _self;
  final $Res Function(_UniversitasData) _then;

  /// Create a copy of UniversitasData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? namaUniversitas = null,
    Object? akreditasi = null,
  }) {
    return _then(_UniversitasData(
      namaUniversitas: null == namaUniversitas
          ? _self.namaUniversitas
          : namaUniversitas // ignore: cast_nullable_to_non_nullable
              as String,
      akreditasi: null == akreditasi
          ? _self.akreditasi
          : akreditasi // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
