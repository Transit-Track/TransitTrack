import 'package:transittrack/core/injections/injection.dart';
import 'package:transittrack/features/driver/data/datasource/driver_remote_data_source.dart';
import 'package:transittrack/features/driver/data/repository/driver_repository_impl.dart';
import 'package:transittrack/features/driver/domain/repository/driver_repository.dart';
import 'package:transittrack/features/driver/domain/usecase/update_driver_location_usecase.dart';
import 'package:transittrack/features/driver/presentation/bloc/driver_bloc.dart';

class DriverInjection {
  init() {
    //! Bloc
    sl.registerFactory(
      () => DriverBloc(
        updateDriverLocationUsecase: sl(),
      ),
    );
    //! Repository
    sl.registerLazySingleton<DriverRepository>(
      () => DriverRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localDataSource: sl(),
      ),
    );

    //! Data Source
    sl.registerLazySingleton<DriverRemoteDataSource>(
      () => DriverRemoteDataSourceImpl(
        client: sl(),
      ),
    );
    

    //! Usecase
    sl.registerLazySingleton(
      () => UpdateDriverLocationUsecase(
        repository: sl(),
      ),
    );
  }
}
