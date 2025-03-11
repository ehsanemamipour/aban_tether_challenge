import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> fetchToken(String email, String password);
}
