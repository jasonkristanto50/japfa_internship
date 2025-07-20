// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logging_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoggingData _$LoggingDataFromJson(Map<String, dynamic> json) => _LoggingData(
      logDate: DateTime.parse(json['logdate'] as String),
      logUser: json['loguser'] as String,
      logTable: json['logtable'] as String,
      logKey: json['logkey'] as String,
      logKeyValue: json['logkeyvalue'] as String,
      logType: json['logtype'] as String,
      logDetail: json['logdetail'] as String,
    );

Map<String, dynamic> _$LoggingDataToJson(_LoggingData instance) =>
    <String, dynamic>{
      'logdate': instance.logDate.toIso8601String(),
      'loguser': instance.logUser,
      'logtable': instance.logTable,
      'logkey': instance.logKey,
      'logkeyvalue': instance.logKeyValue,
      'logtype': instance.logType,
      'logdetail': instance.logDetail,
    };
