import 'package:equatable/equatable.dart';
import '../data/current_weather_response_dto.dart';

class CurrentWeatherModel extends Equatable {
  const CurrentWeatherModel({
    required this.timestamp,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.cloudiness,
  });

  factory CurrentWeatherModel.empty() {
    return const CurrentWeatherModel(
      timestamp: null,
      iconCode: null,
      temperature: null,
      pressure: null,
      humidity: null,
      windSpeed: null,
      cloudiness: null,
    );
  }

  factory CurrentWeatherModel.from(CurrentWeatherResponseDTO dto) {
    return CurrentWeatherModel(
      timestamp: dto.dt,
      iconCode: dto.weather.first.icon,
      temperature: dto.main.temp,
      pressure: dto.main.pressure,
      humidity: dto.main.humidity,
      windSpeed: dto.wind.speed,
      cloudiness: dto.clouds.all,
    );
  }

  final int? timestamp;
  final String? iconCode;
  final double? temperature;
  final int? pressure;
  final int? humidity;
  final double? windSpeed;
  final int? cloudiness;

  @override
  List<Object?> get props => [
        timestamp,
        iconCode,
        temperature,
        pressure,
        humidity,
        windSpeed,
        cloudiness,
      ];
}
