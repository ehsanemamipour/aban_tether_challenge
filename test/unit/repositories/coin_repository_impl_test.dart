import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/errors/exceptions.dart';
import 'package:aban_tether_challenge/core/utils/network_utils.dart';
import 'package:aban_tether_challenge/features/coin/data/datasource/coin_remote_datasource.dart';
import 'package:aban_tether_challenge/features/coin/data/models/coin_model.dart';
import 'package:aban_tether_challenge/features/coin/data/repositories/coin_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'coin_repository_impl_test.mocks.dart';

@GenerateMocks([CoinRemoteDataSource, NetworkInfo])
void main() {
  late CoinRepositoryImpl repository;
  late MockCoinRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockCoinRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CoinRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final coins = [
    const CoinModel(
      id: 3,
      name: 'Etherium',
      price: 2767,
      symbol: 'ETH',
      iconAddress: 'https://abantether.com/media/coin-icon/ETH.svg',
      isFavorite: false,
    )
  ];

  group('fetchCoins', () {
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCoinList()).thenAnswer((_) async => coins);

      // Act
      repository.getCoinList();

      // Assert
      verify(mockNetworkInfo.hasConnection);
    });

    test('should return remote data when the call to remote data source is successful', () async {
      // Arrange
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCoinList()).thenAnswer((_) async => coins);

      // Act
      final result = await repository.getCoinList();

      // Assert
      verify(mockRemoteDataSource.getCoinList());
      expect(result, equals(Right(coins)));
    });

    test('should return server failure when the call to remote data source is unsuccessful', () async {
      // Arrange
      when(mockNetworkInfo.hasConnection).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getCoinList()).thenThrow(const ServerException(message: 'Server Error'));

      // Act
      final result = await repository.getCoinList();

      // Assert
      verify(mockRemoteDataSource.getCoinList());
      expect(result, equals(const Left(ServerFailure(message: 'Server Error'))));
    });
  });
}
