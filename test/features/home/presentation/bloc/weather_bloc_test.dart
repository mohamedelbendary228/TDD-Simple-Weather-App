import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/core/error/failures.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';
import 'package:tdd_weather_app/features/home/presentation/bloc/weather_bloc.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test(
    'initial state should be empty',
    () async {
      //assert
      expect(weatherBloc.state, WeatherEmpty());
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    // arrange
    build: () {
      when(mockGetCurrentWeatherUseCase(testCityName)).thenAnswer(
        (_) async {
          return const Right(testWeather);
        },
      );
      return weatherBloc;
    },
    // act
    act: (bloc) => bloc.add(const OnCityChangedEvent(testCityName)),
    // we use wait because of transformer in the bloc
    wait: const Duration(milliseconds: 500),
    // assert
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(testWeather),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailure] when data is gotten unsuccessfully',
    // arrange
    build: () {
      when(mockGetCurrentWeatherUseCase(testCityName)).thenAnswer(
        (_) async {
          return const Left(ServerFailure('Server Failure'));
        },
      );
      return weatherBloc;
    },
    // act
    act: (bloc) => bloc.add(const OnCityChangedEvent(testCityName)),
    // we use wait because of transformer in the bloc
    wait: const Duration(milliseconds: 500),
    // assert
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure('Server Failure'),
    ],
  );
}
