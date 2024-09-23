import 'package:transittrack/core/injections/injection.dart';
import 'package:transittrack/features/home/data/datasource/remote/google_map_datasource.dart';
import 'package:transittrack/features/home/data/datasource/remote/remote_datasource.dart';
import 'package:transittrack/features/home/data/repository/home_repository_impl.dart';
import 'package:transittrack/features/home/domain/repositories/home_repository.dart';
import 'package:transittrack/features/home/domain/usecases/get_available_buses_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_driver_location_usecase.dart';
import 'package:transittrack/features/home/domain/usecases/get_station_names_usecase.dart';
import 'package:transittrack/features/home/presentation/bloc/home_bloc.dart';

class HomeInjection {
  init() {
    //! Bloc
    sl.registerFactory(() => HomeBloc(
          getAvailableBusesUsecase: sl(),
          getDriverLocationUsecase: sl(),
          getStationNamesUsecase: sl(),
        ));

    //! Repository
    sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
          networkInfo: sl(),
          remoteDataSource: sl(),
          googleMapDatasource: sl(),
        ));

    //! DataSource
    sl.registerLazySingleton<GoogleMapDatasource>(
        () => GoogleMapDataSourceImpl(client: sl()));
    sl.registerLazySingleton<HomeRemoteDataSource>(() =>
        HomeRemoteDataSourceImpl(client: sl(), googleMapDatasource: sl()));

    //! Usecase
    sl.registerLazySingleton(() => GetAvailableBusesUsecase(repository: sl()));
    sl.registerLazySingleton(() => GetDriverLocationUsecase(repository: sl()));
    sl.registerLazySingleton(() => GetStationNamesUsecase(repository: sl()));
  }
}
