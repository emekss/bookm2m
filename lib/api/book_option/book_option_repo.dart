import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/book_option.dart';

class BookOptionRepository {
  final DioClient dioClient;

  BookOptionRepository({required this.dioClient});

  Future<List<BookOption>> fetchBookOptions() async {
    try {
      final response = await dioClient.get('/api/users/bookOptions');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => BookOption.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load book options");
    }
  }
}