import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transittrack/features/home/domain/entities/location.dart';
import 'package:transittrack/features/home/domain/entities/nearby.dart';
import 'package:transittrack/features/home/domain/usecases/search_location_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/search_nearby_buses_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  SearchLocationUsecase searchLocationUsecase;
  SearchNearbyBusesUsecase searchNearbyBusesUsecase;

  HomeBloc({required this.searchLocationUsecase, required this.searchNearbyBusesUsecase}) : super(HomeInitial()) {
    on<GetLocationEvent>(_getLocation);
    on<GetNearbyBusesEvent>(_getNearbyBuses);
  }

  _getLocation(GetLocationEvent event, Emitter<HomeState> emit) async {
    emit(LocationLoadingState());
    final locationList = await searchLocationUsecase(SerachLocationParams(input: event.input));
    locationList.fold(
      (failure) => emit(LocationErrorState(failure.errorMessage)),
      (locationList) => emit(LocationLoadedState(locationList: locationList)),
    );    
  }

  _getNearbyBuses(GetNearbyBusesEvent event, Emitter<HomeState> emit) async {
    emit(NearByBusesLoadingState());
    final nearByBusesList = await searchNearbyBusesUsecase(SearchNearbyBusesParams(
      input: event.input,
      longitude: event.longitude,
      latitude: event.latitude,
      radius: event.radius,
    ));
    
    nearByBusesList.fold(
      (failure) => emit(NearByBusesErrorState(failure.errorMessage)),
      (nearByBusesList) => emit(NearByBusesLoadedState(nearByBusesList: nearByBusesList)),
    );
  }
}
