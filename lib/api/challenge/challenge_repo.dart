import 'dart:io';

import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/challenges.dart';

class ChallengeRepository {
  final DioClient dioClient;

  ChallengeRepository({required this.dioClient});

  Future<String> uploadAsset(File file) async {
    try {
      FormData formData = FormData.fromMap({
        "title": file.path
            .split('/')
            .last, // API requires title, but it's optional (empty string)
        "description": 0,
        "type": "",
        "taggedUsers": [],
        "file": await MultipartFile.fromFile(file.path),
      });

      final response = await dioClient.post(
        '/api/users/assets',
        data: formData,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );

      return response.data["rowId"]; // Extract rowId
    } on DioException catch (e) {
      print(e);
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to upload asset");
    }
  }

  Future<List<Challenges>> fetchChallenges() async {
    try {
      final response = await dioClient.get('/api/users/challenges');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Challenges.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception(e);
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
      final response =
          await dioClient.delete('/api/users/challenges/$challengeId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete order");
    }
  }
}
