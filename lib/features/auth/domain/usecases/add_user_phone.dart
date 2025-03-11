import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/utils/usecase_utils.dart';
import 'package:aban_tether_challenge/features/auth/domain/entities/user.dart';
import 'package:aban_tether_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddUserPhone implements UseCase<User, AddUserPhoneParams> {
  AddUserPhone({required this.repository});
  final AuthRepository repository;

  @override
  Future<Either<Failure, User>> call(params) {
    return repository.addUserPhoneNumber(params.phone);
  }
}

class AddUserPhoneParams extends Equatable {
  const AddUserPhoneParams({required this.phone});
  final String phone;

  @override
  List<Object?> get props => [phone];
}