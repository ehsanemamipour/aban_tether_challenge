import 'package:aban_tether_challenge/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class GetTokenState extends AuthState {
  const GetTokenState({required this.token});
  final String token;
  @override
  List<Object> get props => [token];
}

class GetUserState extends AuthState {
  const GetUserState({required this.user});
  final User user;
  @override
  List<Object> get props => [user];
}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  const AuthError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
