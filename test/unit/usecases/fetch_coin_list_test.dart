import 'package:aban_tether_challenge/core/utils/usecase_utils.dart';
import 'package:aban_tether_challenge/features/coin/data/models/coin_model.dart';
import 'package:aban_tether_challenge/features/coin/domain/repositories/coin_repository.dart';
import 'package:aban_tether_challenge/features/coin/domain/usecases/fetch_coin_list.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_coin_list_test.mocks.dart';

@GenerateMocks([CoinRepository])
void main() {
  late FetchCoinList usecase;
  late MockCoinRepository mockCoinRepository;

  setUp(() {
    mockCoinRepository = MockCoinRepository();
    usecase = FetchCoinList(repository: mockCoinRepository);
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
  test('should fetch memes from repository', () async {
    // Arrange
    when(mockCoinRepository.getCoinList()).thenAnswer((_) async => Right(coins));

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, Right(coins));
    verify(mockCoinRepository.getCoinList());
    verifyNoMoreInteractions(mockCoinRepository);
  });
}
