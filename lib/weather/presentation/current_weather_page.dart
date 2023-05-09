// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:yet_another_weather_app/weather/presentation/current_weather_page_components/current_weather_nav_bar.dart';
import 'package:yet_another_weather_app/weather/presentation/current_weather_page_components/date_time_helper.dart';
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
    String formattedDateTime = DateTimeHelper.getFormattedDateTime();

    // FIXME: UI layer. The task is to change this to a more appropriate widget.
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Image.asset('lib/assets/images/App Logo.png'),
          actions: [
            IconButton(
                onPressed: () => {}, icon: const Icon(Icons.density_medium))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/assets/images/Rectangle 204.png'),
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
                  //data: (item) => Text(item.temperature?.toString() ?? "empty"),
                  data: (item) => Center(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'lib/assets/images/Rectangle 217.png'),
                                fit: BoxFit.cover),
                          ),
                          height: 600,
                          width: 300,
                        ),
                        Container(
                          alignment: const Alignment(1, 0.1),
                          height: 260,
                          width: 260,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60,
                              ),
                              const Text(
                                'Los Angeles, CA, USA',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    item.temperature.toString(),
                                    style: const TextStyle(fontSize: 50),
                                  ),
                                  const SizedBox(
                                    width: 60,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 244, 184, 244),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          item.windSpeed?.toString() ?? "empty",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 88, 88, 229),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          item.cloudiness?.toString() ??
                                              "empty",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(formattedDateTime),
                            ],
                          ),
                        ),
                        Positioned(
                            top: -50,
                            child: Image.asset(
                                'lib/assets/images/Moon cloud fast wind.png')),
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
                            item: item,
                          ),
                        ),
                      ],
                    ),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (e, st) => Center(child: Text(e.toString())),
                ),
                // TextButton(
                //   onPressed: () => ref
                //       .read(currentWeatherControllerProvider.notifier)
                //       .throwException(),
                //   child: const Text("Throw Test Exception"),
                // ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CurrentWeatherNavBar());
  }
}
