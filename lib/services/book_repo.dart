import 'dart:convert';

import 'package:book_app_m2m/models/book.dart';
import 'package:book_app_m2m/services/token_manager.dart';
import 'package:book_app_m2m/utils/constants.dart';
import 'package:http/http.dart' as http;

class BookRepo {
  final TokenManager _tokenManager;

  BookRepo._(this._tokenManager);

  static Future<BookRepo> init() async {
    return BookRepo._(await TokenManager.getInstance());
  }

  Future<List<Book>> fetchAllBooks() async {
    try {
      final token = _tokenManager.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Sign in again.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/users/books'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final List booksList = List.from(responseData['data']['rows']);
        final List<Book> books = [];
        for (int i = 0; i < books.length; i++) {
          books.add(
            Book.fromMap(Map<String, dynamic>.from(booksList[i])),
          );
        }

        print(books);
        return books;
      } else {
        throw Exception(
            responseData['message'] ?? 'Failed to fetch user details');
      }
    } catch (e) {
      throw Exception(
          'An error occurred. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> createBook({
    required String title,
    required String dedication,
    required String coverImageUrl,
    required int volumeNumber,
  }) async {
    try {
      final token = _tokenManager.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Sign in again.');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/api/users/books'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "title": title,
          "dedication": dedication,
          "coverImageUrl": coverImageUrl,
          "volumeNumber": volumeNumber,
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String message = responseData['message'];
        final String bookId = responseData['rowId'];
        return {
          "message": message,
          "bookId": bookId,
        };
      } else if (response.statusCode == 400) {
        throw Exception('Book already exists.');
      } else {
        throw Exception(
            responseData['message'] ?? 'An unexpected error occurred');
      }
    } catch (e) {
      throw Exception(
          'An error occurred. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> updateBook({
    required String bookId,
    required String title,
    required String dedication,
    required String coverImageUrl,
    required int volumeNumber,
  }) async {
    try {
      final token = _tokenManager.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Sign in again.');
      }

      final response = await http.put(
        Uri.parse('$baseUrl/api/users/books/$bookId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "title": title,
          "dedication": dedication,
          "coverImageUrl": coverImageUrl,
          "volumeNumber": volumeNumber,
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String message = responseData['message'];
        final String bookId = responseData['rowId'];
        return {
          "message": message,
          "bookId": bookId,
        };
      } else if (response.statusCode == 404) {
        throw Exception('Book doesn\'t exist.');
      } else {
        throw Exception(
            responseData['message'] ?? 'An unexpected error occurred');
      }
    } catch (e) {
      throw Exception(
          'An error occurred. Please check your internet connection.');
    }
  }

  Future<Map<String, dynamic>> deleteBook({required String bookId}) async {
    try {
      final token = _tokenManager.getToken();
      if (token == null) {
        throw Exception('No authentication token found. Sign in again.');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/api/users/books/$bookId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String message = responseData['message'];
        final String bookId = responseData['rowId'];
        return {
          "message": message,
          "bookId": bookId,
        };
      } else if (response.statusCode == 404) {
        throw Exception('Book doesn\'t exist.');
      } else {
        throw Exception(
            responseData['message'] ?? 'An unexpected error occurred');
      }
    } catch (e) {
      throw Exception(
          'An error occurred. Please check your internet connection.');
    }
  }
}
