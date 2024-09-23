part of 'driver_bloc.dart';

sealed class DriverState extends Equatable {
  const DriverState();

  @override
  List<Object> get props => [];
}

final class DriverInitial extends DriverState {}

// Update location state

final class UpdateDriverLoadingState extends DriverState {}

final class DriverLocationUpdatedState extends DriverState {
  final String message;

  const DriverLocationUpdatedState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateDriverErrorState extends DriverState {
  final String message;

  const UpdateDriverErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

// get next route state
final class GetNextRouteLoadingState extends DriverState {}

final class GetNextRouteSuccessState extends DriverState {
  final String nextRoute;

  const GetNextRouteSuccessState({required this.nextRoute});

  @override
  List<Object> get props => [nextRoute];
}

final class GetNextRouteErrorState extends DriverState {
  final String message;

  const GetNextRouteErrorState({required this.message});

  @override
  List<Object> get props => [message];
}