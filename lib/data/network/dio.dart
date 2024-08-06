import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:education_app/app_router.dart';
import 'package:education_app/common/constants/constants.dart';
import 'package:education_app/data/network/response/auth/tokens_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DioNetwork {
  static Dio provideDio() {
    Dio dio = Dio();

    // Interceptor for jwt
    dio.interceptors.add(NetworkInterceptorJWT(dio: dio));
    return dio;
  }
}

// Interceptor for jwt refresh
class NetworkInterceptorJWT extends Interceptor {
  final Dio dio;

  NetworkInterceptorJWT({required this.dio});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var accessToken = sp.get(Constants.sharedPreferencesKey.accessToken);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // If a 401 response is received, refresh the access token
      SharedPreferences sp = await SharedPreferences.getInstance();
      var refreshToken =
          sp.getString(Constants.sharedPreferencesKey.refreshToken);

      // NOTE:
      // Use HTTP package as the Dio onRequest method is override to use accessToken
      // everytime, so the refreshToken will be overwritten everytime.
      final tokenRes = await http.post(
        Uri.parse('${Constants.apiUrl}auth/refresh'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );
      if (tokenRes.statusCode == 201) {
        // Reresh token success
        TokensResponse token = TokensResponse.fromJson(
            jsonDecode(tokenRes.body) as Map<String, dynamic>);
        // Save new tokens to sp
        sp.setString(
            Constants.sharedPreferencesKey.refreshToken, token.refreshToken);
        sp.setString(
            Constants.sharedPreferencesKey.accessToken, token.accessToken);

        // Update the request header with the new access token
        err.requestOptions.headers['Authorization'] =
            'Bearer ${token.accessToken}';

        // Repeat the request with the updated header
        return handler.resolve(await dio.fetch(err.requestOptions));
      } else {
        // Refresh token failed (expired)
        // Ask user to login
        AppRouter.router.pushNamed('login');
        return;
      }
    }
    return handler.reject(err);
  }
}
