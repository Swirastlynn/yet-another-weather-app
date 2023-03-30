import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/data/weather_api_data_source.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';

import '../../env/env.dart';

final currentWeatherControllerProvider = StateNotifierProvider<
        CurrentWeatherController, AsyncValue<CurrentWeatherModel>>(
    (ref) => CurrentWeatherController(ref.watch(weatherDataSourceProvider)));

// todo Either?

class CurrentWeatherController
    extends StateNotifier<AsyncValue<CurrentWeatherModel>> {
  CurrentWeatherController(this.weatherDataSource)
      : super(AsyncValue.data(CurrentWeatherModel.empty())) {
    getWeather();
  }

  final WeatherApiDataSource weatherDataSource;

  Future<void> getWeather() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => weatherDataSource.getWeather(
          cityId: "2643743",
          appId: Env.openWeatherApiKey,
          units: "metric",
        ));
  }
}
