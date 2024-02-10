// FILEPATH: /home/hikionori/Documents/Projects/currency_exchange/test/currency_converter/bloc/currency_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/app/constants.dart';
import 'package:currency_exchange/currency_converter/bloc/currency_bloc.dart';
import 'package:currency_exchange/currency_converter/models/currency_converting_model.dart';
import 'package:currency_exchange/currency_converter/services/currency_converting_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyConvertingService extends Mock
    implements CurrencyConvertingService {
  @override
  Future<Map<String, String>> getCurrencyList() async {
    return {'usd': 'US Dollar', 'eur': 'Euro'};
  }

  @override
  Future<CurrencyConvertingModel> convertCurrency(
      double amount, String from, String to) async {
    return CurrencyConvertingModel(
        from: from, to: to, amount: amount, result: amount * 0.85);
  }
}

extension Throwable on When<Future<Map<String, String>>> {
  void thenThrowException(Exception exception) {
    thenThrow(exception);
  }
}

void main() {
  late MockCurrencyConvertingService mockCurrencyConvertingService;
  late CurrencyBloc currencyBloc;

  setUp(() {
    mockCurrencyConvertingService = MockCurrencyConvertingService();
    getIt.registerSingleton<CurrencyConvertingService>(
        mockCurrencyConvertingService);
    currencyBloc = CurrencyBloc();
  });

  tearDown(() {
    getIt.reset();
    currencyBloc.close();
  });

  blocTest<CurrencyBloc, CurrencyState>(
    'emits [CurrencyLoading, CurrenciesLoaded] when FetchCurrencies is added',
    build: () => currencyBloc,
    act: (bloc) => bloc.add(FetchCurrencies()),
    expect: () => <CurrencyState>[
      CurrencyLoading(),
      const CurrenciesLoaded({'usd': 'US Dollar', 'eur': 'Euro'}),
    ],
  );

  blocTest<CurrencyBloc, CurrencyState>(
    'emits [CurrencyLoading, CurrencyConverted] when ConvertCurrency is added',
    build: () => currencyBloc,
    act: (bloc) =>
        bloc.add(const ConvertCurrency(amount: 100, from: 'usd', to: 'eur')),
    expect: () => <CurrencyState>[
      CurrencyLoading(),
      CurrencyConverted(CurrencyConvertingModel(
          from: 'usd', to: "eur", amount: 100, result: 85.0)),
    ],
  );
}
