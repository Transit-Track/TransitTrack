import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/entities/nearby.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class SearchNearbyBusesUsecase
    extends UseCase<List<NearByEntity>, SearchNearbyBusesParams> {
  final HomeRepository repository;

  SearchNearbyBusesUsecase({required this.repository});
  @override
  Future<Either<Failure, List<NearByEntity>>> call(
      SearchNearbyBusesParams params) {
    return repository.getNearbyBusStations(
        params.input, params.longitude, params.latitude, params.radius);
  }
}

class SearchNearbyBusesParams extends Equatable {
  final String input;
  final double longitude;
  final double latitude;
  final double radius;

  const SearchNearbyBusesParams(
      {required this.input,
      required this.longitude,
      required this.latitude,
      required this.radius});

  @override
  List<Object?> get props => [input, longitude, latitude, radius];
}
