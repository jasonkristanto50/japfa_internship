// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logging_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoggingData {
  @JsonKey(name: 'logdate')
  DateTime get logDate; // Use DateTime for TIMESTAMP
  @JsonKey(name: 'loguser')
  String get logUser;
  @JsonKey(name: 'logtable')
  String get logTable;
  @JsonKey(name: 'logkey')
  String get logKey;
  @JsonKey(name: 'logkeyvalue')
  String get logKeyValue;
  @JsonKey(name: 'logtype')
  String
      get logType; // logtype should be either 'insert', 'update', or 'delete'
  @JsonKey(name: 'logdetail')
  String get logDetail;

  /// Create a copy of LoggingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoggingDataCopyWith<LoggingData> get copyWith =>
      _$LoggingDataCopyWithImpl<LoggingData>(this as LoggingData, _$identity);

  /// Serializes this LoggingData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoggingData &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logUser, logUser) || other.logUser == logUser) &&
            (identical(other.logTable, logTable) ||
                other.logTable == logTable) &&
            (identical(other.logKey, logKey) || other.logKey == logKey) &&
            (identical(other.logKeyValue, logKeyValue) ||
                other.logKeyValue == logKeyValue) &&
            (identical(other.logType, logType) || other.logType == logType) &&
            (identical(other.logDetail, logDetail) ||
                other.logDetail == logDetail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, logDate, logUser, logTable,
      logKey, logKeyValue, logType, logDetail);

  @override
  String toString() {
    return 'LoggingData(logDate: $logDate, logUser: $logUser, logTable: $logTable, logKey: $logKey, logKeyValue: $logKeyValue, logType: $logType, logDetail: $logDetail)';
  }
}

/// @nodoc
abstract mixin class $LoggingDataCopyWith<$Res> {
  factory $LoggingDataCopyWith(
          LoggingData value, $Res Function(LoggingData) _then) =
      _$LoggingDataCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'logdate') DateTime logDate,
      @JsonKey(name: 'loguser') String logUser,
      @JsonKey(name: 'logtable') String logTable,
      @JsonKey(name: 'logkey') String logKey,
      @JsonKey(name: 'logkeyvalue') String logKeyValue,
      @JsonKey(name: 'logtype') String logType,
      @JsonKey(name: 'logdetail') String logDetail});
}

/// @nodoc
class _$LoggingDataCopyWithImpl<$Res> implements $LoggingDataCopyWith<$Res> {
  _$LoggingDataCopyWithImpl(this._self, this._then);

  final LoggingData _self;
  final $Res Function(LoggingData) _then;

