import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:tdd_weather_app/features/home/domain/repositories/weather_repository.dart';
// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;

@GenerateMocks(
  [WeatherRepository, Dio],
  // customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
