import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/home/domain/entities/location.dart';
import 'package:transittrack/features/home/domain/entities/nearby.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<LocationEntity>>> getPlacAutoCompleteSuggestion(String input );
  Future<Either<Failure, List<Bus>>> getBuses();
  Future<Either<Failure, List<NearByEntity>>> getNearbyBusStations(String input, double longitude, double latitude, double radius);
}
