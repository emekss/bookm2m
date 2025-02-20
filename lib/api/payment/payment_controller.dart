import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/subscription.dart';
import '../asset/asset_controller.dart';
import 'payment_repo.dart';

class PaymentController extends StateNotifier<AsyncValue<List<Payment>>> {
  final PaymentRepository repository;
  PaymentController(this.repository) : super(const AsyncValue.loading()) {
    fetchPayments();
  }

  // List<Sub> _allSubs = [];

  /// Fetch all questions
  Future<void> fetchPayments() async {
    try {
      state = const AsyncValue.loading();
      final payments = await repository.fetchPayments();
      // _allSubs = subs;
      state = AsyncValue.data(payments);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createPayment({
    required String subscriptionId,
    required String amount,
    required String method,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.createPayment(
          subscriptionId: subscriptionId, amount: amount, method: method);
      await fetchPayments(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updatePayment({
    required String id,
    required String amount,
    required String method,
    required String status,
  }) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.updatePayment(
          id: id, amount: amount, method: method, status: status);
      await fetchPayments(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deletePayment(String id) async {
    state = const AsyncValue.loading();
    try {
      final message = await repository.deletePayment(id);
      await fetchPayments(); // Refresh questions list
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
final paymentControllerProvider =
    StateNotifierProvider.autoDispose<PaymentController, AsyncValue<List<Sub>>>(
  (ref) => PaymentController(ref.watch(paymentRepositoryProvider)),
);

// Provider for QuestionsRepository
final paymentRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return PaymentRepository(dioClient: dioClient);
});
