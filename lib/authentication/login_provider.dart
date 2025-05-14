import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:japfa_internship/function_variable/variable.dart';

class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;
  final String? name;
  final String? role;
  final String? email;
  final String? statusMagang;

  LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isLoggedIn = false,
    this.name,
    this.role,
    this.email,
    this.statusMagang,
  });

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
    // TODO: buat akun untuk peserta
    if (email == 'peserta' && password == '123') {
      state = LoginState(
        isLoading: false,
        isLoggedIn: true,
        role: 'peserta magang',
        email: email,
      );
      return;
    }
    if (email == 'kepala' && password == '123') {
      state = LoginState(
        isLoading: false,
        isLoggedIn: true,
        role: 'kepala departemen',
        email: email,
      );
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: null);

    String url =
        'http://localhost:3000/api/login/login-password'; // Update to your login endpoint

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
            role: data['role'],
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
          errorMessage: "Login failed. Please try again.",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "An error occurred. Please try again.",
      );
    }
  }

  Future<void> loginToken({
    required String email,
    required String passwordToken,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    String url =
        'http://localhost:3000/api/login/login-token'; // Update to your token login endpoint

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
              statusMagang: data['status_magang']);
        } else if (data['status_magang'] == statusMagangMenunggu) {
          state = LoginState(
              isLoading: false,
              isLoggedIn: true,
              name: data['nama'],
              email: email,
              role: rolePendaftarValue,
              statusMagang: data['status_magang']);
        }
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Login failed. Please try again.",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "An error occurred. Please try again.",
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
