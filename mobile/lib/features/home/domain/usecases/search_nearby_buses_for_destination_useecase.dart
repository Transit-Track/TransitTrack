import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class SearchNearbyBusesForDestinationUsecase
    extends UseCase<List<String>, SearchNearbyBusesForDestinationParams> {
  final HomeRepository repository;

  SearchNearbyBusesForDestinationUsecase({required this.repository});
  @override
  Future<Either<Failure, List<String>>> call(
      SearchNearbyBusesForDestinationParams params) {
    return repository.getNearbyBusStations(
        params.input);
  }
}

class SearchNearbyBusesForDestinationParams extends Equatable {
  final String input;

  const SearchNearbyBusesForDestinationParams(
      {required this.input,
      });

  @override
  List<Object?> get props => [input];
}
