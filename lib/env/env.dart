import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPENWEATHER_API_KEY')
  @EnviedField(obfuscate: true)
  static const openWeatherApiKey = _Env.openWeatherApiKey;
}
