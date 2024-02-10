// FILEPATH: /home/hikionori/Documents/Projects/currency_exchange/test/currency_converting_service_test.dart
import 'package:currency_exchange/currency_converter/models/currency_converting_model.dart';
import 'package:currency_exchange/currency_converter/services/currency_converting_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final service = CurrencyConvertingService();

  test('getCurrencyList returns a map of currencies', () async {
    final result = await service.getCurrencyList();

    expect(result, isA<Map<String, String>>());
    expect(result, isNotEmpty);
  });

  test('convertCurrency returns a CurrencyConvertingModel', () async {
    final result = await service.convertCurrency(100, 'usd', 'eur');

    
    expect(result, isA<CurrencyConvertingModel>());
    expect(result.from, 'usd');
    expect(result.to, 'eur');
    expect(result.amount, 100);
    expect(result.result, isA<double>());
  });
}
