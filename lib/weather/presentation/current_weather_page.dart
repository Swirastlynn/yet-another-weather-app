import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../domain/current_weather_model.dart';
import '../providers.dart';

class CurrentWeatherPage extends ConsumerStatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherGeneralState();
}

class _WeatherGeneralState extends ConsumerState<CurrentWeatherPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        ref.read(currentWeatherControllerProvider.notifier).getWeather());
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<CurrentWeatherModel> state =
        ref.watch(currentWeatherControllerProvider);

    // FIXME: UI layer. The task is to change this to a more appropriate widget.
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
              child: const Text('Weather Details'),
            ),
          ],
        ),
      ),
    );
  }
}
