import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/utils/network_utils.dart';
import 'package:aban_tether_challenge/core/utils/repository_utils.dart';
import 'package:aban_tether_challenge/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:aban_tether_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String>> fetchToken(String email, String password) async {
    return requestToServer(
      await networkInfo.hasConnection,
      () => remoteDataSource.fetchToken(email, password),
    );
  }
}
