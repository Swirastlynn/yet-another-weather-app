import 'package:equatable/equatable.dart';
import 'package:yet_another_weather_app/weather/data/current_weather_response_dto.dart';

class CurrentWeatherModel extends Equatable {
  final int timestamp;
  final String iconCode;
  final double temperature;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int cloudiness;

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

  const CurrentWeatherModel({
    required this.timestamp,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.cloudiness,
  });

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
