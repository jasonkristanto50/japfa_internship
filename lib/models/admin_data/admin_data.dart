import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_data.freezed.dart';
part 'admin_data.g.dart';

@freezed
sealed class AdminData with _$AdminData {
  const factory AdminData({
    required String idAdmin,
    required String nama,
    required String noTelp,
    required String email,
    required String departemen,
    required String password,
    required String role,
    required String status,
  }) = _AdminData;

  factory AdminData.fromJson(Map<String, dynamic> json) =>
      _$AdminDataFromJson(json);
}
