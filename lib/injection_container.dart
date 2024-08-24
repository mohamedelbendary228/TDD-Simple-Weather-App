import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tdd_weather_app/features/home/data/datasources/remote_data_source.dart';
import 'package:tdd_weather_app/features/home/data/repositories/weather_repository_impl.dart';
import 'package:tdd_weather_app/features/home/domain/repositories/weather_repository.dart';
import 'package:tdd_weather_app/features/home/domain/usecases/get_current_weather.dart';
import 'package:tdd_weather_app/features/home/presentation/bloc/weather_bloc.dart';

final serviceLocator = GetIt.instance;

void setupLocator() {
  // bloc
  serviceLocator.registerFactory(() => WeatherBloc(serviceLocator()));

  // usecase
  serviceLocator.registerLazySingleton(
      () => GetCurrentWeatherUseCase(weatherRepository: serviceLocator()));

  // repository
  serviceLocator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(serviceLocator()),
  );

  // data source
  serviceLocator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      dioClient: serviceLocator(),
    ),
  );

  // external
  serviceLocator.registerLazySingleton(() => Dio());
}
