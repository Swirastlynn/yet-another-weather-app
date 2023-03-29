import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yet_another_weather_app/weather/presentation/current_weather_controller.dart';

class WeatherGeneral extends ConsumerStatefulWidget {
  const WeatherGeneral({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherGeneralState();
}

class _WeatherGeneralState extends ConsumerState<WeatherGeneral> {
  @override
  void initState() {
    super.initState();
    ref.read(currentWeatherControllerProvider.notifier).getWeather();
  }
  @override
  Widget build(BuildContext context) {
    var model = ref.watch(currentWeatherControllerProvider);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(model.temperature.toString()),
            Text(model.timestamp.toString()),
            OutlinedButton(
                onPressed: () {
                  context.go('/details');
                },
                child: const Text('Weather Details'))
          ],
        ),
      ),
    );
  }
}
