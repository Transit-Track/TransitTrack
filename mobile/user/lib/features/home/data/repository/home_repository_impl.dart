import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/network/network.dart';
import 'package:transittrack/features/home/data/datasource/remote/google_map_datasource.dart';
import 'package:transittrack/features/home/data/datasource/remote/remote_datasource.dart';
import 'package:transittrack/features/home/data/model/location_model.dart';
import 'package:transittrack/features/home/data/model/nearby_model.dart';
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
         return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Bus>>> getBuses() {
    // TODO: implement getBuses
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<NearByModel>>> getNearbyBusStations(String input, double longitude, double latitude, double radius) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await googleMapDatasource.getNearbyBusStations(input, longitude, latitude, radius);
        return Right(response);
      } catch (e) {
         return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
