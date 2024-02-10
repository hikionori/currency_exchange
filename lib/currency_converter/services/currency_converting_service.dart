import 'package:currency_exchange/currency_converter/models/currency_converting_model.dart';
import 'package:dio/dio.dart';

class CurrencyConvertingService {
  final Dio dio;

  CurrencyConvertingService({Dio? dio}) : dio = dio ?? Dio();

  /// return a map of currencies
  /// where the key is the currency code and the value is the currency name
  Future<Map<String, String>> getCurrencyList() async {
    try {
      final response = await dio.get(
          "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.min.json");
      final Map<String, dynamic> data = response.data;
      return data.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      rethrow;
    }
  }

  Future<CurrencyConvertingModel> convertCurrency(
      double amount, String from, String to) async {
    try {
      final response = await dio.get(
          "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies/$from.min.json");
      final Map<String, dynamic> data = response.data[from];
      if (!data.containsKey(to)) {
        throw Exception("Currency not found");
      }
      final rate = data[to];
      final double result = amount * rate;
      return CurrencyConvertingModel(
        from: from,
        to: to,
        amount: amount,
        result: double.parse(result.toStringAsFixed(2)),
      );
    } catch (e) {
      rethrow;
    }
  }
}
