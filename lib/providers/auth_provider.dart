import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/token_manager.dart';

// final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<bool>>((ref) {
//   return AuthNotifier(ref);
// });

// class AuthNotifier extends StateNotifier<AsyncValue<bool>> {
//   final Ref ref;

//   AuthNotifier(this.ref) : super(const AsyncLoading()) {
//     _checkAuthStatus();
//   }

//   Future<void> _checkAuthStatus() async {
//     try {
//       final tokenStorage = TokenManager();
//       final token = await tokenStorage.getToken();
//       final targetLanguage = ref.read(targetLanguageProvider);

//       if (targetLanguage == null) {
//         state = const AsyncData(false); // Navigate to Onboard
//         return;
//       }

//       if (token != null && _isTokenValid(token)) {
//         state = const AsyncData(true); // Navigate to UiServer
//       } else {
//         state = const AsyncData(false); // Navigate to CreateAccount
//       }
//     } catch (e) {
//       state = AsyncError(e, StackTrace.current);
//     }
//   }

//   bool _isTokenValid(String token) {
//     // Add logic to check token validity if needed
//     return true; // Assume valid for now
//   }
// }