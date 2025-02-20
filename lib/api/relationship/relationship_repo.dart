import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/relationship.dart';

class RelationshipRepository {
  final DioClient dioClient;

  RelationshipRepository({required this.dioClient});

  Future<List<Relationship>> fetchRelationship() async {
    try {
      final response = await dioClient.get('/api/users/relationships');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Relationship.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load relationships");
    }
  }
}