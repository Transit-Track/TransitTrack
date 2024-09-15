import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';

abstract class MyRouteRepository {
  Future<Either<Failure, List<BusEntity>>> getMyRoute();
  Future<Either<Failure, String>> addBusToMyRoute(String busId);
  Future<Either<Failure, String>> removeBusFromMyRoute(String busId);
}
