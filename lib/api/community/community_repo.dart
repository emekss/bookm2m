
import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/community.dart';

class CommunityRepository {
  final DioClient dioClient;

  CommunityRepository({required this.dioClient});

  Future<List<Community>> fetchChallenges() async {
    try {
      final response = await dioClient.get('/api/users/challenges');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Community.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}