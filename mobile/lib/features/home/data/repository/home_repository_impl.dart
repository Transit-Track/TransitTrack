import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/network/network.dart';
import 'package:transittrack/features/home/data/datasource/remote/google_map_datasource.dart';
import 'package:transittrack/features/home/data/datasource/remote/remote_datasource.dart';
import 'package:transittrack/features/home/data/model/location_model.dart';
import 'package:transittrack/features/home/domain/entities/bus.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final GoogleMapDatasource googleMapDatasource;
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(
      {required this.googleMapDatasource,
      required this.networkInfo,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<LocationModel>>> getPlacAutoCompleteSuggestion(
      String input) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await googleMapDatasource.getPlacAutoCompleteSuggestion(input);
        return Right(response);
      } catch (e) {
        print('eeeeeeeeeeeeeeeeeeeeeeeeee $e');
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getNearbyBusStations(
     String input) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getNearbyBusStations(
            input);
        return Right(response);
      } catch (e) {
        print('eeeeeeeeeeeeeeeeeeeeeeeeee $e');
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<BusEntity>>> getAvailableBuses(
      String startLocation, String destinationLocation) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getAvailablebuses(
            startLocation, destinationLocation);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, String?>> getPlaceIdFromCoordinates(
      double longitude, double latitude) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await googleMapDatasource.getPlaceIdFromCoordinates(
            longitude, latitude);
        return Right(response);
      } catch (e) {
        print('eeeeeeeeeeeeeeeeeeeeeeeeee $e');
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> arrivalTimePrediction(
      String? startPlaceId, String? destinationPlaceId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await googleMapDatasource.arrivalTimePrediction(
            startPlaceId!, destinationPlaceId!);
        return Right(response);
      } catch (e) {
        print('eeeeeeeeeeeeeeeeeeeeeeeeee $e');
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
  
  @override
  Future<Either<Failure, String>> getDriversLocation(String driverId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getDriversLocation(
            driverId);
        return Right(response);
      } catch (e) {
        print('eeeeeeeeeeeeeeeeeeeeeeeeee $e');
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
