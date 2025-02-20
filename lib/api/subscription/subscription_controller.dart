import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/subscription.dart';
import '../asset/asset_controller.dart';
import 'subscription_repo.dart';

class SubController extends StateNotifier<AsyncValue<List<Sub>>> {
  final SubRepository repository;
  SubController(this.repository) : super(const AsyncValue.loading()) {
    fetchSub();
  }

  List<Sub> _allSubs = [];

  /// Fetch all questions
  Future<void> fetchSub() async {
    try {
      state = const AsyncValue.loading();
      final subs = await repository.fetchSubs();
      _allSubs = subs;
      state = AsyncValue.data(subs);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createSub({
    required String planId,
    required DateTime startDate,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message =
          await repository.createSub(planId: planId, startDate: startDate);
      await fetchSub(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updateTopic({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    required bool status,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateSub(
          id: id, startDate: startDate, endDate: endDate, status: status);
      await fetchSub(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteSub(String id) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteSub(id);
      await fetchSub(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);

      return e.toString();
    }
  }

  /// Search functionality
  // void searchTopic(String query) {
  //   if (query.isEmpty) {
  //     state = AsyncValue.data(_allSubs);
  //   } else {
  //     final filteredQuestions = _allSubs
  //         .where((q) => q.prompt!.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //     state = AsyncValue.data(filteredQuestions);
  //   }
  // }
}

// Provider for QuestionsController
final subControllerProvider =
    StateNotifierProvider.autoDispose<SubController, AsyncValue<List<Sub>>>(
  (ref) => SubController(ref.watch(subRepositoryProvider)),
);

// Provider for QuestionsRepository
final subRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return SubRepository(dioClient: dioClient);
});
