import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';

import '../data/weather_api_data_source.dart';
import 'weather_failure.dart';

final weatherUseCaseProvider = Provider<WeatherUseCase>((ref) {
  return WeatherUseCase(ref.watch(weatherApiDataSourceProvider));
});

class WeatherUseCase {
  final WeatherApiDataSource dataSource;

  WeatherUseCase(this.dataSource);

  Future<Either<WeatherFailure, CurrentWeatherModel>> getWeather({
    required String cityId,
    required String appId,
    required String units,
  }) async {
    try {
      return Right(await dataSource.getWeather(
        cityId: cityId,
        appId: appId,
        units: units,
      ));
    } catch (error, stacktrace) {
      return Left(WeatherFailure(error.toString(), stacktrace));
    }
  }
}
