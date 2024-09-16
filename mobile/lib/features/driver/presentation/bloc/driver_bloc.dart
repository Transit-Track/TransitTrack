import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/driver/domain/usecase/update_driver_location_usecase.dart';

part 'driver_event.dart';
part 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final UpdateDriverLocationUsecase updateDriverLocationUsecase;

  DriverBloc({required this.updateDriverLocationUsecase})
      : super(DriverInitial()) {
    on<UpdateDriverLocationEvent>(_updateDriverLocation);
  }

  void _updateDriverLocation(
      UpdateDriverLocationEvent event, Emitter<DriverState> emit) async {
    emit(UpdateDriverLoadingState());
    final result = await updateDriverLocationUsecase(UpdateDriverLocationParams(
      latitude: event.latitude,
      longitude: event.longitude,
    ));

    result.fold(
      (failure) => emit(UpdateDriverErrorState(message: failure.errorMessage)),
      (success) => emit(DriverLocationUpdatedState(message: success)),
    );
  }
}
