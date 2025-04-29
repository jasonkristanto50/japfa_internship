import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_data.freezed.dart';
part 'admin_data.g.dart';

@freezed
abstract class AdminData with _$AdminData {
  const factory AdminData({
    @JsonKey(name: 'id_admin') required String idAdmin,
    @JsonKey(name: 'nama') required String nama,
    @JsonKey(name: 'no_telp') required String noTelp,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'departemen') required String departemen,
    @JsonKey(name: 'password') required String password,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'status') required String status,
  }) = _AdminData;

  factory AdminData.fromJson(Map<String, dynamic> json) =>
      _$AdminDataFromJson(json);
}
