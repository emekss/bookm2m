import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../screens/auth/verification_screen.dart';
import '../../screens/auth/verification_success_screen.dart';
import '../../screens/maintabview/main_tabview.dart';
import 'auth_repo.dart';

class AuthController extends StateNotifier<AsyncValue<String?>> {
  final AuthApi authApi;
  AuthController({required this.authApi}) : super(const AsyncValue.data(null));

  Future<void> login(String id, String pw, BuildContext context) async {
    state = const AsyncValue.loading();
    final result = await authApi.login(id, pw);

    result.fold((failure) {
      state = AsyncValue.error(failure.message, StackTrace.current);
    }, (token) {
      state = AsyncValue.data(token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainTabview(),
        ),
      );
    });
  }

  void signup({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final res = await authApi.signup(firstName, lastName, email, password);
    res.fold(
      (l) {
        state = AsyncValue.error(l.message, StackTrace.current);
        SnackBar(
          content: Text(l.message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
        // Navigator.pop(context);
      },
      (r) async {
        state = AsyncValue.data(r.data['message']);
        // Show success message
        //successSnackBar(context, r.data['message'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(r.data['message']),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: email,
              verificationType: VerificationType.registration,
            ),
          ),
        );
      },
    );
  }

  void verifyEmail({
    required BuildContext context,
    required String email,
    required String otp,
  }) async {
    state = const AsyncValue.loading();
    final res = await authApi.verifyEmail(email, otp);
    res.fold(
      (l) {
        state = AsyncValue.error(l.message, StackTrace.current);
        SnackBar(
          content: Text(l.message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
        // Navigator.pop(context);
      },
      (r) async {
        state = AsyncValue.data(r.data['message']);
        // Show success message
        //successSnackBar(context, r.data['message'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(r.data['message']),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerificationSuccessScreen(),
          ),
        );
      },
    );
  }

  void resendOtp({
    required BuildContext context,
    required String email,
    required VoidCallback onSuccess,
  }) async {
    state = const AsyncValue.loading();
    final res = await authApi.resendOtp(email);
    res.fold(
      (l) {
        state = AsyncValue.error(l.message, StackTrace.current);
        SnackBar(
          content: Text(l.message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
        // Navigator.pop(context);
      },
      (r) async {
        state = AsyncValue.data(r.data['message']);
        // Show success message
        //successSnackBar(context, r.data['message'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(r.data['message']),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
        onSuccess();
      },
    );
  }

  void forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    state = const AsyncValue.loading();
    final res = await authApi.forgotPassword(email);
    res.fold(
      (l) {
        state = AsyncValue.error(l.message, StackTrace.current);
        SnackBar(
          content: Text(l.message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
        // Navigator.pop(context);
      },
      (r) async {
        // Show success message
        //successSnackBar(context, r.data['message'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(r.data['message']),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: email,
              verificationType: VerificationType.passwordReset,
            ),
          ),
        );
      },
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
