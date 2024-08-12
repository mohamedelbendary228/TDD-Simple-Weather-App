import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/core/constants/constants.dart';
import 'package:tdd_weather_app/core/error/exceptions.dart';
import 'package:tdd_weather_app/features/home/data/datasources/remote_data_source.dart';
import 'package:tdd_weather_app/features/home/data/models/weather_model.dart';

import '../../../../helpers/dummy_data/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

//**
// we will test the following
// - Getting data from API and we have two scenarios.
//? - First scenario: returning a Valid Model when getting data is successful
//? - Second scenario: returning a Server Exception when getting data is failed
// */

void main() {
  late MockDio mockDio;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(
    () {
      mockDio = MockDio();
      weatherRemoteDataSourceImpl =
          WeatherRemoteDataSourceImpl(dioClient: mockDio);
    },
  );

  const testCityName = 'New York';
  group(
    'Weather Remote DataSource ---------------',
    () {
      test(
        'should return a valid model when the response code is 200',
        () async {
          // arrange
          when(
            mockDio.get(Urls.currentWeatherByName(testCityName)),
          ).thenAnswer(
            (_) async {
              return Response(
                requestOptions: RequestOptions(),
                statusCode: 200,
                data:
                    readJson('helpers/dummy_data/dummy_weather_response.json'),
              );
            },
          );

          // act
          final result =
              await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

          // assert
          expect(result, isA<WeatherModel>());
        },
      );

      test(
        'should throw a server exception when the response code is 404 or other',
        () async {
          // arrange
          when(
            mockDio.get(Urls.currentWeatherByName(testCityName)),
          ).thenAnswer(
            (_) async {
              return Response(
                  requestOptions: RequestOptions(),
                  statusCode: 404,
                  data: 'Not found');
            },
          );
          // act
          final result =
              weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

          // assert
          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
