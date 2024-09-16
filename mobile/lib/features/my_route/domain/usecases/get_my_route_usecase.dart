import 'package:dartz/dartz.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/my_route/domain/repository/my_route_repository.dart';

class GetMyRouteUsecase extends UseCase<List<BusEntity>, NoParams> {
  final MyRouteRepository repository;
  GetMyRouteUsecase({required this.repository});
  @override
  Future<Either<Failure, List<BusEntity>>> call(NoParams params) {
    return repository.getMyRoute();
  }
}
