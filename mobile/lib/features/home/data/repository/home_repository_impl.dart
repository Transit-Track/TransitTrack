import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/network/network.dart';
import 'package:transittrack/features/driver/domain/entity/driver_location_entity.dart';
import 'package:transittrack/features/home/data/datasource/remote/google_map_datasource.dart';
import 'package:transittrack/features/home/data/datasource/remote/local_datasource.dart';
import 'package:transittrack/features/home/data/datasource/remote/remote_datasource.dart';
import 'package:transittrack/features/home/data/model/place_model.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final GoogleMapDatasource googleMapDatasource;
  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.googleMapDatasource,
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<PlaceModel>>> getPlacAutoCompleteSuggestion(
      String input) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await googleMapDatasource.getPlacAutoCompleteSuggestion(input);
        return Right(response);
      } catch (e) {
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
        final response = await remoteDataSource.getNearbyBusStations(input);
        return Right(response);
      } catch (e) {
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

  @override
  Future<Either<Failure, LocationEntity>> getDriverLocation(
      String driverPhoneNumber) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDataSource.getDriverLocation(driverPhoneNumber);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getStationNames() async {
    // if (await localDataSource.getStationNames() != null) {
    //   final response = await localDataSource.getStationNames();
    //   return Right(response);
    // } else
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getStationNames();
        // await localDataSource.saveStationNames(response);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
