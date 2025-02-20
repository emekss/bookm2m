import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book_model.dart';
import '../../models/book_model_types.dart';
import '../asset/asset_controller.dart';
import 'book_model_repo.dart';

class BookModelController extends StateNotifier<AsyncValue<List<BookModel>>> {
  final BookModelRepository repository;
  BookModelController(this.repository) : super(const AsyncValue.loading()) {
    fetchBookModels();
  }

  List<BookModel> _allBookModels = [];

  /// Fetch all questions
  Future<void> fetchBookModels() async {
    try {
      state = const AsyncValue.loading();
      final bookModels = await repository.fetchBookModels();
      _allBookModels = bookModels;
      state = AsyncValue.data(bookModels);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createBookModel({
    required String name,
    required String bookId,
    required List<BookModelTypes> options,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.createBookModel(
          name: name, bookId: bookId, options: options);
      await fetchBookModels();
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updateBookModel({
    required String bookModelId,
    required String name,
    required List<BookModelTypes> options,
    required String status,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateBookModel(
          bookModelId: bookModelId,
          name: name,
          options: options,
          status: status);
      await fetchBookModels(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteBookModel(String bookModelId) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteBookModel(bookModelId);
      await fetchBookModels(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);

      return e.toString();
    }
  }

  /// Search functionality
  void searchQuestions(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allBookModels);
    } else {
      final filteredBookModels = _allBookModels
          .where((q) => q.book!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredBookModels);
    }
  }
}

// Provider for QuestionsController
final bookModelControllerProvider = StateNotifierProvider.autoDispose<
    BookModelController, AsyncValue<List<BookModel>>>(
  (ref) => BookModelController(ref.watch(bookModelRepositoryProvider)),
);

// Provider for QuestionsRepository
final bookModelRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return BookModelRepository(dioClient: dioClient);
});
