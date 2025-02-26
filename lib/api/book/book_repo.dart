import 'dart:io';

import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/books.dart';

class BooksRepository {
  final DioClient dioClient;

  BooksRepository({required this.dioClient});

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
      throw Exception(e);
    }
  }

  Future<List<Books>> fetchBooks() async {
    try {
      final response = await dioClient.get('/api/users/books');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Books.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load books");
    }
  }

  /// Create a new question
  Future<String> createBooks({
    required String title,
    required String dedication,
    required String coverImageId,
    required num volumeNumber,
    required List<String> questions,
    required List<String> answers,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/books',
        data: {
          "title": title,
          "dedication": dedication,
          "coverImageId": coverImageId,
          "volumeNumber": volumeNumber,
          "questions": questions,
          "answers": answers,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to create books");
    }
  }

  /// Update an existing question
  Future<String> updateBooks({
    required String bookId,
    required String title,
    required String dedication,
    required String coverImageId,
    required num volumeNumber,
    required String status,
    required List<String> questions,
    required List<String> answers,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/books/$bookId',
        data: {
          "title": title,
          "dedication": dedication,
          "coverImageId": coverImageId,
          "volumeNumber": volumeNumber,
          "status": status,
          "questions": questions,
          "answers": answers,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update books");
    }
  }

  /// Delete a question
  Future<String> deleteBooks(String booksId) async {
    try {
      final response = await dioClient.delete('/api/users/books/$booksId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to delete books");
    }
  }
}
