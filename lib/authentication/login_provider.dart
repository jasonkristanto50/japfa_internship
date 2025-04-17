import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;
  final String? role;

  LoginState(
      {this.isLoading = false,
      this.errorMessage,
      this.isLoggedIn = false,
      this.role});

  // Convenience method for copying state
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
  LoginNotifier() : super(LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    if (email == "admin.com" && password == "123") {
      // Admin login
      state = LoginState(
        isLoading: false,
        isLoggedIn: true,
        role: "admin",
      );
    } else if (email == "user.com" && password == "123") {
      // Normal user login
      state = LoginState(
        isLoading: false,
        isLoggedIn: true,
        role: "user",
      );
    } else {
      // Invalid credentials
      state = LoginState(
        isLoading: false,
        errorMessage: "Invalid credentials",
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
