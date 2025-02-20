import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/challenges.dart';

class ChallengeRepository {
  final DioClient dioClient;

  ChallengeRepository({required this.dioClient});

  Future<List<Challenges>> fetchChallenges() async {
    try {
      final response = await dioClient.get('/api/users/challenges');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Challenges.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load challenges");
    }
  }

   /// Create a new question
  Future<String> createChallenge({
    required String title,
    required String description,
    required List<String> taggedUsers,
    required String coverImageId,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/challenges',
        data: {
          "title": title,
          "description": description,
          "taggedUsers": taggedUsers,
          "coverImageId": coverImageId,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create challenge");
    }
  }

  /// Update an existing question
  Future<String> updateChallenge({
    required String challengeId,
    required String title,
    required String description,
    required List<String> taggedUsers,
    required String coverImageId,
    required bool status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/challenges/$challengeId',
        data: {
          "title": title,
          "description": description,
          "taggedUsers": taggedUsers,
          "coverImageId": coverImageId,
          "status": status
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update challenges");
    }
  }

  /// Delete a question
  Future<String> deleteChallenge(String challengeId) async {
    try {
      final response = await dioClient.delete('/api/users/challenges/$challengeId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete order");
    }
  }
}