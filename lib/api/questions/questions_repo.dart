import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/questions.dart';

class QuestionsRepository {
  final DioClient dioClient;

  QuestionsRepository({required this.dioClient});

  Future<List<Questions>> fetchQuestions() async {
    try {
      final response = await dioClient.get('/api/users/questions');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Questions.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  /// Create a new question
  Future<String> createQuestion({
    required String prompt,
    required String help,
    required String topicId,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/questions',
        data: {
          "prompt": prompt,
          "help": help,
          "topicId": topicId,
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
  Future<String> updateQuestion({
    required String questionId,
    required String prompt,
    required String help,
    required String topicId,
    required bool status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/questions/$questionId',
        data: {
          "prompt": prompt,
          "help": help,
          "topicId": topicId,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Delete a question
  Future<String> deleteQuestion(String questionId) async {
    try {
      final response =
          await dioClient.delete('/api/users/questions/$questionId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
