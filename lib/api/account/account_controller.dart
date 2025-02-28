import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user_profile.dart';
import '../asset/asset_controller.dart';
import 'account_repo.dart';

class AccountController extends StateNotifier<AsyncValue<UserProfile>> {
  final AccountRepository repository;
  AccountController(this.repository) : super(const AsyncValue.loading()) {
    fetchUserProfile();
  }

  /// Fetch all questions
  Future<void> fetchUserProfile() async {
    try {
      state = const AsyncValue.loading();
      final user = await repository.fetchUser();
      // _allSubs = subs;
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> updateProfiles({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String startDate,
    required String motivationalQuote,
    required String profileImageId,
  }) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateUsers(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          startDate: startDate,
          motivationalQuote: motivationalQuote,
          profileImageId: profileImageId);
      await fetchUserProfile(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = previousState;
      return e.toString();
    }
  }

    Future<String> updateProfile({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? motivationalQuote,
    File? profileImage,
  }) async {
    final previousState = state;
    state = const AsyncValue.loading();

    try {
      Map<String, dynamic> updatedFields = {};

      if (firstName != null) updatedFields["firstName"] = firstName;
      if (lastName != null) updatedFields["lastName"] = lastName;
      if (phoneNumber != null) updatedFields["phoneNumber"] = phoneNumber;
      if (motivationalQuote != null) updatedFields["motivationalQuote"] = motivationalQuote;

      // Upload image if provided
      if (profileImage != null) {
        String imageId = await repository.uploadProfileImage(profileImage);
        updatedFields["profileImageId"] = imageId;
      }

      final message = await repository.updateUser(updatedFields);
      await fetchUserProfile(); // Refresh data
      return message;
    } catch (e, stack) {
      state = previousState;
      return e.toString();
    }
  }
}

// Provider for QuestionsController
final accountControllerProvider = StateNotifierProvider.autoDispose<
    AccountController, AsyncValue<UserProfile>>(
  (ref) => AccountController(ref.watch(accountRepositoryProvider)),
);

// Provider for QuestionsRepository
final accountRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return AccountRepository(dioClient: dioClient);
});
