import 'package:book_app_m2m/models/plans.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/subscription.dart';
import '../asset/asset_controller.dart';
import 'plan_repo.dart';

class PlanController extends StateNotifier<AsyncValue<List<Plans>>> {
  final PlanRepository repository;
  PlanController(this.repository) : super(const AsyncValue.loading()) {
    fetchPlans();
  }

  // List<Sub> _allSubs = [];

  /// Fetch all questions
  Future<void> fetchPlans() async {
    try {
      state = const AsyncValue.loading();
      final plans = await repository.fetchPlans();
      // _allSubs = subs;
      state = AsyncValue.data(plans);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// Provider for QuestionsController
final planControllerProvider =
    StateNotifierProvider.autoDispose<PlanController, AsyncValue<List<Plan>>>(
  (ref) => PlanController(ref.watch(planRepositoryProvider)),
);

// Provider for QuestionsRepository
final planRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return PlanRepository(dioClient: dioClient);
});
