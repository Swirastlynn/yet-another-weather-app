import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';

final emptyData = CurrentWeatherModel.empty();
const loadedData = CurrentWeatherModel(
  cloudiness: null,
  humidity: null,
  iconCode: '',
  pressure: null,
  temperature: 15.00,
  timestamp: null,
  windSpeed: null,
);
