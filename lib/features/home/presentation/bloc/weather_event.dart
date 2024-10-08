part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class OnCityChangedEvent extends WeatherEvent {
  final String cityName;

  const OnCityChangedEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}
