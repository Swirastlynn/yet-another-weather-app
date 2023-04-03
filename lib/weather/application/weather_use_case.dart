import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';
import 'package:yet_another_weather_app/weather/domain/weather_failure.dart';

import '../data/weather_api_data_source.dart';

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
      return Right(
        await dataSource.getWeather(
          cityId: cityId,
          appId: appId,
          units: units,
        ),
      );
    } catch (_, stacktrace) {
      return Left(
        WeatherFailure.apiCallFailure(stacktrace),
      );
    }
  }
}
