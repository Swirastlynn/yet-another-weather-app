An app based on a [publicly available design](https://www.figma.com/file/1gEKtGkPW4Tw41dw6kuzSJ/Weather-App-(Community)?node-id=0-1&t=JF3EbgYD4N3fFZr1-0) and [API](https://openweathermap.org/api)

## How do I get set up?

### FVM
Install [fvm](https://fvm.app/) on your machine. Project configuration for fvm is in [.fvm/fvm_config.json](.fvm/fvm_config.json). To set up the same Flutter SDK version like the one I was working on, run in your project path: 
```bash
fvm install
``` 

### API keys
Create `.env` file in the project root folder. Add there a line of code sent to you by co-author.

Then go to `env/env.dart` and modify the file a bit. Comment out all the lines inside `Env` class.

```
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  // @EnviedField(varName: 'OPENWEATHER_API_KEY')
  // @EnviedField(obfuscate: true)
  // static const openWeatherApiKey = _Env.openWeatherApiKey;
}
```

Then call `flutter pub run build_runner build` from CLI. 
Then uncomment the code inside `Env` class.
In the end call `flutter pub run build_runner build` once again.

Voila, you can build a project!