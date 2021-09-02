import 'dart:async';

import 'package:cks_weather/blocs/home_bloc.dart';
import 'package:cks_weather/blocs/home_vm.dart';
import 'package:cks_weather/configurations/configuration.dart';
import 'package:cks_weather/configurations/string_manager.dart';
import 'package:cks_weather/services/database/hive_database.dart';
import 'package:cks_weather/services/repository/weather_delegate.dart';
import 'package:cks_weather/services/repository/weather_repository.dart';
import 'package:cks_weather/services/weather/weather_service.dart';
import 'package:cks_weather/util/navigation/navigation_router.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

/// The global service locator instance of GetIt. Can also be found using GetIt.instance;
final GetIt getIt = GetIt.instance;

/// Setup function to set up Dependency Injection (DI)
void setupInjection({
  required Configuration configuration,
  required StringManager stringManager,
}) {
  getIt
    ..registerSingleton(stringManager)
    ..registerSingleton(configuration)
    ..registerSingleton(_logger)
    ..registerSingleton(_router)
    ..registerLazySingleton(() => _hiveDatabase())
    ..registerLazySingleton(() => _weatherService)
    ..registerLazySingleton(() => _weatherDelegate)
    ..registerLazySingleton(() => _weatherRepository)
    ..registerLazySingleton(() => _dio(configuration))
    ..registerSingleton(_homeBloc);

}

Logger get _logger => Logger();

NavigationRouter get _router => NavigationRouter();

HomeBloc get _homeBloc => HomeBloc(HomeVm());

Dio _dio(Configuration configuration) {
  final options = BaseOptions(
    baseUrl: configuration.baseUrl,
    connectTimeout: 20000,
    receiveTimeout: 3000,
  );
  final dio = Dio(options);
  return dio;
}

HiveDatabase _hiveDatabase() {
  final HiveDatabase hiveDatabase = HiveDatabase();
  hiveDatabase.initHive();
  return hiveDatabase;
}

WeatherService get _weatherService => WeatherService(getIt<Dio>());

WeatherDelegate get _weatherDelegate => WeatherDelegate();

WeatherRepository get _weatherRepository => WeatherRepository();
