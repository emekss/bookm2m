import 'dart:convert';
import 'dart:io';

import 'package:book_app_m2m/models/full_user_model.dart';
import 'package:book_app_m2m/services/token_manager.dart';
import 'package:book_app_m2m/utils/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final TokenManager _tokenManager;

  FullUserModel? _loggedInUser;
  FullUserModel? get user => _loggedInUser;

  // Make constructor take SharedPreferences instance
  AuthService(this._tokenManager);

  // Static method to initialize AuthService
  static Future<AuthService> init() async {
    return AuthService(await TokenManager.getInstance());
  }

  bool isLoggedIn() {
    final token = _tokenManager.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, dynamic>> logout({String? accountId}) async {
    try {
      // Build the URL with optional accountId
      var uri = Uri.parse('$baseUrl/api/auth/logout');
      if (accountId != null) {
        uri = uri.replace(queryParameters: {'accountId': accountId});
      }

      // Get the stored token
      final token = _tokenManager.getToken();

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Add token to headers
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Clear the stored token after successful logout
        await _tokenManager.clearToken();
        _loggedInUser = null;

        return {
          'success': true,
          'message':
              responseData['message'] ?? 'You have logged out successfully',
        };
      } else if (response.statusCode == 500) {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Internal server error',
        };
      } else {
        return {
          'success': false,
          'message': 'Something went wrong. Please try again later.',
        };
      }
    } catch (e) {
      print('Logout Error: $e');
      return {
        'success': false,
        'message':
            'Unable to connect to the server. Please check your internet connection.',
      };
    }
  }

  Future<Map<String, dynamic>> getUserDetails() async {
    try {
      final token = _tokenManager.getToken();
      if (token == null) {
        return {
          'success': false,
          'message': 'No authentication token found. Sign in again.',
        };
      }

      final response = await http.get(
        Uri.parse('$baseUrl/api/users/me'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': responseData['data']['user'],
        };
      } else {
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch user details',
        };
      }
    } catch (e) {
      print('Get User Details Error: $e');
      return {
        'success': false,
        'message':
            'Unable to connect to the server. Please check your internet connection.',
      };
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      // Log the request payload
      final requestBody = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      };
      print('Signup request payload: $requestBody');

      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Signup response status: ${response.statusCode}'); // Debug log
      print('Signup response body: ${response.body}'); // Debug log

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'],
          'userId': responseData['userId'],
        };
      } else if (response.statusCode == 400) {
        final String errorMessage = responseData['message'] ??
            'This email is already registered. Please try signing in instead.';
        print('Signup error 400: $errorMessage'); // Debug log
        return {
          'success': false,
          'message': errorMessage,
        };
      } else if (response.statusCode == 422) {
        // Improve error message parsing
        final Map<String, dynamic> errors = responseData['data'] ?? {};
        String errorMessage = 'Please check your information:';
        errors.forEach((key, value) {
          if (value is Map) {
            errorMessage += '\n• ${value['msg'] ?? 'Invalid $key'}';
          } else {
            errorMessage += '\n• $value';
          }
        });
        print('Formatted error message: $errorMessage');
        return {
          'success': false,
          'message': errorMessage,
        };
      } else {
        return {
          'success': false,
          'message': 'Unable to create account. Please try again.',
        };
      }
    } catch (e) {
      print('SignUp Error: $e'); // Debug log
      return {
        'success': false,
        'message':
            'Unable to connect to the server. Please check your internet connection.',
      };
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Get device info
      final deviceInfo = await _getDeviceInfo();

      // Get location
      final position = await _getCurrentPosition();

      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'platform': deviceInfo,
          'coords': position != null
              ? {
                  'latitude': position.latitude,
                  'longitude': position.longitude,
                }
              : null,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Save token locally
        await _tokenManager.saveToken(responseData['data']['token']);

        _loggedInUser = FullUserModel.fromMap(responseData['data']['user']);

        return {
          'success': true,
          'message': 'Login successful',
          'user': _loggedInUser!.toMap(),
          'token': responseData['data']['token'],
        };
      } else if (response.statusCode == 400) {
        print('Login Error: ${response.body}');
        return {
          'success': false,
          'message': response.body,
        };
      } else if (response.statusCode == 422) {
        return {
          'success': false,
          'message': 'Please enter a valid email and password.',
        };
      } else {
        return {
          'success': false,
          'message': 'Something went wrong. Please try again later.',
        };
      }
    } catch (e) {
      print('Login Error: $e');
      return {
        'success': false,
        'message':
            'Unable to connect to the server. Please check your internet connection.',
      };
    }
  }

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

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/verify-email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'otp': otp,
        }),
      );
      print('Verification URL: ${Uri.parse('$baseUrl/api/auth/verify-email')}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          return {
            'success': true,
            'message':
                responseData['message'] ?? 'Email successfully verified.',
          };
        case 400:
          return {
            'success': false,
            'message': responseData['message'] ?? 'Invalid OTP',
          };
        case 404:
          return {
            'success': false,
            'message': responseData['message'] ?? 'User not found',
          };
        case 408:
          return {
            'success': false,
            'message': responseData['message'] ?? 'OTP expired',
          };
        case 409:
          return {
            'success': false,
            'message': responseData['message'] ?? 'Email already verified',
          };
        default:
          return {
            'success': false,
            'message': 'Something went wrong. Please try again later.',
          };
      }
    } catch (e) {
      print('Verification Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/resetPassword'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'Password reset successfully',
        };
      } else if (response.statusCode == 400) {
        final errors = responseData['errors'] as List?;
        if (errors != null && errors.isNotEmpty) {
          return {
            'success': false,
            'message': errors.first['msg'] ?? 'Invalid input',
          };
        }
        return {
          'success': false,
          'message': responseData['message'] ?? 'Invalid request',
        };
      } else if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'User not found',
        };
      } else {
        return {
          'success': false,
          'message': 'Something went wrong. Please try again later.',
        };
      }
    } catch (e) {
      print('Reset Password Error: $e');
      return {
        'success': false,
        'message':
            'Unable to connect to the server. Please check your internet connection.',
      };
    }
  }

  Future<Map<String, dynamic>> resendOtp({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/resendOtp'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        }),
      );

      final responseData = jsonDecode(response.body);

      switch (response.statusCode) {
        case 200:
          return {
            'success': true,
            'message': responseData['message'] ??
                'A OTP has been sent. Please check your email.',
          };
        case 400:
          return {
            'success': false,
            'message': responseData['message'] ?? 'Email already verified.',
          };
        case 404:
          return {
            'success': false,
            'message': responseData['message'] ?? 'User not found.',
          };
        case 500:
          return {
            'success': false,
            'message': responseData['message'] ?? 'Internal server error.',
          };
        default:
          return {
            'success': false,
            'message': 'Something went wrong. Please try again later.',
          };
      }
    } catch (e) {
      print('Resend OTP Error: $e');
      return {
        'success': false,
        'message':
            'Unable to connect to the server. Please check your internet connection.',
      };
    }
  }

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/auth/forgotPassword'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': responseData['message'] ?? 'OTP sent to your email',
        };
      } else if (response.statusCode == 400) {
        final errors = responseData['errors'] as List?;
        if (errors != null && errors.isNotEmpty) {
          return {
            'success': false,
            'message': 'Please enter a valid email address',
          };
        }
        return {
          'success': false,
          'message': 'Invalid request. Please try again.',
        };
      } else if (response.statusCode == 404) {
        return {
          'success': false,
          'message': 'No account found with this email address',
        };
      } else if (response.statusCode == 500) {
        return {
          'success': false,
          'message':
              'Unable to send OTP at the moment. Please try again later.',
        };
      } else {
        return {
          'success': false,
          'message': 'Something went wrong. Please try again later.',
        };
      }
    } catch (e) {
      print('Forgot Password Error: $e');
      return {
        'success': false,
        'message':
            'Unable to connect to the server. Please check your internet connection.',
      };
    }
  }
}
