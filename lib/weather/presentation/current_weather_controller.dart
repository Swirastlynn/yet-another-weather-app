import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/function/cloud_calculator.dart';
import 'package:yet_another_weather_app/weather/presentation/presentation_model/current_weather_presentation_model.dart';

import '../../env/env.dart';
import '../function/date_time_helper.dart';
import '../function/wind_calculator.dart';
import '../providers.dart';

class CurrentWeatherController
    extends AsyncNotifier<CurrentWeatherPresentationModel> {
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
      (success) {
        final presentationModel = CurrentWeatherPresentationModel(
          DateTime.now().getFormattedDateTime(),
          success.iconCode ?? '',
          success.temperature.toString().split('.').first,
          success.pressure.toString(),
          success.humidity.toString(),
          success.windSpeed.toString(),
          windRating(success.windSpeed ?? -1),
          success.cloudiness.toString(),
          cloudRating(success.cloudiness ?? -1),
        );
        return state = AsyncValue.data(presentationModel);
      },
    );
  }

  void throwException() {
    // todo to remove
    state = AsyncValue.error("error error", StackTrace.current);
  }

  @override
  FutureOr<CurrentWeatherPresentationModel> build() {
    getWeather();
    return CurrentWeatherPresentationModel.empty();
  }
}
