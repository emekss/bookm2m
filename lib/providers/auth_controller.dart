import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/token_manager.dart';

final authProvider =
    AsyncNotifierProvider<AuthController, bool>(() => AuthController());

class AuthController extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final tokenManager = await TokenManager.getInstance();
    final token = tokenManager.getToken();

    return token != null && _isTokenValid(token);
  }

  bool _isTokenValid(String token) {
    // Add token validation logic if needed
    return true; 
  }

  Future<void> logout() async {
    final tokenManager = await TokenManager.getInstance();
    await tokenManager.clearToken();
    state = const AsyncData(false);
  }
}
