import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';

import '../../dio_client.dart';
import '../../dio_exception.dart';
import '../../services/token_manager.dart';
import '../../utils/constants.dart';
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

  Future<void> logout() async {
    await TokenManager.getInstance().then((tm) => tm.clearToken());
  }
}
