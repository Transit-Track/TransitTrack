part of 'my_route_bloc.dart';

sealed class MyRouteEvent extends Equatable {
  const MyRouteEvent();

  @override
  List<Object> get props => [];
}

final class GetMyRouteEvent extends MyRouteEvent {}

final class AddBusToMyRouteEvent extends MyRouteEvent {
  final String busId;

  const AddBusToMyRouteEvent({required this.busId});

  @override
  List<Object> get props => [busId];
}

final class RemoveBusToMyRouteEvent extends MyRouteEvent {
  final String busId;

  const RemoveBusToMyRouteEvent({required this.busId});

  @override
  List<Object> get props => [busId];
}
