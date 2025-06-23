// lib/features/auth/controller/auth_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController();
});

class AuthController extends StateNotifier<bool> {
  AuthController() : super(false);

  void login() {
    // Replace with real auth logic
  }

  void signup(String email, String password) {
    print('Signing up with $email and $password');
  }
}
