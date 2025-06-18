import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/function_variable/string_value.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;
  final String? name;
  final String? role;
  final String? email;
  final String? departemen;
  final String? statusAktif;
  final String? statusMagang;
  final String? statusKunjungan;

  LoginState(
      {this.isLoading = false,
      this.errorMessage,
      this.isLoggedIn = false,
      this.name,
      this.role,
      this.email,
      this.departemen,
      this.statusAktif,
      this.statusMagang,
      this.statusKunjungan});

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
    String? role,
    String? email,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      role: role,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final Dio _dio = Dio(); // Create a new Dio instance

  LoginNotifier() : super(LoginState());

  Future<void> loginPassword({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    String url = '$baseUrl/api/login/login-password';

    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email, 'password': password}),
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Role ada 4 jenis : admin, pendaftar, peserta magang, kepala departemen
        if (data['role'] != null) {
          state = LoginState(
            isLoading: false,
            isLoggedIn: true,
            name: data['nama'],
            email: email,
            departemen: data['departemen'],
            role: data['role'],
            statusAktif: data['status_aktif'],
          );
        } else {
          state = state.copyWith(
            isLoading: false,
            errorMessage: "Invalid credentials",
          );
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Login gagal",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Pastikan email & password / token anda benar",
      );
    }
  }

  Future<void> loginToken({
    required String email,
    required String passwordToken,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    String url = '$baseUrl/api/login/login-token';

    try {
      final response = await _dio.post(
        url,
        data: jsonEncode({'email': email, 'password_token': passwordToken}),
        options: Options(contentType: 'application/json'),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status_magang'] == statusMagangBerlangsung) {
          state = LoginState(
            isLoading: false,
            isLoggedIn: true,
            name: data['nama'],
            email: email,
            role: rolePesertaMagangValue,
            departemen: data['departemen'],
            statusMagang: data['status_magang'],
          );
        } else if (data['status_magang'] == statusMagangMenunggu ||
            data['status_magang'] == statusMagangDiterima ||
            data['status_magang'] == statusMagangDitolak) {
          state = LoginState(
            isLoading: false,
            isLoggedIn: true,
            name: data['nama'],
            email: email,
            role: rolePendaftarValue,
            departemen: data['departemen'],
            statusMagang: data['status_magang'],
          );
        }

        // TODO: Check apakah selesai juga dapat akses masuk
        if (data['status'] == statusKunjunganMenunggu ||
            data['status'] == statusKunjunganDiterima ||
            data['status'] == statusKunjunganDitolak ||
            data['status'] == statusKunjunganSelesai) {
          state = LoginState(
              isLoading: false,
              isLoggedIn: true,
              name: data['nama_perwakilan'],
              email: email,
              role: rolePendaftarValue,
              statusKunjungan: data['status']);
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Login gagal",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Pastikan email & password / token anda benar",
      );
    }
  }

  Future<void> logout() async {
    state = LoginState(isLoggedIn: false);
  }
}

// Provider for LoginNotifier
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
