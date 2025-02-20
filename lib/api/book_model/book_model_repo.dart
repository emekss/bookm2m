import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/book_model.dart';
import '../../models/book_model_types.dart';

class BookModelRepository {
  final DioClient dioClient;

  BookModelRepository({required this.dioClient});

  Future<List<BookModel>> fetchBookModels() async {
    try {
      final response = await dioClient.get('/api/users/bookModels');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => BookModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load book models");
    }
  }

   /// Create a new question
  Future<String> createBookModel({
    required String name,
    required String bookId,
    required List<BookModelTypes> options,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/bookModels',
        data: {
          "name": name,
          "bookId": bookId,
          "options": options,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create book models");
    }
  }

  /// Update an existing question
  Future<String> updateBookModel({
    required String bookModelId,
    required String name,
    required List<BookModelTypes> options,
    required String status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/bookModels/$bookModelId',
        data: {
          "name": name,
          "options": options,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update book models");
    }
  }

  /// Delete a question
  Future<String> deleteBookModel(String bookModelId) async {
    try {
      final response = await dioClient.delete('/api/users/bookModels/$bookModelId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete book models");
    }
  }
}