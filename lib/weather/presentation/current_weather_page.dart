import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yet_another_weather_app/weather/presentation/components/date_time_helper.dart';

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
    int currentIndex = 0;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            state.when(
              //data: (item) => Text(item.temperature?.toString() ?? "empty"),
              data: (item) => Column(
                children: [
                  Image.asset('lib/assets/images/Moon cloud fast wind.png'),
                  Container(
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
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    item.windSpeed?.toString() ?? "empty",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 88, 88, 229),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    item.cloudiness?.toString() ?? "empty",
                                    style: const TextStyle(color: Colors.white),
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
                  const SizedBox(
                    height: 40,
                  ),
                  Text(item.humidity?.toString() ?? "empty",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  Text(item.humidity?.toString() ?? "empty",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                  Text(item.windSpeed?.toString() ?? "empty",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
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
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home,
              color: currentIndex == 0
                  ? const Color.fromRGBO(201, 105, 144, 1)
                  : Colors.grey,
              size: 40,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(
              Icons.search,
              color: currentIndex == 1
                  ? const Color.fromRGBO(201, 105, 144, 1)
                  : Colors.grey,
              size: 40,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Bookmarks',
            icon: Icon(
              Icons.bookmark,
              color: currentIndex == 2
                  ? const Color.fromRGBO(201, 105, 144, 1)
                  : Colors.grey,
              size: 40,
            ),
          ),
          BottomNavigationBarItem(
            label: 'User',
            icon: Icon(
              Icons.people,
              color: currentIndex == 3
                  ? const Color.fromRGBO(201, 105, 144, 1)
                  : Colors.grey,
              size: 40,
            ),
          ),
        ],
        onTap: (int newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
      ),
    );
  }
}
