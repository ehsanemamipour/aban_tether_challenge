import 'package:aban_tether_challenge/core/consts/consts.dart';
import 'package:aban_tether_challenge/core/errors/exceptions.dart';
import 'package:aban_tether_challenge/core/services/http_service.dart';
import 'package:aban_tether_challenge/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> fetchToken(String email, String password);
  Future<UserModel> fetchUserInfo();
  Future<UserModel> addUserPhoneNumber(String phoneNumber);
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

  @override
  Future<UserModel> fetchUserInfo() async {
    try {
      final result = await httpService.getData(ServerPaths.userInfo);

      var user = UserModel.fromJson(result.data);

      return user;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> addUserPhoneNumber(String phoneNumber) async {
    try {
      final result = await httpService.putData(ServerPaths.userPhoneNumber, data: {
        'phone_number': phoneNumber,
      });

      var user = UserModel.fromJson(result.data);

      return user;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
