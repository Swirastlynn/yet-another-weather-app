import '../../common/network/dio_api_manager.dart';
import '../domain/current_weather_model.dart';
import 'current_weather_response_dto.dart';

class WeatherApiDataSource {
  const WeatherApiDataSource({required this.api, required this.baseUrl});

  final DioApiManager api;
  final String baseUrl;

  // todo some kind of Retrofittish interface
  Future<CurrentWeatherModel> getWeather({
    required String cityId,
    required String appId,
    required String units,
  }) async {
    Json json = await api.getJsonAPICall(
        "$baseUrl/weather?appId=$appId&id=$cityId&units=$units");
    return CurrentWeatherModel.from(CurrentWeatherResponseDTO.fromJson(json));
  }
}
