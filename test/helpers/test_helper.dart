import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:tdd_weather_app/features/home/data/datasources/remote_data_source.dart';
import 'package:tdd_weather_app/features/home/domain/repositories/weather_repository.dart';

@GenerateMocks([
  WeatherRepository,
  WeatherRemoteDataSource,
  Dio,
])
void main() {}
