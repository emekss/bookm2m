import 'dart:io';

import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/family.dart';

class FamilyRepository {
  final DioClient dioClient;

  FamilyRepository({required this.dioClient});

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

  Future<List<Families>> fetchFamily() async {
    try {
      final response = await dioClient.get('/api/users/family');
      final data = response.data['data']['rows'] as List;
      return data.map((json) => Families.fromJson(json)).toList();
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception("Failed to load family");
    }
  }

  /// Create a new question
  Future<String> createFamily({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String birthDate,
    required String profileImageId,
    required String relationId,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/family',
        data: {
          "fullName": fullName,
          "phoneNumber": phoneNumber,
          "email": email,
          "birthDate": birthDate,
          "profileImageId": profileImageId,
          "relationId": relationId,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Update an existing question
  Future<String> updateFamily({
    required String familyId,
    required String relationId,
    required bool status,
  }) async {
    try {
      final response = await dioClient.put(
        '/api/users/family/$familyId',
        data: {
          "relationId": relationId,
          "status": status,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  /// Delete a question
  Future<String> deleteFamily(String familyId) async {
    try {
      final response = await dioClient.delete('/api/users/family/$familyId');
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
