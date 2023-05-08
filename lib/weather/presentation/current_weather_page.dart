import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yet_another_weather_app/weather/presentation/components/current_weather_nav_bar.dart';

import '../domain/current_weather_model.dart';
import '../providers.dart';

class CurrentWeatherPage extends ConsumerStatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherGeneralState();
}

class _WeatherGeneralState extends ConsumerState<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<CurrentWeatherModel> state =
        ref.watch(currentWeatherControllerProvider);

    int selectedIndex = 0;

    void navigateBottomBar(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    // FIXME: UI layer. The task is to change this to a more appropriate widget.
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/images/Rectangle 204.png'),
              fit: BoxFit.cover),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            state.when(
              data: (item) => Text(item.temperature?.toString() ?? "empty"),
              //data: (item) => ,
              loading: () => const CircularProgressIndicator(),
              error: (e, st) => Center(child: Text(e.toString())),
            ),
            OutlinedButton(
              onPressed: () {
                context.go('/details');
              },
              child: const Text('Weather Details'),
            ),
            TextButton(
              onPressed: () => ref
                  .read(currentWeatherControllerProvider.notifier)
                  .throwException(),
              child: const Text("Throw Test Exception"),
            ),
            const Spacer(
              flex: 1,
            ),
            const CurrentWeatherNavBar(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
