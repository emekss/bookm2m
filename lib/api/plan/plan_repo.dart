import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/plans.dart';

class PlanRepository {
  final DioClient dioClient;

  PlanRepository({required this.dioClient});

  Future<List<Plans>> fetchPlans() async {
    try {
      final response = await dioClient.get('/api/users/plans');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Plans.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load plans");
    }
  }
}