import 'package:equatable/equatable.dart';

class CurrentWeatherPresentationModel extends Equatable {
  final String formattedDateTime;
  final String iconCode;
  final String temperature;
  final String pressure;
  final String humidity;
  final String windSpeed;
  final String windSpeedDescribe;
  final String cloudiness;
  final String cloudinessDescribe;

  const CurrentWeatherPresentationModel(
      this.formattedDateTime,
      this.iconCode,
      this.temperature,
      this.pressure,
      this.humidity,
      this.windSpeed,
      this.cloudiness,
      this.windSpeedDescribe,
      this.cloudinessDescribe);

  factory CurrentWeatherPresentationModel.empty() =>
      const CurrentWeatherPresentationModel('', '', '', '', '', '', '', '', '');

  @override
  List<Object?> get props => [
        formattedDateTime,
        iconCode,
        temperature,
        pressure,
        humidity,
        windSpeed,
        cloudiness
      ];
}
