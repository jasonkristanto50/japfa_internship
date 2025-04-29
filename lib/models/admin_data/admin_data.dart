import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin.freezed.dart';
part 'admin.g.dart';

@freezed
sealed class Admin with _$Admin {
  const factory Admin({
    required String idAdmin,
    required String nama,
    required String noTelp,
    required String email,
    required String departemen,
    required String password,
    required String role,
    required String status,
  }) = _Admin;

  factory Admin.fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);
}
