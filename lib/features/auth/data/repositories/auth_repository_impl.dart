import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/storage/secure_storage.dart';
import 'package:aban_tether_challenge/core/utils/network_utils.dart';
import 'package:aban_tether_challenge/core/utils/repository_utils.dart';
import 'package:aban_tether_challenge/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:aban_tether_challenge/features/auth/domain/entities/user.dart';
import 'package:aban_tether_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.secureStorage,
  });
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final SecureStorage secureStorage;

  @override
  Future<Either<Failure, String>> fetchToken(String email, String password) async {
    return requestToServer(
      await networkInfo.hasConnection,
      () async {
        final authToken = await remoteDataSource.fetchToken(email, password);
        await secureStorage.saveToken(authToken);
        return authToken;
      },
    );
  }

  @override
  Future<Either<Failure, User>> addUserPhoneNumber(String phoneNumber) async {
    return requestToServer(
      await networkInfo.hasConnection,
      () => remoteDataSource.addUserPhoneNumber(phoneNumber),
    );
  }

  @override
  Future<Either<Failure, User>> fetchUserInfo() async {
    return requestToServer(
      await networkInfo.hasConnection,
      () => remoteDataSource.fetchUserInfo(),
    );
  }
}
