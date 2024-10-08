part of 'driver_bloc.dart';

sealed class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object> get props => [];
}

final class UpdateDriverLocationEvent extends DriverEvent {
  final double latitude;
  final double longitude;

  const UpdateDriverLocationEvent({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [
        latitude,
        longitude,
      ];
}

final class GetNextRouteEvent extends DriverEvent {
  final int busId;

  const GetNextRouteEvent({
    required this.busId,
  });

  @override
  List<Object> get props => [
        busId,
      ];
}
