import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/utils/usecase_utils.dart';
import 'package:aban_tether_challenge/features/auth/domain/entities/user.dart';
import 'package:aban_tether_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class FetchUserInfo implements UseCase<User, NoParams> {
  FetchUserInfo({required this.repository});
  final CoinRepository repository;

  @override
  Future<Either<Failure, User>> call(params) {
    return repository.fetchUserInfo();
  }
}
