part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetLocationEvent extends HomeEvent {
  final String input;

  const GetLocationEvent({required this.input});
}

final class GetNearbyBusesEvent extends HomeEvent {
  final String input;
  final double longitude;
  final double latitude;
  final double radius;

  const GetNearbyBusesEvent(
      {required this.input,
      required this.longitude,
      required this.latitude,
      required this.radius});
}
