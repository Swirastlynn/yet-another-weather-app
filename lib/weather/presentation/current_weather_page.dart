// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:yet_another_weather_app/weather/presentation/current_weather_page_components/current_weather_nav_bar.dart';
import 'package:yet_another_weather_app/weather/presentation/current_weather_page_components/main_stats_view.dart';
import 'package:yet_another_weather_app/weather/presentation/current_weather_page_components/small_table_stats.dart';

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

    // FIXME: UI layer. The task is to change this to a more appropriate widget.
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Image.asset('lib/assets/images/AppLogo.png'),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.density_medium),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/images/Rectangle204.png'),
              fit: BoxFit.cover),
        ),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 60,
              ),
              state.when(
                data: (item) => Center(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'lib/assets/images/Rectangle217.png'),
                              fit: BoxFit.cover),
                        ),
                        height: 600,
                        width: 300,
                      ),
                      MainStatsView(
                        temperature: item.temperature,
                        cloudiness: item.cloudiness,
                        windSpeed: item.windSpeed,
                      ),
                      Positioned(
                          top: -50,
                          child: Image.asset(
                              'lib/assets/images/MoonCloudFastWind.png')),
                      Positioned(
                        bottom: 145,
                        child: Container(
                          height: 50,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextButton(
                            onPressed: () {
                              context.go('/details');
                            },
                            child: const Text(
                              'VIEW  STATS',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Positioned(
                        bottom: 10,
                        child: SmallTableStats(
                          pressure: item.pressure,
                          humidity: item.humidity,
                          windSpeed: item.windSpeed,
                        ),
                      ),
                    ],
                  ),
                ),
                loading: () => const CircularProgressIndicator(),
                error: (e, st) => Center(
                  child: Text(
                    e.toString(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CurrentWeatherNavBar(),
    );
  }
}
