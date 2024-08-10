import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_weather_app/features/home/data/models/weather_model.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';

import '../../../../helpers/dummy_data/json_reader.dart';

//**
// we will test the following
// - is the model that we have created is equal to the entity at the domain layer
// - does the [fromJson] function returns a valid model
// - does the [toJson] function returns the appropriate json map
// */

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  test(
    'should the weather model be a subclass of the weather entity',
    () async {
      // assert
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );

  test(
    'should the weather model returns a valid model from fromJson function',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = json
          .decode(readJson('helpers/dummy_data/dummy_weather_response.json'));
      // act
      final result = WeatherModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testWeatherModel));
    },
  );

  test(
    'should the toJson map return a proper data',
    () async {
      // act
      final result = testWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'New York',
      };

      expect(result, expectedJsonMap);
    },
  );
}
