import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/book_option.dart';
import '../asset/asset_controller.dart';
import 'book_option_repo.dart';

class BookOptionController extends StateNotifier<AsyncValue<List<BookOption>>> {
  final BookOptionRepository repository;
  BookOptionController(this.repository) : super(const AsyncValue.loading()) {
    fetchBookOptions();
  }

  // List<Sub> _allSubs = [];

  /// Fetch all questions
  Future<void> fetchBookOptions() async {
    try {
      state = const AsyncValue.loading();
      final bookOptions = await repository.fetchBookOptions();
      // _allSubs = subs;
      state = AsyncValue.data(bookOptions);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider for QuestionsController
final bookOptionsControllerProvider = StateNotifierProvider.autoDispose<
    BookOptionController, AsyncValue<List<BookOption>>>(
  (ref) => BookOptionController(ref.watch(bookOptionsRepositoryProvider)),
);

// Provider for QuestionsRepository
final bookOptionsRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return BookOptionRepository(dioClient: dioClient);
});
