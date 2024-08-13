import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/core/error/exceptions.dart';
import 'package:tdd_weather_app/core/error/failures.dart';
import 'package:tdd_weather_app/features/home/data/models/weather_model.dart';
import 'package:tdd_weather_app/features/home/data/repositories/weather_repository_impl.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';

import '../../../../helpers/test_helper.mocks.dart';

//**
// we will test the following
// - return weather data on successful API request
// - return server failure when request to API fails
// - return connection failure when not connected to internet
// */

void main() {
  late WeatherRepositoryImpl weatherRepositoryImpl;
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group(
    "Weather Repository Impl Test --------------------------",
    () {
      test(
        'should return weather entity when a call to data source is successful',
        () async {
          // arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenAnswer(
            (_) async => testWeatherModel,
          );

          // act
          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // assert
          expect(result, equals(const Right(testWeatherEntity)));
        },
      );
      test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
          // arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(const ServerException('An error has occurred'));

          // act
          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // assert
          expect(result,
              equals(const Left(ServerFailure('An error has occurred'))));
        },
      );

      test(
        'should return connection failure when not connected to internet',
        () async {
          // arrange
          when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
              .thenThrow(
                  const SocketException('Failed to connect to the network'));

          // act
          final result =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);

          // assert
          expect(
              result,
              equals(const Left(
                  ConnectionFailure('Failed to connect to the network'))));
        },
      );
    },
  );
}
