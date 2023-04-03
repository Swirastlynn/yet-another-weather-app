import '../../common/domain/displayable_failure.dart';

class WeatherFailure implements HasDisplayableFailure {
  final StackTrace stackTrace;
  final WeatherFailureType type;

  const WeatherFailure.unknown(this.stackTrace)
      : type = WeatherFailureType.unknown;

  const WeatherFailure.apiCallFailure(this.stackTrace)
      : type = WeatherFailureType.apiCallFailure;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case WeatherFailureType.unknown:
        return DisplayableFailure.commonError();
      case WeatherFailureType.apiCallFailure:
        return DisplayableFailure(
          title: "network Error", //appLocalizations.networkErrorTitle,
          message: "network Error", //appLocalizations.networkErrorMessage,
        );
    }
  }
}

enum WeatherFailureType {
  unknown,
  apiCallFailure,
}
