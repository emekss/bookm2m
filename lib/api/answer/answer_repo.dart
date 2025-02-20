import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/answers.dart';

class AnswersRepository {
  final DioClient dioClient;

  AnswersRepository({required this.dioClient});

  Future<List<Answers>> fetchAnswers() async {
    try {
      final response = await dioClient.get('/api/users/answers');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Answers.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load answers");
    }
  }

   /// Create a new question
  Future<String> createAnswers({
    required String questionId,
    required String prompt,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/answers',
        data: {
          "questionId": questionId,
          "prompt": prompt,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create answers");
    }
  }

  /// Update an existing question
  Future<String> updateAnswer({
    required String answerId,
    required String prompt,
    required bool status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/answers/$answerId',
        data: {
          "prompt": prompt,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update answers");
    }
  }

  /// Delete a question
  Future<String> deleteAnswer(String answerId) async {
    try {
      final response = await dioClient.delete('/api/users/answers/$answerId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete answers");
    }
  }
}