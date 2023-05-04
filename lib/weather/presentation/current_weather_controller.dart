import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/weather_use_case.dart';
import '../domain/current_weather_model.dart';

import '../../env/env.dart';

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
              state = AsyncValue.error(failure.displayableFailure().message, failure.stackTrace),
          (success) => state = AsyncValue.data(success),
        );
  }

  void throwException() {
    // todo to remove
    state = AsyncValue.error("error error", StackTrace.current);
  }
}
