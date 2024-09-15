import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/network/network.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/my_route/data/datasources/my_route_remote_data_source.dart';
import 'package:transittrack/features/my_route/domain/repository/my_route_repository.dart';

class MyRouteRepositoryImpl extends MyRouteRepository {
  final MyRouteRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  MyRouteRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<BusEntity>>> getMyRoute() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getMyRoute();
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addBusToMyRoute(String busId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.addBusToMyRoute(busId);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> removeBusFromMyRoute(String busId) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.removeBusFromMyRoute(busId);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
