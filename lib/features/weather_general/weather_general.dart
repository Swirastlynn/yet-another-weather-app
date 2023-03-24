import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WeatherGeneral extends StatelessWidget {
  const WeatherGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text('Hello World!'),
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
