import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/presentation/presentation_model/current_weather_presentation_model.dart';
import '../common/providers.dart';
import '../common/tools/app_localizations_utils.dart';
import 'application/weather_use_case.dart';
import 'data/weather_api_data_source.dart';
import 'presentation/current_weather_controller.dart';

final currentWeatherControllerProvider = AsyncNotifierProvider<
    CurrentWeatherController, CurrentWeatherPresentationModel>(
  CurrentWeatherController.new,
);

final weatherUseCaseProvider = Provider<WeatherUseCase>(
  (ref) {
    return WeatherUseCase(
      ref.watch(weatherApiDataSourceProvider),
      ref.watch(appLocalizationsProvider),
    );
  },
);

final weatherApiDataSourceProvider = Provider<WeatherApiDataSource>(
  (ref) {
    return WeatherApiDataSource(
      api: ref.watch(dioApiManagerProvider),
      baseUrl: ref.read(baseUrlProvider),
    );
  },
);
