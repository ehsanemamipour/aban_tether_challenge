import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class GetUserInfoEvent extends AuthEvent {
  const GetUserInfoEvent();
}

class AddUserPhoneEvent extends AuthEvent {
  const AddUserPhoneEvent({required this.phone});
  final String phone;

  @override
  List<Object> get props => [phone];
}
