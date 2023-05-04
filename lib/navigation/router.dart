import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../weather/presentation/weather_details.dart';
import '../weather/presentation/current_weather_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const CurrentWeatherPage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const WeatherDetails();
          },
        ),
      ],
    ),
  ]);
});
