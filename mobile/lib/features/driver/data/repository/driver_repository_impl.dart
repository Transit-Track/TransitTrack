import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/network/network.dart';
import 'package:transittrack/features/authentication/data/data_sources/auth_local_datasource.dart';
import 'package:transittrack/features/driver/data/datasource/driver_remote_data_source.dart';
import 'package:transittrack/features/driver/domain/repository/driver_repository.dart';

class DriverRepositoryImpl implements DriverRepository {
  final DriverRemoteDataSource remoteDataSource;
  final AuthenticationLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DriverRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> updateDriverLocation({
    required double latitude,
    required double longitude,
  }) async {
    final token = await localDataSource.getToken();
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.updateDriverLocation(
            latitude: latitude, longitude: longitude, token: token!);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getNextRoute({required int busId}) async {
    if (await networkInfo.isConnected) {
      final user = await localDataSource.getUserCredentials();
      try {
        final response = await remoteDataSource.getNextRoute(busId: busId);
        return Right(response);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
