import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:transittrack/core/error/failure.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/my_route/domain/repository/my_route_repository.dart';

class AddBusToMyRouteUsecase extends UseCase<String, AddBusToMyRouteParams> {
  final MyRouteRepository repository;
  AddBusToMyRouteUsecase({required this.repository});
  @override
  Future<Either<Failure, String>> call(AddBusToMyRouteParams params) {
    return repository.addBusToMyRoute(params.busId);
  }
}

class AddBusToMyRouteParams extends Equatable {
  final String busId;
  const AddBusToMyRouteParams({required this.busId});

  @override
  List<Object> get props => [busId];
}
