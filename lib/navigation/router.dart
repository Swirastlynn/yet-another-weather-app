import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../weather/presentation/weather_details.dart';
import '../weather/presentation/current_weather_page.dart';

part 'router.g.dart';

@riverpod
GoRouter goRouter(GoRouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const CurrentWeatherPage(),
          routes: [
            GoRoute(
              path: 'details',
              builder: (BuildContext context, GoRouterState state) {
                return const WeatherDetails();
              },
            ),
          ],
        ),
      ],
    );
