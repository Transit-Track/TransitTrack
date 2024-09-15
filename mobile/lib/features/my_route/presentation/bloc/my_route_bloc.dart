import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/core/usecases/usecases.dart';
import 'package:transittrack/features/home/domain/entities/bus_entity.dart';
import 'package:transittrack/features/my_route/domain/usecases/add_bus_to_my_route_usecase.dart';
import 'package:transittrack/features/my_route/domain/usecases/get_my_route_usecase.dart';
import 'package:transittrack/features/my_route/domain/usecases/remove_bus_from_my_route_usecase.dart';

part 'my_route_event.dart';
part 'my_route_state.dart';

class MyRouteBloc extends Bloc<MyRouteEvent, MyRouteState> {
  final GetMyRouteUsecase getMyRouteUsecase;
  final AddBusToMyRouteUsecase addBusToMyRouteUsecase;
  final RemoveBusFromMyRouteUsecase removeBusFromMyRouteUsecase;

  MyRouteBloc({
    required this.addBusToMyRouteUsecase,
    required this.getMyRouteUsecase,
    required this.removeBusFromMyRouteUsecase,
  }) : super(MyRouteInitial()) {
    on<GetMyRouteEvent>(_getMyRoute);
    on<AddBusToMyRouteEvent>(_addBusToMyRoute);
    on<RemoveBusToMyRouteEvent>(_removeBusFromMyRoute);
  }

  void _getMyRoute(GetMyRouteEvent event, Emitter<MyRouteState> emit) async {
    emit(GetMyRouteLoadingState());
    final response = await getMyRouteUsecase(NoParams());
    response.fold(
      (failure) =>
          emit(GetMyRouteErrorState(errorMessage: failure.errorMessage)),
      (buses) => emit(GetMyRouteLoadedState(buses: buses)),
    );
  }

  void _addBusToMyRoute(
      AddBusToMyRouteEvent event, Emitter<MyRouteState> emit) async {
    emit(AddBusToMyRouteLoadingState());
    final response =
        await addBusToMyRouteUsecase(AddBusToMyRouteParams(busId: event.busId));
    response.fold(
      (failure) =>
          emit(AddBusToMyRouteErrorState(errorMessage: failure.errorMessage)),
      (successMessage) =>
          emit(AddBusToMyRouteLoadedState(successMessage: successMessage)),
    );
  }

  void _removeBusFromMyRoute(
      RemoveBusToMyRouteEvent event, Emitter<MyRouteState> emit) async {
    emit(RemoveBusFromMyRouteLoadingState());
    final response = await removeBusFromMyRouteUsecase(
        RemoveBusFromMyRouteParams(busId: event.busId));
    response.fold(
      (failure) => emit(
          RemoveBusFromMyRouteErrorState(errorMessage: failure.errorMessage)),
      (successMessage) =>
          emit(RemoveBusFromMyRouteLoadedState(successMessage: successMessage)),
    );
  }
}
