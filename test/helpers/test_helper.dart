import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:tdd_weather_app/features/home/domain/repositories/weather_repository.dart';

@GenerateMocks([
  WeatherRepository,
  Dio,
])
void main() {}
