import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// provider used to access the AppLocalizations object for the current locale
/// source: https://codewithandrea.com/articles/app-localizations-outside-widgets-riverpod/
final appLocalizationsProvider = Provider<AppLocalizations>((ref) {
  // 1. initialize from the initial locale
  ref.state = lookupAppLocalizations(ui.window
      .locale); // TODO test for polish language on iPhone emulator, there's a bug
  // 2. create an observer to update the state
  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(ui.window.locale);
  });
  // 3. register the observer and dispose it when no longer needed
  final binding = WidgetsBinding.instance;
  binding.addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));
  // 4. return the state
  return ref.state;
});

/// observer used to notify the caller when the locale changes
class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);
  final void Function(List<Locale>? locales) _didChangeLocales;

  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
