import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/utils/network_utils.dart';
import 'package:aban_tether_challenge/core/utils/repository_utils.dart';
import 'package:aban_tether_challenge/features/coin/data/datasource/coin_remote_datasource.dart';
import 'package:aban_tether_challenge/features/coin/domain/entities/coin.dart';
import 'package:aban_tether_challenge/features/coin/domain/repositories/coin_repository.dart';
import 'package:dartz/dartz.dart';

class CoinRepositoryImpl extends CoinRepository {
  CoinRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final CoinRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<Coin>>> getCoinList() async {
    return requestToServer(
      await networkInfo.hasConnection,
      () => remoteDataSource.getCoinList(),
    );
  }

  @override
  Future<Either<Failure, void>> addCoinTofavorite(int id) async {
    return requestToServer(
      await networkInfo.hasConnection,
      () => remoteDataSource.addCoinToFavorite(id),
    );
  }

  @override
  Future<Either<Failure, void>> deleteCoinFromFavorite(int id) async {
    return requestToServer(
      await networkInfo.hasConnection,
      () async {
        var list = await remoteDataSource.getFavoriteCoinList();

        for (var element in list) {
          if (element.cryptocurrencyId == id) {
            return remoteDataSource.deleteCoinFromFavorite(element.id);
          }
        }
      },
    );
  }
}
