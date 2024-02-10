part of 'currency_bloc.dart';

sealed class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

final class FetchCurrencies extends CurrencyEvent {}

final class ConvertCurrency extends CurrencyEvent {
  final double amount;
  final String from;
  final String to;

  const ConvertCurrency({
    required this.amount,
    required this.from,
    required this.to,
  });

  @override
  List<Object> get props => [amount, from, to];
}

final class RefreshCurrencies extends CurrencyEvent {}
