import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/network/dio_api_manager.dart';
import 'current_weather_response_dto.dart';

class WeatherApiDataSource {
  const WeatherApiDataSource({required this.api, required this.baseUrl});

  final DioApiManager api;
  final String baseUrl;

  // todo some kind of Retrofettish interface
  Future<CurrentWeatherResponseDTO> getWeather({
    required String cityId,
    required String appId,
    required String units,
  }) async {
    Map<String, dynamic> json = await api
        .getAPICall("$baseUrl/weather?appId=$appId&id=$cityId&units=$units");
    return CurrentWeatherResponseDTO.fromJson(json);
  }
}

final weatherDataSourceProvider = Provider<WeatherApiDataSource>((ref) {
  return WeatherApiDataSource(
    api: DioApiManager(), // todo inject
    baseUrl: "https://api.openweathermap.org/data/2.5",
  );
});
