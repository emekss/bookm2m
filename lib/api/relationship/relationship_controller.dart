import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/relationship.dart';
import '../asset/asset_controller.dart';
import 'relationship_repo.dart';

class RelationshipController
    extends StateNotifier<AsyncValue<List<Relationship>>> {
  final RelationshipRepository repository;
  RelationshipController(this.repository) : super(const AsyncValue.loading()) {
    fetchRelationship();
  }

  // List<Sub> _allSubs = [];

  /// Fetch all questions
  Future<void> fetchRelationship() async {
    try {
      state = const AsyncValue.loading();
      final relationship = await repository.fetchRelationship();
      // _allSubs = subs;
      state = AsyncValue.data(relationship);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider for QuestionsController
final relationshipControllerProvider = StateNotifierProvider.autoDispose<
    RelationshipController, AsyncValue<List<Relationship>>>(
  (ref) => RelationshipController(ref.watch(relationshipRepositoryProvider)),
);

// Provider for QuestionsRepository
final relationshipRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return RelationshipRepository(dioClient: dioClient);
});
