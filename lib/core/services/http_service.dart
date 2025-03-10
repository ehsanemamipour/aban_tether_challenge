import 'package:dio/dio.dart';

abstract class HTTPService<T> {
  void setToken(String token);
  String getToken();
  Future<T> getData(String url,
      {Map<String, dynamic>? queryParameters, Map<String, dynamic>? header});
  Future<T> postData(String url, {dynamic data, Map<String, dynamic>? header});
  Future<T> patchData(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? header});
}

class DioService implements HTTPService {
  DioService({required this.dio});

  String token = '';
  final Dio dio;
  @override
  void setToken(String token) => this.token = 'Token $token';
  @override
  String getToken() => token;
  @override
  Future<Response> getData(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? header}) async {
    return dio.get(url,
        queryParameters: queryParameters, options: Options(headers: header));
  }

  @override
  Future<Response> postData(String url,
      {dynamic data, Map<String, dynamic>? header}) {
    return dio.post(url, data: data, options: Options(headers: header));
  }

  @override
  Future patchData(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? header}) {
    return dio.patch(url, data: data, options: Options(headers: header));
  }
}