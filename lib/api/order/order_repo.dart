import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/orders.dart';

class OrdersRepository {
  final DioClient dioClient;

  OrdersRepository({required this.dioClient});

  Future<List<Orders>> fetchOrders() async {
    try {
      final response = await dioClient.get('/api/users/orders');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Orders.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load orders");
    }
  }

   /// Create a new question
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
    try {
      final response = await dioClient.post(
        '/api/users/orders',
        data: {
          "bookModelId": bookModelId,
          "numCopies": numCopies,
          "shippingAddress": shippingAddress,
          "shippingTaxRates": shippingTaxRates,
          "subTotal": subTotal,
          "totalCost": totalCost,
          "shippingMethod": shippingMethod,
          "paymentMethod": paymentMethod,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create orders");
    }
  }

  /// Update an existing question
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
    try {
      final response = await dioClient.put(
        '/api/users/orders/$orderId',
        data: {
          "numCopies": numCopies,
          "shippingAddress": shippingAddress,
          "shippingTaxRates": shippingTaxRates,
          "subTotal": subTotal,
          "totalCost": totalCost,
          "shippingMethod": shippingMethod,
          "paymentMethod": paymentMethod,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update order");
    }
  }

  /// Delete a question
  Future<String> deleteOrders(String orderId) async {
    try {
      final response = await dioClient.delete('/api/users/orders/$orderId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete order");
    }
  }
}