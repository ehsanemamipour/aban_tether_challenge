import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/features/coin/domain/entities/coin.dart';
import 'package:dartz/dartz.dart';

abstract class CoinRepository {
  Future<Either<Failure, List<Coin>>> getCoinList();
  Future<Either<Failure, void>> addCoinTofavorite(int id);
  Future<Either<Failure, void>> deleteCoinFromFavorite(int id);
}
