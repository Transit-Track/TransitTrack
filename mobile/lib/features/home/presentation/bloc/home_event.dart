part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class GetAvailableBusesEvent extends HomeEvent {
  final String startStation;
  final String destinationStation;

  const GetAvailableBusesEvent(
      {required this.startStation, required this.destinationStation});
}

final class GetArrivalTime extends HomeEvent {
  final String? startPlaceId;
  final String? destinationPlaceId;

  const GetArrivalTime({
    required this.startPlaceId,
    required this.destinationPlaceId,
  });
}

final class GetDriverLocation extends HomeEvent {
  final String driverPhoneNumber;

  const GetDriverLocation({
    required this.driverPhoneNumber,
  });
}

final class GetStationNames extends HomeEvent {}
