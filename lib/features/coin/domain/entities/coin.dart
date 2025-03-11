import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  const Coin({
    required this.id,
    required this.name,
    required this.price,
    required this.symbol,
    required this.iconAddress,
    required this.isFavorite,
    
  });

  final int id;
  final String name;
  final num price;
  final String symbol;
  final String iconAddress;
  final bool isFavorite;

  @override
  List<Object?> get props => [id];
}
