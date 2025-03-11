import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> fetchToken(String email, String password);
  Future<Either<Failure, User>> fetchUserInfo();
  Future<Either<Failure, User>> addUserPhoneNumber( String phoneNumber);
}
