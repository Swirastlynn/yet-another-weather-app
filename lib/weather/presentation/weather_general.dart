import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final helloWorldProvider = Provider<String>((ref) {
  return 'Hello world';
});

class WeatherGeneral extends ConsumerWidget {
  const WeatherGeneral({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              ref.watch(helloWorldProvider),
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
