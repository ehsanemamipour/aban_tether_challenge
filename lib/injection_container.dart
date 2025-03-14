import 'package:aban_tether_challenge/core/services/http_service.dart';
import 'package:aban_tether_challenge/core/storage/secure_storage.dart';
import 'package:aban_tether_challenge/core/utils/network_utils.dart';
import 'package:aban_tether_challenge/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:aban_tether_challenge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:aban_tether_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:aban_tether_challenge/features/auth/domain/usecases/add_user_phone.dart';
import 'package:aban_tether_challenge/features/auth/domain/usecases/fetch_token.dart';
import 'package:aban_tether_challenge/features/auth/domain/usecases/fetch_user_info.dart';
import 'package:aban_tether_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:aban_tether_challenge/features/coin/data/datasource/coin_remote_datasource.dart';
import 'package:aban_tether_challenge/features/coin/data/repositories/coin_repository_impl.dart';
import 'package:aban_tether_challenge/features/coin/domain/repositories/coin_repository.dart';
import 'package:aban_tether_challenge/features/coin/domain/usecases/add_coin_to_favorite.dart';
import 'package:aban_tether_challenge/features/coin/domain/usecases/delete_coin_from_favorite.dart';
import 'package:aban_tether_challenge/features/coin/domain/usecases/fetch_coin_list.dart';
import 'package:aban_tether_challenge/features/coin/presentation/bloc/coin_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  _injectExternalLibraries();
  _injectSystemStatus();
  _injectLogin();
  _injectCoin();
}

void _injectLogin() {
  //bloc
  serviceLocator.registerFactory(() => AuthBloc(
        fetchToken: serviceLocator(),
        fetchUserInfo: serviceLocator(),
        addUserPhone: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => SecureStorage());
  //usecase
  serviceLocator.registerLazySingleton(() => FetchToken(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => FetchUserInfo(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AddUserPhone(repository: serviceLocator()));

  //repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
      secureStorage: serviceLocator(),
    ),
  );
  //datasources
  serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(httpService: serviceLocator()),
  );
}

void _injectCoin() {
  //bloc
  serviceLocator.registerFactory(() => CoinBloc(
        fetchCoinList: serviceLocator(),
        addCoinToFavorite: serviceLocator(),
        deleteCoinFromFavorite: serviceLocator(),
      ));
  //usecase
  serviceLocator.registerLazySingleton(() => AddCoinToFavorite(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteCoinFromFavorite(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => FetchCoinList(repository: serviceLocator()));

  //repositories
  serviceLocator.registerLazySingleton<CoinRepository>(
    () => CoinRepositoryImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
    ),
  );
  //datasources
  serviceLocator.registerLazySingleton<CoinRemoteDataSource>(
    () => CoinRemoteDataSourceImpl(httpService: serviceLocator()),
  );
}

void _injectExternalLibraries() {
  serviceLocator.registerLazySingleton<HTTPService>(
    () => DioService(
      dio: Dio(),
      secureStorage: serviceLocator(),
    ),
  );
  //Data Connection Checker
  serviceLocator.registerLazySingleton(() => Connectivity());
}

void _injectSystemStatus() {
  // system Statuses
  serviceLocator
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(dataConnectionChecker: serviceLocator()));
}