  /// Create a copy of LoggingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? logDate = null,
    Object? logUser = null,
    Object? logTable = null,
    Object? logKey = null,
    Object? logKeyValue = null,
    Object? logType = null,
    Object? logDetail = null,
  }) {
    return _then(_self.copyWith(
      logDate: null == logDate
          ? _self.logDate
          : logDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logUser: null == logUser
          ? _self.logUser
          : logUser // ignore: cast_nullable_to_non_nullable
              as String,
      logTable: null == logTable
          ? _self.logTable
          : logTable // ignore: cast_nullable_to_non_nullable
              as String,
      logKey: null == logKey
          ? _self.logKey
          : logKey // ignore: cast_nullable_to_non_nullable
              as String,
      logKeyValue: null == logKeyValue
          ? _self.logKeyValue
          : logKeyValue // ignore: cast_nullable_to_non_nullable
              as String,
      logType: null == logType
          ? _self.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as String,
      logDetail: null == logDetail
          ? _self.logDetail
          : logDetail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LoggingData implements LoggingData {
  const _LoggingData(
      {@JsonKey(name: 'logdate') required this.logDate,
      @JsonKey(name: 'loguser') required this.logUser,
      @JsonKey(name: 'logtable') required this.logTable,
      @JsonKey(name: 'logkey') required this.logKey,
      @JsonKey(name: 'logkeyvalue') required this.logKeyValue,
      @JsonKey(name: 'logtype') required this.logType,
      @JsonKey(name: 'logdetail') required this.logDetail});
  factory _LoggingData.fromJson(Map<String, dynamic> json) =>
      _$LoggingDataFromJson(json);

  @override
  @JsonKey(name: 'logdate')
  final DateTime logDate;
// Use DateTime for TIMESTAMP
  @override
  @JsonKey(name: 'loguser')
  final String logUser;
  @override
  @JsonKey(name: 'logtable')
  final String logTable;
  @override
  @JsonKey(name: 'logkey')
  final String logKey;
  @override
  @JsonKey(name: 'logkeyvalue')
  final String logKeyValue;
  @override
  @JsonKey(name: 'logtype')
  final String logType;
// logtype should be either 'insert', 'update', or 'delete'
  @override
  @JsonKey(name: 'logdetail')
  final String logDetail;

  /// Create a copy of LoggingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoggingDataCopyWith<_LoggingData> get copyWith =>
      __$LoggingDataCopyWithImpl<_LoggingData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LoggingDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoggingData &&
            (identical(other.logDate, logDate) || other.logDate == logDate) &&
            (identical(other.logUser, logUser) || other.logUser == logUser) &&
            (identical(other.logTable, logTable) ||
                other.logTable == logTable) &&
            (identical(other.logKey, logKey) || other.logKey == logKey) &&
            (identical(other.logKeyValue, logKeyValue) ||
                other.logKeyValue == logKeyValue) &&
            (identical(other.logType, logType) || other.logType == logType) &&
            (identical(other.logDetail, logDetail) ||
                other.logDetail == logDetail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, logDate, logUser, logTable,
      logKey, logKeyValue, logType, logDetail);

  @override
  String toString() {
    return 'LoggingData(logDate: $logDate, logUser: $logUser, logTable: $logTable, logKey: $logKey, logKeyValue: $logKeyValue, logType: $logType, logDetail: $logDetail)';
  }
}

/// @nodoc
abstract mixin class _$LoggingDataCopyWith<$Res>
    implements $LoggingDataCopyWith<$Res> {
  factory _$LoggingDataCopyWith(
          _LoggingData value, $Res Function(_LoggingData) _then) =
      __$LoggingDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'logdate') DateTime logDate,
      @JsonKey(name: 'loguser') String logUser,
      @JsonKey(name: 'logtable') String logTable,
      @JsonKey(name: 'logkey') String logKey,
      @JsonKey(name: 'logkeyvalue') String logKeyValue,
      @JsonKey(name: 'logtype') String logType,
      @JsonKey(name: 'logdetail') String logDetail});
}

/// @nodoc
class __$LoggingDataCopyWithImpl<$Res> implements _$LoggingDataCopyWith<$Res> {
  __$LoggingDataCopyWithImpl(this._self, this._then);

  final _LoggingData _self;
  final $Res Function(_LoggingData) _then;

  /// Create a copy of LoggingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? logDate = null,
    Object? logUser = null,
    Object? logTable = null,
    Object? logKey = null,
    Object? logKeyValue = null,
    Object? logType = null,
    Object? logDetail = null,
  }) {
    return _then(_LoggingData(
      logDate: null == logDate
          ? _self.logDate
          : logDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      logUser: null == logUser
          ? _self.logUser
          : logUser // ignore: cast_nullable_to_non_nullable
              as String,
      logTable: null == logTable
          ? _self.logTable
          : logTable // ignore: cast_nullable_to_non_nullable
              as String,
      logKey: null == logKey
          ? _self.logKey
          : logKey // ignore: cast_nullable_to_non_nullable
              as String,
      logKeyValue: null == logKeyValue
          ? _self.logKeyValue
          : logKeyValue // ignore: cast_nullable_to_non_nullable
              as String,
      logType: null == logType
          ? _self.logType
          : logType // ignore: cast_nullable_to_non_nullable
              as String,
      logDetail: null == logDetail
          ? _self.logDetail
          : logDetail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
