import 'package:book_app_m2m/api/community/community_repo.dart';
import 'package:book_app_m2m/models/community.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../asset/asset_controller.dart';

class CommunityController extends StateNotifier<AsyncValue<List<Community>>> {
  final CommunityRepository repository;
  CommunityController(this.repository) : super(const AsyncValue.loading()) {
    fetchCommunity();
  }

  List<Community> _allCommunity = [];

  /// Fetch all questions
  Future<void> fetchCommunity() async {
    try {
      state = const AsyncValue.loading();
      final community = await repository.fetchChallenges();
      _allCommunity = community;
      state = AsyncValue.data(community);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider for QuestionsController
final communityControllerProvider = StateNotifierProvider.autoDispose<
    CommunityController, AsyncValue<List<Community>>>(
  (ref) => CommunityController(ref.watch(communityRepositoryProvider)),
);

// Provider for QuestionsRepository
final communityRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return CommunityRepository(dioClient: dioClient);
});
