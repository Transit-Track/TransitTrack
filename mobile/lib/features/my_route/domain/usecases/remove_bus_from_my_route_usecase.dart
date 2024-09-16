import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/my_route/domain/repository/my_route_repository.dart';

class RemoveBusFromMyRouteUsecase
    extends UseCase<String, RemoveBusFromMyRouteParams> {
  final MyRouteRepository repository;
  RemoveBusFromMyRouteUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(RemoveBusFromMyRouteParams params) {
    return repository.removeBusFromMyRoute(params.busId);
  }
}

class RemoveBusFromMyRouteParams extends Equatable {
  final String busId;
  const RemoveBusFromMyRouteParams({required this.busId});

  @override
  List<Object> get props => [busId];
}
