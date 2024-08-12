import 'package:mockito/annotations.dart';
import 'package:tdd_weather_app/core/network/dio_client.dart';
import 'package:tdd_weather_app/features/home/domain/repositories/weather_repository.dart';

@GenerateMocks([
  WeatherRepository,
  DioClient,
])
void main() {}
