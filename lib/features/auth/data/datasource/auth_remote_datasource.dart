import 'package:aban_tether_challenge/core/consts/consts.dart';
import 'package:aban_tether_challenge/core/errors/exceptions.dart';
import 'package:aban_tether_challenge/core/services/http_service.dart';

abstract class AuthRemoteDataSource {
  Future<String> fetchToken(String email, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.httpService});
  final HTTPService httpService;
  @override
  Future<String> fetchToken(String email, String password) async {
    try {
      final result =
          await httpService.postData(ServerPaths.login, data: {'email': email, 'password': password});
      return result.data['authToken'];
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
