import 'package:aban_tether_challenge/core/consts/consts.dart';
import 'package:aban_tether_challenge/core/errors/exceptions.dart';
import 'package:aban_tether_challenge/core/services/http_service.dart';
import 'package:aban_tether_challenge/features/coin/data/models/coin_model.dart';

abstract class AuthRemoteDataSource {
  Future<List<CoinModel>> fetchCoinList();
  Future<void> addCoinToFavorite(int id);
  Future<void> deleteCoinFromFavorite(int id);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required this.httpService});
  final HTTPService httpService;

  @override
  Future<List<CoinModel>> fetchCoinList() async {
    try {
      final result = await httpService.getData(ServerPaths.coinList);

      List<dynamic> data = result.body;
      var coins = data.map((coin) => CoinModel.fromJson(coin)).toList();

      return coins;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> addCoinToFavorite(int id) async {
    try {
      await httpService.postData(ServerPaths.favoriteCoin, data: {
        'cryptocurrency_id': id,
      });
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteCoinFromFavorite(int id) async {
    try {
      await httpService.deleteData(ServerPaths.favoriteCoin + id.toString());
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
