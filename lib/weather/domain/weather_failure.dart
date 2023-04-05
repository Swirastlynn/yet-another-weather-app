import '../../common/domain/displayable_failure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherFailure implements HasDisplayableFailure {
  final AppLocalizations appLocalizations;
  final StackTrace stackTrace;
  final WeatherFailureType type;

  WeatherFailure._({
    required this.appLocalizations,
    required this.stackTrace,
    required this.type,
  });

  factory WeatherFailure.unknown(
      {required AppLocalizations appLocalizations,
      required StackTrace stackTrace}) {
    return WeatherFailure._(
      stackTrace: stackTrace,
      type: WeatherFailureType.unknown,
      appLocalizations: appLocalizations,
    );
  }

  factory WeatherFailure.apiCallFailure({
    required AppLocalizations appLocalizations,
    required StackTrace stackTrace,
  }) {
    return WeatherFailure._(
      appLocalizations: appLocalizations,
      stackTrace: stackTrace,
      type: WeatherFailureType.apiCallFailure,
    );
  }

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case WeatherFailureType.unknown:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.commonErrorMessage,
        );
      case WeatherFailureType.apiCallFailure:
        return DisplayableFailure(
          title: appLocalizations.apiCallErrorTitle,
          message: appLocalizations.apiCallErrorMessage,
        );
    }
  }
}

enum WeatherFailureType {
  unknown,
  apiCallFailure,
}
