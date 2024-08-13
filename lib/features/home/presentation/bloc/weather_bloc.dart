import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_weather_app/features/home/domain/entities/weather.dart';
import 'package:tdd_weather_app/features/home/domain/usecases/get_current_weather.dart';
part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  WeatherBloc(GetCurrentWeatherUseCase getCurrentWeatherUseCase)
      : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        super(WeatherEmpty()) {
    on<OnCityChangedEvent>(_onCityChanged);
  }

  void _onCityChanged(
    OnCityChangedEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    final result = await _getCurrentWeatherUseCase(event.cityName);

    result.fold(
      (failure) => emit(WeatherLoadFailure(failure.message)),
      (data) => emit(
        WeatherLoaded(data),
      ),
    );
  }

  @override
  void onChange(Change<WeatherState> change) {
    super.onChange(change);
    debugPrint("WeatherBloc $change");
  }
}
