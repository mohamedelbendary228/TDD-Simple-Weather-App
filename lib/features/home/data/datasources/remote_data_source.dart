import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tdd_weather_app/core/constants/constants.dart';
import 'package:tdd_weather_app/core/error/exceptions.dart';
import 'package:tdd_weather_app/core/network/dio_client.dart';
import 'package:tdd_weather_app/features/home/data/models/weather_model.dart';

abstract interface class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final DioClient dioClient;

  WeatherRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final response = await dioClient.get(Urls.currentWeatherByName(cityName));
      return WeatherModel.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      throw ServerException(e.message!);
    }
  }
}
