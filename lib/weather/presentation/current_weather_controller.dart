import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/data/weather_api_data_source.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';

import '../../env/env.dart';

// todo StateNotifierProvider is legacy
final currentWeatherControllerProvider =
    StateNotifierProvider<CurrentWeatherController, CurrentWeatherModel>(
  (ref) => CurrentWeatherController(ref.read(weatherDataSourceProvider)),
);

// todo Either

class CurrentWeatherController extends StateNotifier<CurrentWeatherModel> {
  CurrentWeatherController(this.weatherDataSource)
      : super(CurrentWeatherModel.empty());

  final WeatherApiDataSource weatherDataSource;

// get apiKey from env package and env.dart

  Future<void> getWeather() async {
    final dto = await weatherDataSource.getWeather(
      cityId: "2643743",
      appId: Env.openWeatherApiKey,
      units: "metric",
    );
    state = CurrentWeatherModel.from(dto);
  }
}
