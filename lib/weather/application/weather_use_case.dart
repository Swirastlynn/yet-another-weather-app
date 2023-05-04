import 'package:either_dart/either.dart';
import '../../common/network/network_exceptions_manager.dart';
import '../domain/current_weather_model.dart';
import '../domain/weather_failure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/weather_api_data_source.dart';

class WeatherUseCase {
  final WeatherApiDataSource dataSource;
  final AppLocalizations appLocalizations;

  WeatherUseCase(this.dataSource, this.appLocalizations);

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
    } on NetworkException catch (e, stackTrace) {
      return Left(
        WeatherFailure.apiCallFailure(
          appLocalizations: appLocalizations,
          stackTrace: stackTrace,
        ),
      );
    } catch (e, stackTrace) {
      return Left(
        WeatherFailure.unknown(
          appLocalizations: appLocalizations,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
