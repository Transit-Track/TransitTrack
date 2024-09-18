import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class SearchNearbyBusesForStartUsecase
    extends UseCase<List<String>, SearchNearbyBusesForStartParams> {
  final HomeRepository repository;

  SearchNearbyBusesForStartUsecase({required this.repository});
  @override
  Future<Either<Failure, List<String>>> call(
      SearchNearbyBusesForStartParams params) {
    return repository.getNearbyBusStations(
        params.input);
  }
}

class SearchNearbyBusesForStartParams extends Equatable {
  final String input;

  const SearchNearbyBusesForStartParams(
      {required this.input,
      });

  @override
  List<Object?> get props => [input];
}
