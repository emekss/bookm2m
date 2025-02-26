import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/orders.dart';
import '../asset/asset_controller.dart';
import 'order_repo.dart';

class OrdersController extends StateNotifier<AsyncValue<List<Orders>>> {
  final OrdersRepository repository;
  OrdersController(this.repository) : super(const AsyncValue.loading()) {
    fetchOrders();
  }

  List<Orders> _allOrders = [];

  /// Fetch all questions
  Future<void> fetchOrders() async {
    try {
      state = const AsyncValue.loading();
      final orders = await repository.fetchOrders();
      _allOrders = orders;
      state = AsyncValue.data(orders);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// Create a new question and refresh the list
  Future<String> createOrders({
    required String bookModelId,
    required num numCopies,
    required String shippingAddress,
    required num shippingTaxRates,
    required double subTotal,
    required double totalCost,
    required String shippingMethod,
    required String paymentMethod,
  }) async {
    final previousState = state; // Store the previous state to restore it later
    state = const AsyncValue.loading();
    try {
      final message = await repository.createOrders(
          bookModelId: bookModelId,
          numCopies: numCopies,
          shippingAddress: shippingAddress,
          shippingTaxRates: shippingTaxRates,
          subTotal: subTotal,
          totalCost: totalCost,
          shippingMethod: shippingMethod,
          paymentMethod: paymentMethod);
      await fetchOrders(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = previousState;
      return e.toString();
    }
  }

  /// Update an existing question and refresh the list
  Future<String> updateOrders({
    required String orderId,
    required num numCopies,
    required String shippingAddress,
    required num shippingTaxRates,
    required double subTotal,
    required double totalCost,
    required String shippingMethod,
    required String paymentMethod,
    required String status,
  }) async {
     final previousState = state;
    state = const AsyncValue.loading();
    try {
      final message = await repository.updateOrders(
          orderId: orderId,
          numCopies: numCopies,
          shippingAddress: shippingAddress,
          shippingTaxRates: shippingTaxRates,
          subTotal: subTotal,
          totalCost: totalCost,
          shippingMethod: shippingMethod,
          paymentMethod: paymentMethod,
          status: status);
      await fetchOrders(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = previousState;
      return e.toString();
    }
  }

  /// Delete a question and refresh the list
  Future<String> deleteOrders(String orderId) async {
    final previousState = state;
    state = const AsyncValue.loading();
    try {
      final message = await repository.deleteOrders(orderId);
      await fetchOrders(); // Refresh questions list
      return message;
    } catch (e, stack) {
      state = previousState;

      return e.toString();
    }
  }

  /// Search functionality
  void searchQuestions(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allOrders);
    } else {
      final filteredQuestions = _allOrders
          .where((q) =>
              q.paymentMethod!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filteredQuestions);
    }
  }
}

// Provider for QuestionsController
final ordersControllerProvider = StateNotifierProvider.autoDispose<
    OrdersController, AsyncValue<List<Orders>>>(
  (ref) => OrdersController(ref.watch(ordersRepositoryProvider)),
);

// Provider for QuestionsRepository
final ordersRepositoryProvider = Provider((ref) {
  final dioClient = ref.read(dioClientProvider);
  return OrdersRepository(dioClient: dioClient);
});
