import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          getFormattedDateTime(),
          success.iconCode,
          ...,
          success.pressure,
          success.humidity,
          windRating(success.windSpeed),
          success.cloudiness,
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

// to separate file
class CurrentWeatherPresentationModel extends Equatable {
  final String formattedDateTime;
  final String iconCode;
  final String temperature;
  final String pressure;
  final String humidity;
  final String windSpeed;
  final String cloudiness;

  const CurrentWeatherPresentationModel(
      this.formattedDateTime,
      this.iconCode,
      this.temperature,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.cloudiness);

  factory CurrentWeatherPresentationModel.empty() =>
      const CurrentWeatherPresentationModel(
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      );

  @override
  List<Object?> get props => [
        formattedDateTime,
        iconCode,
        temperature,
        pressure,
        humidity,
        windSpeed,
        cloudiness
      ];
}
