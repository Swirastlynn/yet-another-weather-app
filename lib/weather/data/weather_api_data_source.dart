import '../../common/network/dio_api_manager.dart';
import 'weather_response_dto.dart';

class WeatherApiDataSource {
  const WeatherApiDataSource(this.api, this.baseUrl);

  final DioApiManager api;
  final String baseUrl;

// todo some kind of Retrofettish interface
  Future<WeatherResponseDTO> getWeather({
    required String cityId,
    required String appId,
    required String units,
  }) async {
    return await api
        .getAPICall("$baseUrl/weather?appId=$appId&id=$cityId&units=$units");
  }
}
