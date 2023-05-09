import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';

import '../../env/env.dart';
import '../providers.dart';

class CurrentWeatherController extends AsyncNotifier<CurrentWeatherModel> {
  Future<void> getWeather() async {
    final weatherUseCase = ref.read(weatherUseCaseProvider);
    state = const AsyncValue.loading();
    await weatherUseCase
        .getWeather(
          cityId: "2643743",
          appId: Env.openWeatherApiKey,
          units: "metric",
        )
        .fold(
          (failure) => state = AsyncValue.error(
              failure.displayableFailure().message, failure.stackTrace),
          (success) => state = AsyncValue.data(success),
        );
  }

  @override
  FutureOr<CurrentWeatherModel> build() {
    return CurrentWeatherModel.empty();
  }
}
