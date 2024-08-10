import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';
import 'package:tdd_weather_app/features/home/domain/usecases/get_current_weather.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  //* we want to ensure that the repository is actucally called
  //* and the data simply passes unchanged through the usecase

  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  //* setUp method run before every individual test
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });

  const testWeatherDetails = WeatherEntitiy(
    cityName: "New York",
    main: "Clouds",
    description: "few Clouds",
    iconCode: "02d",
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test(
    'should get current weather details from the repository',
    () async {
      // arrange
      when(mockWeatherRepository.getCurrentWeather(testCityName))
          .thenAnswer((_) async => const Right(testWeatherDetails));

      // act
      final result = await getCurrentWeatherUseCase(testCityName);

      // assert
      expect(result, const Right(testWeatherDetails));
    },
  );
}
