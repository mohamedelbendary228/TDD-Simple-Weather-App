import 'package:dio/dio.dart';
import 'package:tdd_weather_app/core/constants/constants.dart';
import 'package:tdd_weather_app/core/error/exceptions.dart';
import 'package:tdd_weather_app/features/home/data/models/weather_model.dart';

abstract interface class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dioClient;

  WeatherRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final response = await dioClient.get(Urls.currentWeatherByName(cityName));
      return WeatherModel.fromJson(response.data);
    } on DioException catch (dioError) {
      throw ServerException(dioError.message!);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
