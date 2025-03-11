import 'package:aban_tether_challenge/core/errors/errors.dart';
import 'package:aban_tether_challenge/core/utils/usecase_utils.dart';
import 'package:aban_tether_challenge/features/coin/domain/repositories/coin_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class AddCoinToFavorite implements UseCase<void, AddCoinToFavoriteParams> {
  AddCoinToFavorite({required this.repository});
  final CoinRepository repository;

  @override
  Future<Either<Failure, void>> call(params) {
    return repository.addCoinTofavorite(params.id);
  }
}

class AddCoinToFavoriteParams extends Equatable {
  const AddCoinToFavoriteParams({required this.id});
  final int id;

  @override
  List<Object?> get props => [id];
}
