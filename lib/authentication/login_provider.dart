import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;
  final String? role;

  LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isLoggedIn = false,
    this.role,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
    String? role,
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

  Future<void> login(String email, String password) async {
    if (email == 'peserta' && password == '123') {
      state = LoginState(
        isLoading: false,
        isLoggedIn: true,
        role: 'peserta magang',
      );
      return;
    }
    if (email == 'kepala' && password == '123') {
      state = LoginState(
        isLoading: false,
        isLoggedIn: true,
        role: 'kepala departemen',
      );
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: null);

    String url =
        'http://localhost:3000/api/login'; // Update to your login endpoint

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

  Future<void> logout() async {
    state = LoginState(isLoggedIn: false);
  }
}

// Provider for LoginNotifier
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
