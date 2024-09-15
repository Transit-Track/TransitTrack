part of 'my_route_bloc.dart';

sealed class MyRouteState extends Equatable {
  const MyRouteState();

  @override
  List<Object> get props => [];
}

final class MyRouteInitial extends MyRouteState {}

// get my route
final class GetMyRouteLoadingState extends MyRouteState {}

final class GetMyRouteLoadedState extends MyRouteState {
  final List<BusEntity> buses;
  const GetMyRouteLoadedState({
    required this.buses,
  });
}

final class GetMyRouteErrorState extends MyRouteState {
  final String errorMessage;
  const GetMyRouteErrorState({
    required this.errorMessage,
  });
}

// add bus to my route
final class AddBusToMyRouteLoadingState extends MyRouteState {}

final class AddBusToMyRouteLoadedState extends MyRouteState {
  final String successMessage;
  const AddBusToMyRouteLoadedState({
    required this.successMessage,
  });
}

final class AddBusToMyRouteErrorState extends MyRouteState {
  final String errorMessage;
  const AddBusToMyRouteErrorState({
    required this.errorMessage,
  });
}

// remove bus from my route
final class RemoveBusFromMyRouteLoadingState extends MyRouteState {}

final class RemoveBusFromMyRouteLoadedState extends MyRouteState {
  final String successMessage;
  const RemoveBusFromMyRouteLoadedState({
    required this.successMessage,
  });
}

final class RemoveBusFromMyRouteErrorState extends MyRouteState {
  final String errorMessage;
  const RemoveBusFromMyRouteErrorState({
    required this.errorMessage,
  });
}
