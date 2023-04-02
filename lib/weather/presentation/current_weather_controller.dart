import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/application/weather_use_case.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';

import '../../env/env.dart';

final currentWeatherControllerProvider = StateNotifierProvider<
        CurrentWeatherController, AsyncValue<CurrentWeatherModel>>(
    (ref) => CurrentWeatherController(ref.watch(weatherUseCaseProvider)));

class CurrentWeatherController
    extends StateNotifier<AsyncValue<CurrentWeatherModel>> {
  CurrentWeatherController(this.weatherUseCase)
      : super(AsyncValue.data(CurrentWeatherModel.empty())) {
    getWeather();
  }

  final WeatherUseCase weatherUseCase;

  Future<void> getWeather() async {
    state = const AsyncValue.loading();
    await weatherUseCase
        .getWeather(
          cityId: "2643743",
          appId: Env.openWeatherApiKey,
          units: "metric",
        )
        .fold(
          (failure) =>
              state = AsyncValue.error(failure.message, failure.stackTrace),
          (success) => state = AsyncValue.data(success),
        );
  }

  void throwException() {
    // todo to remove
    state = AsyncValue.error("error error", StackTrace.current);
  }
}
