import 'package:aban_tether_challenge/core/storage/secure_storage.dart';
import 'package:dio/dio.dart';

abstract class HTTPService<T> {
  Future<T> getData(String url, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? header});
  Future<T> postData(String url, {dynamic data, Map<String, dynamic>? header});
  Future<T> putData(String url, {Map<String, dynamic>? data, Map<String, dynamic>? header});
  Future<T> deleteData(String url, {Map<String, dynamic>? data, Map<String, dynamic>? header});
}

class DioService implements HTTPService {
  DioService({required this.dio, required this.secureStorage}) {
    _initializeInterceptors();
  }

  String token = '';
  final Dio dio;
  final SecureStorage secureStorage;

  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await secureStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            await secureStorage.deleteToken();
          }
          return handler.next(e);
        },
      ),
    );
  }

  @override
  Future<Response> getData(String url,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? header}) async {
    return dio.get(url, queryParameters: queryParameters, options: Options(headers: header));
  }

  @override
  Future<Response> postData(String url, {dynamic data, Map<String, dynamic>? header}) {
    return dio.post(url, data: data, options: Options(headers: header));
  }

  @override
  Future putData(String url, {Map<String, dynamic>? data, Map<String, dynamic>? header}) {
    return dio.put(url, data: data, options: Options(headers: header));
  }

  @override
  Future deleteData(String url, {Map<String, dynamic>? data, Map<String, dynamic>? header}) {
    return dio.delete(url, data: data, options: Options(headers: header));
  }
}
