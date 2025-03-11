import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/utils/usecase_utils.dart';
import 'package:aban_tether_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class FetchToken implements UseCase<String, FethTokenParams> {
  FetchToken({required this.repository});
  final CoinRepository repository;

  @override
  Future<Either<Failure, String>> call(params) {
    return repository.fetchToken(params.email, params.password);
  }
}

class FethTokenParams extends Equatable {
  const FethTokenParams({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => [email];
}
