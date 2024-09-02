import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/home/domain/entities/location.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<LocationEntity>>> getPlacAutoCompleteSuggestion(
      String input);
  Future<Either<Failure, List<BusEntity>>> getAvailableBuses(
      String startStation, String destinationStation);
  Future<Either<Failure, List<String>>> getNearbyBusStations(String input);
  Future<Either<Failure, String>> getDriversLocation(String driverId);

  //!
  Future<Either<Failure, String?>> getPlaceIdFromCoordinates(
      double longitude, double latitude);
  Future<Either<Failure, String?>> arrivalTimePrediction(
      String? startPlaceId, String? destinationPlaceId);
}
