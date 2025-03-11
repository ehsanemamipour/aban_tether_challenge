import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/utils/usecase_utils.dart';
import 'package:aban_tether_challenge/features/coin/domain/entities/coin.dart';
import 'package:aban_tether_challenge/features/coin/domain/repositories/coin_repository.dart';
import 'package:dartz/dartz.dart';

class FetchCoinList implements UseCase<List<Coin>, NoParams> {
  FetchCoinList({required this.repository});
  final CoinRepository repository;

  @override
  Future<Either<Failure, List<Coin>>> call(params) {
    return repository.getCoinList();
  }
}
