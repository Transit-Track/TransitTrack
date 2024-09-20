import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/domain/entities/place_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PlaceEntity>>> getPlacAutoCompleteSuggestion(
      String input);
  Future<Either<Failure, List<BusEntity>>> getAvailableBuses(
      String startStation, String destinationStation);
  Future<Either<Failure, List<String>>> getNearbyBusStations(String input);
  Future<Either<Failure, LocationEntity>> getDriverLocation(String driverPhoneNumber);
  Future<Either<Failure, List<String>>> getStationNames();
}
