import 'package:dartz/dartz.dart';
import 'package:tdd_weather_app/core/error/failures.dart';
import 'package:tdd_weather_app/core/usecase/usecase.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';
import 'package:tdd_weather_app/features/home/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase implements UseCase<WeatherEntitiy, String> {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase({required this.weatherRepository});

  @override
  Future<Either<Failure, WeatherEntitiy>> call(String cityName) async {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
