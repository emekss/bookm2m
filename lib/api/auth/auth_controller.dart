import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/maintabview/main_tabview.dart';
import 'auth_repo.dart';

class AuthController extends StateNotifier<AsyncValue<String?>> {
  final AuthApi authApi;
  AuthController({required this.authApi}) : super(const AsyncValue.data(null));

  Future<void> login(String id, String pw, BuildContext context) async {
    state = const AsyncValue.loading();
    final result = await authApi.login(id, pw);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (token){
        state = AsyncValue.data(token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainTabview(),
          ),
        );
      } 
    );
  }

  Future<void> logout() async {
    await authApi.logout();
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<String?>>((ref) {
  final authApi = ref.read(authApiProvider);
  return AuthController(authApi: authApi);
});
