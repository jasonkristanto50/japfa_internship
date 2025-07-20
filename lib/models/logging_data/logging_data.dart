import 'package:freezed_annotation/freezed_annotation.dart';

part 'logging_data.freezed.dart';
part 'logging_data.g.dart';

@freezed
abstract class LoggingData with _$LoggingData {
  const factory LoggingData({
    @JsonKey(name: 'logdate') required DateTime logDate,
    @JsonKey(name: 'loguser') required String logUser,
    @JsonKey(name: 'logtable') required String logTable,
    @JsonKey(name: 'logkey') required String logKey,
    @JsonKey(name: 'logkeyvalue') required String logKeyValue,
    @JsonKey(name: 'logtype')
    required String
        logType, // logtype should be either 'insert', 'update', or 'delete'
    @JsonKey(name: 'logdetail') required String logDetail,
  }) = _LoggingData;

  factory LoggingData.fromJson(Map<String, dynamic> json) =>
      _$LoggingDataFromJson(json);
}
