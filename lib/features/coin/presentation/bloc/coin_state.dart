import 'package:aban_tether_challenge/features/coin/domain/entities/coin.dart';
import 'package:equatable/equatable.dart';

abstract class CoinState extends Equatable {
  const CoinState();

  @override
  List<Object> get props => [];
}

class CoinInitial extends CoinState {}



class CoinLoaded extends CoinState {
  const CoinLoaded({required this.coins});
  final List<Coin> coins;
  @override
  List<Object> get props => [coins];
}

class CoinLoading extends CoinState {}

class CoinFavoriteSuccess extends CoinState {}
class CoinError extends CoinState {
  const CoinError({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
