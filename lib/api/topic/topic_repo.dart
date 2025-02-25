import 'dart:io';

import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/topic_model.dart';

class TopicRepository {
  final DioClient dioClient;

  TopicRepository({required this.dioClient});

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

  Future<List<TopicModel>> fetchTopic() async {
    try {
      final response = await dioClient.get('/api/users/topics');
      final data = response.data['data']['rows'] as List;
      print(data);
      return data.map((json) => TopicModel.fromJson(json)).toList();
    } on DioException catch (e) {
      print(e);
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  /// Create a new question
  Future<String> createTopic({
    required String name,
    required String coverImageId,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/topics',
        data: {
          "name": name,
          "coverImageId": coverImageId,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create question");
    }
  }

  /// Update an existing question
  Future<String> updateTopic({
    required String id,
    required String name,
    required String coverImageId,
    required String status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/topics/$id',
        data: {
          "name": name,
          "coverImageId": coverImageId,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update question");
    }
  }

  /// Delete a question
  Future<String> deleteTopic(String topicId) async {
    try {
      final response = await dioClient.delete('/api/users/topics/$topicId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete question");
    }
  }
}
