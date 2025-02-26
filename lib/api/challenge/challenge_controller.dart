import 'dart:io';

import 'package:book_app_m2m/models/challenges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/snackbars.dart';
import '../asset/asset_controller.dart';
import 'challenge_repo.dart';

class ChallengeController extends StateNotifier<AsyncValue<List<Challenges>>> {
  final ChallengeRepository repository;
  ChallengeController(this.repository) : super(const AsyncValue.loading()) {
    fetchChallenges();
  }

  List<Challenges> _allChallenges = [];

  /// Fetch all questions
  Future<void> fetchChallenges() async {
    try {
      state = const AsyncValue.loading();
      final challenges = await repository.fetchChallenges();
      _allChallenges = challenges;
      state = AsyncValue.data(challenges);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<String> createChallenge({
    required BuildContext context,
    required File file,
    required String title,
    required String description,
    required List<String> taggedUsers,
  }) async {
    final previousState = state; // Store the previous state to restore it later
    state = const AsyncValue.loading();
    try {
      final rowId = await repository.uploadAsset(file);
      showSuccessSnackBar(context, "$rowId");
      print("✅ File uploaded successfully");

      final message = await repository.createChallenge(
          title: title,
          description: description,
          taggedUsers: taggedUsers,
          coverImageId: rowId);
      showSuccessSnackBar(context, message);
      print("✅ Challenge created successfully: $message");
      Navigator.pop(context);

      await fetchChallenges();
      return message;
    } catch (e, stack) {
      showErrorSnackBar(context, e.toString());
      state = previousState;
      return e.toString();
    }
  }

  /// Create a new question and refresh the list
  // Future<String> createChallenge({
  //   required String title,
  //   required String description,
  //   required List<String> taggedUsers,
  //   required String coverImageId,
  // }) async {
  //   state = const AsyncValue.loading();
  //   try {
  //     final message = await repository.createChallenge(
  //         title: title,
  //         description: description,
  //         taggedUsers: taggedUsers,
  //         coverImageId: coverImageId);
  //     await fetchChallenges();
  //     return message;
  //   } catch (e, stack) {
  //     state = AsyncValue.error(e, stack);
  //     return e.toString();
  //   }
  // }

  /// Update an existing question and refresh the list
  Future<String> updateChallenge({
    required String challengeId,
    required String title,
    required String description,
    required List<String> taggedUsers,
    required String coverImageId,
    required bool status,
  }) async {
    final previousState = state; // Store the previous state to restore it later
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateChallenge(
          challengeId: challengeId,
          title: title,
          description: description,
          taggedUsers: taggedUsers,
          coverImageId: coverImageId,
          status: status);
      await fetchChallenges(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = previousState;
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteFamily(String challengeId) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteChallenge(challengeId);
      await fetchChallenges(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);

      return e.toString();
    }
  }

  /// Search functionality
  void searchQuestions(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allChallenges);
    } else {
      final filteredQuestions = _allChallenges
          .where((q) => q.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredQuestions);
    }
  }
}

// Provider for QuestionsController
final challengeControllerProvider = StateNotifierProvider.autoDispose<
    ChallengeController, AsyncValue<List<Challenges>>>(
  (ref) => ChallengeController(ref.watch(challengeRepositoryProvider)),
);

// Provider for QuestionsRepository
final challengeRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return ChallengeRepository(dioClient: dioClient);
});
