import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/subscription.dart';

class SubRepository {
  final DioClient dioClient;

  SubRepository({required this.dioClient});

  Future<List<Sub>> fetchSubs() async {
    try {
      final response = await dioClient.get('/api/users/subscriptions');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Sub.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load subsciptions");
    }
  }

   /// Create a new question
  Future<String> createSub({
    required String planId,
    required DateTime startDate,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/subscriptions',
        data: {
          "planId": planId,
          "startDate": startDate,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create subscription");
    }
  }

  /// Update an existing question
  Future<String> updateSub({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
    required bool status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/subscriptions/$id',
        data: {
          "startDate": startDate,
          "endDate": endDate,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update subscription");
    }
  }

  /// Delete a question
  Future<String> deleteSub(String id) async {
    try {
      final response = await dioClient.delete('/api/users/subscriptions/$id');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete subscription");
    }
  }
}