import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yet_another_weather_app/common/tools/either_extensions.dart';
import 'package:yet_another_weather_app/weather/application/weather_use_case.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';
import 'package:yet_another_weather_app/weather/domain/weather_failure.dart';
import 'package:yet_another_weather_app/weather/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockWeatherUseCase extends Mock implements WeatherUseCase {}

class MockAppLocalizations extends Mock implements AppLocalizations {}

class MockStackTrace extends Mock implements StackTrace {}

// a generic Listener class, used to keep track of when a provider notifies its listeners. Required by Riverpod.
class Listener<T> extends Mock {
  void call(T? previous, T next);
}

final emptyData = CurrentWeatherModel.empty();
const loadedData = CurrentWeatherModel(
  cloudiness: null,
  humidity: null,
  iconCode: '',
  pressure: null,
  temperature: 15.00,
  timestamp: null,
  windSpeed: null,
);

void main() {
  // a helper method to create a ProviderContainer that overrides the weatherUseCaseProvider
  ProviderContainer makeProviderContainer(MockWeatherUseCase weatherUseCase) {
    final container = ProviderContainer(
      overrides: [
        weatherUseCaseProvider.overrideWithValue(weatherUseCase),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    // registerFallbackValue is needed by "any" and "captureAny" matchers. https://pub.dev/packages/mocktail#how-it-works
    registerFallbackValue(const AsyncLoading<CurrentWeatherModel>());
  });

  group('Current Weather', () {
    test('controller initialization test', () {
      final weatherUseCase = MockWeatherUseCase();

      final container = makeProviderContainer(weatherUseCase);
      final listener = Listener<AsyncValue<CurrentWeatherModel>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        currentWeatherControllerProvider,
        listener,
        fireImmediately: true,
      );

      // verify initial value from build method
      verify(() => listener(null, AsyncData(emptyData)));
      verifyNoMoreInteractions(listener);
    });

    test('controller success test', () async {
      final weatherUseCase = MockWeatherUseCase();
      when(() => weatherUseCase.getWeather(
            cityId: any(named: 'cityId'),
            appId: any(named: 'appId'),
            units: any(named: 'units'),
          )).thenAnswer((_) => successFuture(loadedData));

      final container = makeProviderContainer(weatherUseCase);
      final listener = Listener<AsyncValue<CurrentWeatherModel>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        currentWeatherControllerProvider,
        listener,
        fireImmediately: true,
      );
      final controller =
          container.read(currentWeatherControllerProvider.notifier);
      // verify initial value from build method
      verify(() => listener(null, AsyncData(emptyData)));
      // run
      await controller.getWeather();
      // verify
      verifyInOrder([
        () => listener(
            AsyncValue.data(emptyData), any(that: isA<AsyncLoading>())),
        () => listener(
            any(that: isA<AsyncLoading>()), const AsyncValue.data(loadedData)),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => weatherUseCase.getWeather(
            cityId: any(named: 'cityId'),
            appId: any(named: 'appId'),
            units: any(named: 'units'),
          )).called(1);
    });

    test('controller failure test', () async {
      final weatherUseCase = MockWeatherUseCase();
      final appLocalizations = MockAppLocalizations();
      when(() => weatherUseCase.getWeather(
            cityId: any(named: 'cityId'),
            appId: any(named: 'appId'),
            units: any(named: 'units'),
          )).thenAnswer(
        (_) => failureFuture(WeatherFailure.unknown(
            appLocalizations: appLocalizations, stackTrace: MockStackTrace())),
      );
      // TODO FakeAppLocalizations would be more appropriate - less code
      when(() => appLocalizations.commonErrorTitle)
          .thenAnswer((_) => "common error title");
      when(() => appLocalizations.commonErrorMessage)
          .thenAnswer((_) => "common error mesg");

      final container = makeProviderContainer(weatherUseCase);
      final listener = Listener<AsyncValue<CurrentWeatherModel>>();
      // listen to the provider and call [listener] whenever its value changes
      container.listen(
        currentWeatherControllerProvider,
        listener,
        fireImmediately: true,
      );
      final controller =
          container.read(currentWeatherControllerProvider.notifier);
      // verify initial value from build method
      verify(() => listener(null, AsyncData(emptyData)));
      // run
      await controller.getWeather();
      // verify
      verifyInOrder([
        () => listener(
            AsyncValue.data(emptyData), any(that: isA<AsyncLoading>())),
        () => listener(
            any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
      ]);
      verifyNoMoreInteractions(listener);
      verify(() => weatherUseCase.getWeather(
            cityId: any(named: 'cityId'),
            appId: any(named: 'appId'),
            units: any(named: 'units'),
          )).called(1);
    });
  });
}
