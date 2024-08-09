import 'package:dartz/dartz.dart';
import 'package:tdd_weather_app/core/error/failures.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';

abstract interface class WeatherRepository {
  Future<Either<Failure, WeatherEntitiy>> getCurrentWeather(String cityName);
}
