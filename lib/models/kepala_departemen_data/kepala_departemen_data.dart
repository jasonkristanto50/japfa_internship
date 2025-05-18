import 'package:freezed_annotation/freezed_annotation.dart';

part 'kepala_departemen_data.freezed.dart';
part 'kepala_departemen_data.g.dart';

@freezed
abstract class KepalaDepartemenData with _$KepalaDepartemenData {
  const factory KepalaDepartemenData({
    @JsonKey(name: 'id_kepala_departemen')
    required String idKepalaDepartemenData,
    @JsonKey(name: 'nama') required String nama,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'departemen') required String departemen,
    @JsonKey(name: 'password') required String password,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'status') required String status,
  }) = _KepalaDepartemenData;

  factory KepalaDepartemenData.fromJson(Map<String, dynamic> json) =>
      _$KepalaDepartemenDataFromJson(json);
}
