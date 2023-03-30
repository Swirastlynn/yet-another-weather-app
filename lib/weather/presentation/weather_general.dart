import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yet_another_weather_app/weather/presentation/current_weather_controller.dart';

import '../domain/current_weather_model.dart';

class WeatherGeneral extends ConsumerStatefulWidget {
  const WeatherGeneral({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherGeneralState();
}

class _WeatherGeneralState extends ConsumerState<WeatherGeneral> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<CurrentWeatherModel> state =
        ref.watch(currentWeatherControllerProvider);

    // todo an article about how to have cookie and eat it - snackbar and beatiful handling of loading/data
    // ref.listen<AsyncValue<CurrentWeatherModel>>(
    //   currentWeatherControllerProvider,
    //   (_, state) => state.whenOrNull(
    //     error: (error, _) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text(error.toString())),
    //       );
    //     },
    //   ),
    // );

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            state.when(
              data: (item) => Text(item.temperature?.toString() ?? ""),
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Center(child: Text(e.toString())),
            ),
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
