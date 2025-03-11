import 'package:equatable/equatable.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

class CoinInitial extends CoinState {}

class GetTokenState extends CoinState {
  const GetTokenState({required this.token});
  final String token;
  @override
  List<Object> get props => [token];
}

class CoinLoaded extends CoinState {
  const CoinLoaded({required this.coin});
  final List coin;
  @override
  List<Object> get props => [coin];
}

class CoinLoading extends CoinState {}

class CoinError extends CoinState {
  const CoinError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
