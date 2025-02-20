import 'package:book_app_m2m/values.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'services/token_manager.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      // ..interceptors.add(DioInterceptor())
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.followRedirects = true
      ..options.responseType = ResponseType.json;

    // Adding Interceptors
    // Adding Interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Retrieve token asynchronously
          final tokenManager = await TokenManager.getInstance();
          final token = tokenManager.getToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options); // Proceed with request
        },
        onResponse: (response, handler) {
          return handler.next(response); // Pass response
        },
        onError: (DioException error, handler) async {
          // Handle token expiration (401 Unauthorized)
          if (error.response?.statusCode == 401) {
            final tokenManager = await TokenManager.getInstance();
            await tokenManager.clearToken(); // Clear expired token

            // Handle navigation or re-authentication logic
            // navigatorKey.currentState?.pushReplacementNamed('/login');

            // You might also retry the request after re-authentication here
          }

          return handler.next(error); // Pass error to caller
        },
      ),
    );
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

      // Put:-----------------------------------------------------------------------
    Future<Response> put(
      String url, {
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
    }) async {
      try {
        final Response response = await _dio.put(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );
        return response;
      } catch (e) {
        rethrow;
      }
    }


  // Patch:-----------------------------------------------------------------------
  Future<Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

// Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Download:----------------------------------------------------------------------
  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    void Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    dynamic data,
    Options? options,
  }) async {
    try {
      final Response response = await _dio.download(urlPath, savePath,
          onReceiveProgress: onReceiveProgress,
          queryParameters: queryParameters,
          cancelToken: cancelToken,
          data: data,
          options: options);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Delete:-----------------------------------------------------------------------
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        // onSendProgress: onSendProgress,
        // onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

// class DioInterceptor extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     // ... your existing code
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     // ... your existing code (if any)
//   }

//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) async {
//     print(err);
//     if (err.response?.statusCode == 401) {
//       try {
//         // Attempt to refresh the token
//         var newToken =
//             await refreshToken(); // Replace with your actual token refresh logic
//         Global.storageService.setString('accessToken', newToken);
//         // Retry the request with the new token
//         RequestOptions options = err.response!.requestOptions;
//         options.headers['Authorization'] = 'Bearer $newToken';
//         handler.resolve(await Dio().request(options.path, options: Options()));
//       } catch (error) {
//         // Handle any errors during token refresh
//         print('Error refreshing token: $error');

//         // Redirect to login screen or handle unauthorized request appropriately
//         // ...
//       }
//     } else {
//       super.onError(err, handler);
//     }
//   }
// }

// Replace this with your actual token refresh logic, including necessary calls to your server
// Future<String> refreshToken() async {
//   final password = Global.storageService.getString('password');
//   final email = Global.storageService.getString('email');
//   // Make a request to your server to refresh the token
//   // ...
//   print('$email $password');
//   var refreshResponse = await Dio().post(
//     '${Endpoints.baseUrl}Auth-Operation/login/',
//     data: {'email': email, 'password': password},
//   );
//   print(refreshResponse);

//   return refreshResponse
//       .data['access_token']; // Assuming the server returns a new token
// }
