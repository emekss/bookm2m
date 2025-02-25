import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/users_model.dart';

class UsersRepository {
  final DioClient dioClient;

  UsersRepository({required this.dioClient});

  Future<List<UsersModel>> fetchUsers() async {
    try {
      final response = await dioClient.get('/api/users/all');
      final data = response.data['data']['rows'] as List;
      print(data);
      return data.map((json) => UsersModel.fromJson(json)).toList();
    } on DioException catch (e) {
      print(e);
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}