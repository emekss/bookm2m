import 'package:dio/dio.dart';
import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/asset.dart';

class AssetRepository {
  final DioClient dioClient;

  AssetRepository({required this.dioClient});

  Future<List<Assets>> fetchAssets() async {
    try {
      final response = await dioClient.get('/api/users/assets');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Assets.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load assets");
    }
  }
}
