import 'dart:io';

import 'package:book_app_m2m/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/family.dart';
import '../asset/asset_controller.dart';
import 'family_repo.dart';

class FamilyController extends StateNotifier<AsyncValue<List<Families>>> {
  final FamilyRepository repository;
  FamilyController(this.repository) : super(const AsyncValue.loading()) {
    fetchFamily();
  }

  List<Families> _allFamily = [];

  /// Fetch all questions
  Future<void> fetchFamily() async {
    try {
      state = const AsyncValue.loading();
      final family = await repository.fetchFamily();
      _allFamily = family;
      state = AsyncValue.data(family);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createFamily({
    required BuildContext context,
    required String fullName,
    required String phoneNumber,
    required String email,
    required String birthDate,
    required String relationId,
    required File coverImg,
  }) async {
    final previousState = state; // Store the previous state to restore it later
    state = const AsyncValue.loading();
    try {
      final rowId = await repository.uploadAsset(coverImg);
      showSuccessSnackBar(context, "✅ File uploaded successfully");
      print("✅ File uploaded successfully");
      final message = await repository.createFamily(
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        birthDate: birthDate,
        profileImageId: rowId,
        relationId: relationId,
      );
      showSuccessSnackBar(context, message);
      await fetchFamily();
      Navigator.pop(context);
      return message;
    } catch (e, stack) {
      showErrorSnackBar(context, e.toString());
      state = previousState;
      return e.toString();
    }
  }


  Future<String> updateFamily({
    // required BuildContext context,
    required String familyId,
    required String relationId,
    required bool status,
  }) async {
    final previousState = state; 
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateFamily(
          familyId: familyId, relationId: relationId, status: status);
      await fetchFamily(); 
      return message;
    } catch (e, stack) {
      state = previousState;
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteFamily(String familyId) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteFamily(familyId);
      await fetchFamily(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = previousState;
      return e.toString();
    }
  }

  /// Search functionality
  void searchQuestions(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allFamily);
    } else {
      final filteredQuestions = _allFamily
          .where((q) =>
              q.fullName!.toLowerCase().contains(query.toLowerCase()) ||
              q.fullName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredQuestions);
    }
  }
}

// Provider for QuestionsController
final familyControllerProvider = StateNotifierProvider.autoDispose<
    FamilyController, AsyncValue<List<Families>>>(
  (ref) => FamilyController(ref.watch(familyRepositoryProvider)),
);

// Provider for QuestionsRepository
final familyRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return FamilyRepository(dioClient: dioClient);
});
