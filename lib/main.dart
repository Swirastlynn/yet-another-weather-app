import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yet_another_weather_app/features/weather_general/weather_general.dart';

import 'features/weather_details/weather_details.dart';

final _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const WeatherGeneral(),
      routes: <RouteBase>[
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

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
