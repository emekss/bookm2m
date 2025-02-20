import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/subscription.dart';

class PaymentRepository {
  final DioClient dioClient;

  PaymentRepository({required this.dioClient});

  Future<List<Payment>> fetchPayments() async {
    try {
      final response = await dioClient.get('/api/users/payments');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Payment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load payments");
    }
  }

   /// Create a new question
  Future<String> createPayment({
    required String subscriptionId,
    required String amount,
    required String method,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/payments',
        data: {
          "subscriptionId": subscriptionId,
          "amount": amount,
          "method": method
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create payment");
    }
  }

  /// Update an existing question
  Future<String> updatePayment({
    required String id,
     required String amount,
     required String method,
    required String status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/payments/$id',
        data: {
          "amount": amount,
          "method": method,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update payment");
    }
  }

  /// Delete a question
  Future<String> deletePayment(String id) async {
    try {
      final response = await dioClient.delete('/api/users/payments/$id');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete payment");
    }
  }
}