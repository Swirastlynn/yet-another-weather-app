import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yet_another_weather_app/common/tools/either_extensions.dart';
import 'package:yet_another_weather_app/weather/application/weather_use_case.dart';
import 'package:yet_another_weather_app/weather/domain/current_weather_model.dart';
import 'package:yet_another_weather_app/weather/domain/weather_failure.dart';
import 'package:yet_another_weather_app/weather/providers.dart';

import '../../common/fake_app_localizations.dart';

class MockWeatherUseCase extends Mock implements WeatherUseCase {}

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

  late MockWeatherUseCase mockWeatherUseCase;
  late Listener<AsyncValue<CurrentWeatherModel>> listener;
  late ProviderContainer providerContainer;

  setUp(() {
    mockWeatherUseCase = MockWeatherUseCase();
    listener = Listener<AsyncValue<CurrentWeatherModel>>();
    providerContainer = makeProviderContainer(mockWeatherUseCase);
    // listen to the provider and call [listener] whenever its value changes
    providerContainer.listen(
      currentWeatherControllerProvider,
      listener,
      fireImmediately: true,
    );
  });

  test('controller initialization test', () {
    // verify initial value from build method
    verify(() => listener(null, AsyncData(emptyData)));
    verifyNoMoreInteractions(listener);
  });

  test('controller success test', () async {
    when(() => mockWeatherUseCase.getWeather(
          cityId: any(named: 'cityId'),
          appId: any(named: 'appId'),
          units: any(named: 'units'),
        )).thenAnswer((_) => successFuture(loadedData));

    // verify initial value from build method
    verify(() => listener(null, AsyncData(emptyData)));
    // run
    await providerContainer
        .read(currentWeatherControllerProvider.notifier)
        .getWeather();
    // verify
    verifyInOrder([
      () =>
          listener(AsyncValue.data(emptyData), any(that: isA<AsyncLoading>())),
      () => listener(
          any(that: isA<AsyncLoading>()), const AsyncValue.data(loadedData)),
    ]);
    verifyNoMoreInteractions(listener);
    verify(() => mockWeatherUseCase.getWeather(
          cityId: any(named: 'cityId'),
          appId: any(named: 'appId'),
          units: any(named: 'units'),
        )).called(1);
  });

  test('controller failure test', () async {
    when(() => mockWeatherUseCase.getWeather(
          cityId: any(named: 'cityId'),
          appId: any(named: 'appId'),
          units: any(named: 'units'),
        )).thenAnswer(
      (_) => failureFuture(
        WeatherFailure.unknown(
          appLocalizations: FakeAppLocalizations(),
          stackTrace: MockStackTrace(),
        ),
      ),
    );

    // verify initial value from build method
    verify(() => listener(null, AsyncData(emptyData)));
    // run
    await providerContainer
        .read(currentWeatherControllerProvider.notifier)
        .getWeather();
    // verify
    verifyInOrder([
      () =>
          listener(AsyncValue.data(emptyData), any(that: isA<AsyncLoading>())),
      () => listener(
          any(that: isA<AsyncLoading>()), any(that: isA<AsyncError>())),
    ]);
    verifyNoMoreInteractions(listener);
    verify(() => mockWeatherUseCase.getWeather(
          cityId: any(named: 'cityId'),
          appId: any(named: 'appId'),
          units: any(named: 'units'),
        )).called(1);
  });
}
