part of 'driver_bloc.dart';

sealed class DriverState extends Equatable {
  const DriverState();

  @override
  List<Object> get props => [];
}

final class DriverInitial extends DriverState {}

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
