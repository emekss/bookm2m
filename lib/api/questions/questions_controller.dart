import 'package:book_app_m2m/api/questions/questions_repo.dart';
import 'package:book_app_m2m/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/asset.dart';
import '../../models/questions.dart';
import '../asset/asset_controller.dart';

class QuestionsController extends StateNotifier<AsyncValue<List<Questions>>> {
  final QuestionsRepository repository;
  QuestionsController(this.repository) : super(const AsyncValue.loading()) {
    fetchQuestions();
  }

  List<Questions> _allQuestions = [];

  /// Fetch all questions
  Future<void> fetchQuestions() async {
    try {
      state = const AsyncValue.loading();
      final questions = await repository.fetchQuestions();
      _allQuestions = questions;
      state = AsyncValue.data(questions);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createQuestion(
      {required String prompt,
      required String help,
      required String topicId,
      required BuildContext context}) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final message = await repository.createQuestion(
        prompt: prompt,
        help: help,
        topicId: topicId,
      );
      await fetchQuestions(); // Refresh questions list
      showSuccessSnackBar(context, message);
      Navigator.pop(context);
      return message;
    } catch (e, stack) {
      showErrorSnackBar(context, e.toString());
      state = previousState;
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updateQuestion({
    required BuildContext context,
    required String questionId,
    required String prompt,
    required String help,
    required String topicId,
    required bool status,
  }) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateQuestion(
        questionId: questionId,
        prompt: prompt,
        help: help,
        topicId: topicId,
        status: status,
      );
      showSuccessSnackBar(context, message);
      await fetchQuestions(); // Refresh questions list
      return message;
    } catch (e, stack) {
      showErrorSnackBar(context, e.toString());
      state = previousState;
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteQuestion(String questionId) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteQuestion(questionId);
      await fetchQuestions();
      // showSuccessSnackBar(context, message);
      return message;
    } catch (e, stack) {
      print(e);
      // showErrorSnackBar(context, e.toString());
      state = previousState;

      return e.toString();
    }
  }

  /// Search functionality
  void searchQuestions(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allQuestions);
    } else {
      final filteredQuestions = _allQuestions
          .where((q) => q.prompt!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredQuestions);
    }
  }
}

// Provider for QuestionsController
final questionsControllerProvider = StateNotifierProvider.autoDispose<
    QuestionsController, AsyncValue<List<Questions>>>(
  (ref) => QuestionsController(ref.watch(questionsRepositoryProvider)),
);

// Provider for QuestionsRepository
final questionsRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return QuestionsRepository(dioClient: dioClient);
});
