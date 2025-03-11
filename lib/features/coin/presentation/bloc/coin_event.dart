import 'package:equatable/equatable.dart';

abstract class CoinEvent extends Equatable {
  const CoinEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends CoinEvent {
  const LoginEvent({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class RemoveFavoriteEvent extends CoinEvent {
  const RemoveFavoriteEvent({required this.coinId});
  final int coinId;
}

class AddFavoriteEvent extends CoinEvent {
  const AddFavoriteEvent({required this.coinId});
  final int coinId;
}
