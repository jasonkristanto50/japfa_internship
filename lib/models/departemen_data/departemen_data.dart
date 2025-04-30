import 'package:freezed_annotation/freezed_annotation.dart';

part 'departemen_data.freezed.dart';
part 'departemen_data.g.dart';

@freezed
abstract class DepartemenData with _$DepartemenData {
  const factory DepartemenData({
    @JsonKey(name: 'id_departemen') required String idDepartemen,
    @JsonKey(name: 'nama_departemen') required String namaDepartemen,
    @JsonKey(name: 'deskripsi') String? deskripsi,
    @JsonKey(name: 'syarat_departemen') List<String>? syaratDepartemen,
    @JsonKey(name: 'path_image') required String pathImage,
    @JsonKey(name: 'max_kuota') int? maxKuota,
    @JsonKey(name: 'jumlah_pengajuan') int? jumlahPengajuan,
    @JsonKey(name: 'jumlah_approved') int? jumlahApproved,
    @JsonKey(name: 'jumlah_on_boarding') int? jumlahOnBoarding,
    @JsonKey(name: 'sisa_kuota') int? sisaKuota,
  }) = _DepartemenData;

  factory DepartemenData.fromJson(Map<String, dynamic> json) =>
      _$DepartemenDataFromJson(json);
}
