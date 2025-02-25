import 'package:book_app_m2m/widgets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/answers.dart';
import '../asset/asset_controller.dart';
import 'answer_repo.dart';

class AnswerController extends StateNotifier<AsyncValue<List<Answers>>> {
  final AnswersRepository repository;
  AnswerController(this.repository) : super(const AsyncValue.loading()) {
    fetchAnswers();
  }

  List<Answers> _allAnswers = [];

  /// Fetch all questions
  Future<void> fetchAnswers() async {
    try {
      state = const AsyncValue.loading();
      final answers = await repository.fetchAnswers();
      _allAnswers = answers;
      state = AsyncValue.data(answers);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createAnswers({
    required BuildContext context,
    required String questionId,
    required String prompt,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.createAnswers(
          questionId: questionId, prompt: prompt);
      await fetchAnswers();
      showSuccessSnackBar(context, message);
      Navigator.pop(context);
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      showErrorSnackBar(context, e.toString());
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updateAnswer({
    required String answerId,
    required String prompt,
    required bool status,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateAnswer(
          answerId: answerId, prompt: prompt, status: status);
      await fetchAnswers(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteAnswer(String answerId) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteAnswer(answerId);
      await fetchAnswers(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);

      return e.toString();
    }
  }

  /// Search functionality
  void searchQuestions(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allAnswers);
    } else {
      final filteredAnswer = _allAnswers
          .where((q) => q.prompt!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredAnswer);
    }
  }
}

// Provider for QuestionsController
final answerControllerProvider = StateNotifierProvider.autoDispose<
    AnswerController, AsyncValue<List<Answers>>>(
  (ref) => AnswerController(ref.watch(answerRepositoryProvider)),
);

// Provider for QuestionsRepository
final answerRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return AnswersRepository(dioClient: dioClient);
});
