import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yet_another_weather_app/localization/localizations_provider.dart';

class PageNotFound extends ConsumerWidget {
  const PageNotFound(this.error, {Key? key}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context, ref) {
    final localization = ref.read(appLocalizationsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localization.notFoundCode,
        ),
      ),
      body:  Center(
        child: Text(
          localization.notFoundDescription,
        ),
      ),
    );
  }
}
