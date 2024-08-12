import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';
import 'package:tdd_weather_app/features/home/domain/usecases/get_current_weather.dart';

import '../../../../helpers/test_helper.mocks.dart';

//**
// - we want to ensure that the repository is actually called
//   and the data simply passes unchanged through the usecase
// */

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  //* setUp method runs before every individual test
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });

  const testWeatherDetails = WeatherEntity(
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
    'should return a success weather entity from the repository',
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
