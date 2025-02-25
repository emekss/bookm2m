import 'dart:io';

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
      throw Exception(e);
    }
  }

  Future<String> uploadAsset(File file, List<String> users, String type, String description) async {
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

      return response.data["message"]; // Extract rowId
    } on DioException catch (e) {
      print(e);
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to upload asset");
    }
  }
}
