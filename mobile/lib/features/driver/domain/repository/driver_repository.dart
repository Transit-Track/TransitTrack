import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';

abstract class DriverRepository {
  Future<Either<Failure, String>> updateDriverLocation({
    required double latitude,
    required double longitude,
  });
}