import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../services/token_manager.dart';
import '../../utils/type_def.dart';
import '../asset/asset_controller.dart';

// final dioInstanceProvider = Provider<Dio>((ref) {
//   return Dio();
// });

// final dioClientProvider = Provider<DioClient>((ref) {
//   final dio = ref.watch(dioInstanceProvider);
//   return DioClient(dio);
// });

final authApiProvider = Provider<AuthApi>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return AuthApi(dioClient);
});

class AuthApi {
  final DioClient dioClient;

  AuthApi(this.dioClient);

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // String? deviceId = await PlatformDeviceId.getDeviceId;
    String? deviceId = '';

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return {
        'name': androidInfo.brand,
        'version': androidInfo.version.release,
        'layout': 'Android',
        'description': '${androidInfo.brand} ${androidInfo.model}',
        'ua': deviceId,
        'os': 'Android ${androidInfo.version.release}'
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return {
        'name': 'iOS',
        'version': iosInfo.systemVersion,
        'layout': 'iOS',
        'description': '${iosInfo.name} ${iosInfo.systemVersion}',
        'ua': deviceId,
        'os': 'iOS ${iosInfo.systemVersion}'
      };
    }

    return {
      'name': 'Unknown',
      'version': 'Unknown',
      'layout': 'Unknown',
      'description': 'Unknown device',
      'ua': deviceId,
      'os': 'Unknown'
    };
  }

  Future<Position?> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  FutureEither<Response> signup(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final response = await dioClient.post(
        '/api/auth/signup',
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password
        },
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      return right(response);
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<String> login(String email, String pw) async {
    try {
      final deviceInfo = await _getDeviceInfo();
      final position = await _getCurrentPosition();
      final response = await dioClient.post(
        '/api/auth/login',
        data: {
          "email": email,
          "password": pw,
          "platform": deviceInfo,
          "coords": position != null
              ? {
                  'latitude': position.latitude,
                  'longitude': position.longitude,
                }
              : null,
        },
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );

      final token = response.data['data']['token'];
      if (token != null) {
        await TokenManager.getInstance().then((tm) => tm.saveToken(token));
        return right(token);
      }
      return left(Failure("Invalid response from server"));
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Response> forgotPassword(
    String email,
  ) async {
    try {
      final response = await dioClient.post(
        '/api/auth/forgotPassword',
        data: {
          "email": email,
        },
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      return right(response);
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Response> signUp(
    String email,
    String lastName,
    String firstName,
    String password,
  ) async {
    try {
      final response = await dioClient.post(
        '/api/auth/signup',
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password
        },
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      return right(response);
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Response> resetPassword(String otp, String newPw) async {
    try {
      final response = await dioClient.post(
        '/api/auth/resetPassword',
        data: {"otp": otp, "newPassword": newPw},
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      return right(response);
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Response> confirmAccount(
    String email,
    String token,
    String newPassword,
  ) async {
    try {
      final response = await dioClient.post(
        '/api/auth/confirmAccount',
        data: {"email": email, "token": token, "newPassword": newPassword},
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      return right(response);
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Response> resendOtp(
    String email,
  ) async {
    try {
      final response = await dioClient.post(
        '/api/auth/resendOtp',
        data: {"email": email},
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      return right(response);
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  FutureEither<Response> verifyEmail(String email, String otp) async {
    try {
      final response = await dioClient.post(
        '/api/auth/verify-email',
        data: {"email": email, "otp": otp},
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }),
      );
      return right(response);
    } on DioException catch (e) {
      print(e);
      return left(Failure(DioExceptions.fromDioError(e).toString()));
    } catch (e) {
      print(e);
      return left(Failure(e.toString()));
    }
  }

  Future<void> logout() async {
    await TokenManager.getInstance().then((tm) => tm.clearToken());
  }
}
