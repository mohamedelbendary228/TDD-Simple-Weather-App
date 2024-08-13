import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tdd_weather_app/core/error/exceptions.dart';
import 'package:tdd_weather_app/core/error/failures.dart';
import 'package:tdd_weather_app/features/home/data/datasources/remote_data_source.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';
import 'package:tdd_weather_app/features/home/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl(this.weatherRemoteDataSource);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
