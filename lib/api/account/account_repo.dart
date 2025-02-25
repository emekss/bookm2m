import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../models/user_profile.dart';

class AccountRepository {
  final DioClient dioClient;

  AccountRepository({required this.dioClient});

  Future<UserProfile> fetchUser() async {
    try {
      final response = await dioClient.get('/api/users/me');
      final data = response.data['data']['user'];

      return UserProfile.fromJson(data); // ✅ Correct
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  /// Create a new question
  Future<String> updateUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String startDate,
    required String motivationalQuote,
    required String profileImageId,
  }) async {
    try {
      final response = await dioClient.post(
        '/api/users/updateProfile',
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "phoneNumber": phoneNumber,
          "startDate": startDate,
          "motivationalQuote": motivationalQuote,
          "profileImageId": profileImageId,
        },
      );
      return response.data['message'];
    } on DioException catch (e) {
      throw DioExceptions.fromDioError(e);
    } catch (e) {
      throw Exception("Failed to update user");
    }
  }
}
