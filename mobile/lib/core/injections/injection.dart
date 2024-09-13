import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:transittrack/core/injections/auth_injection/auth_injection.dart';
import 'package:transittrack/core/injections/driver_injection/driver_injection.dart';
import 'package:transittrack/core/injections/home_injection/home_injection.dart';
import 'package:transittrack/core/usecases/usecases.dart';

import '../network/network.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  AuthInjection().init();
  HomeInjection().init();
  DriverInjection().init();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  sl.registerLazySingleton(() => InternetConnectionChecker());

  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => NoParams());
}
