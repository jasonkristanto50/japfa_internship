import 'package:freezed_annotation/freezed_annotation.dart';

part 'universitas_data.freezed.dart';
part 'universitas_data.g.dart';

@freezed
abstract class UniversitasData with _$UniversitasData {
  const factory UniversitasData({
    @JsonKey(name: 'nama_universitas') required String namaUniversitas,
    @JsonKey(name: 'akreditasi') required String akreditasi,
  }) = _UniversitasData;

  factory UniversitasData.fromJson(Map<String, dynamic> json) =>
      _$UniversitasDataFromJson(json);
}
