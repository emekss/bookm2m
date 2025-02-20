import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/topic_model.dart';
import '../asset/asset_controller.dart';
import 'topic_repo.dart';

class TopicController extends StateNotifier<AsyncValue<List<TopicModel>>> {
  final TopicRepository repository;
  TopicController(this.repository) : super(const AsyncValue.loading()) {
    fetchTopics();
  }

  List<TopicModel> _allTopics = [];

  /// Fetch all questions
  Future<void> fetchTopics() async {
    try {
      state = const AsyncValue.loading();
      final topics = await repository.fetchTopic();
      _allTopics = topics;
      state = AsyncValue.data(topics);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createTopic({
    required String name,
    required String coverImageId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message =
          await repository.createTopic(name: name, coverImageId: coverImageId);
      await fetchTopics(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updateTopic({
    required String id,
    required String name,
    required String coverImageId,
    required String status,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateTopic(
          id: id, name: name, coverImageId: coverImageId, status: status);
      await fetchTopics(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteTopic(String topicId) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteTopic(topicId);
      await fetchTopics(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);

      return e.toString();
    }
  }

  /// Search functionality
  void searchTopic(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allTopics);
    } else {
      final filteredQuestions = _allTopics
          .where((q) => q.prompt!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredQuestions);
    }
  }
}

// Provider for QuestionsController
final topicControllerProvider = StateNotifierProvider.autoDispose<
    TopicController, AsyncValue<List<TopicModel>>>(
  (ref) => TopicController(ref.watch(topicRepositoryProvider)),
);

// Provider for QuestionsRepository
final topicRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return TopicRepository(dioClient: dioClient);
});
