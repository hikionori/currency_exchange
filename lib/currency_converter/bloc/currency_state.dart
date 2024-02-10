part of 'currency_bloc.dart';

sealed class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object> get props => [];
}

final class CurrencyInitial extends CurrencyState {}

final class CurrencyLoading extends CurrencyState {}

final class CurrenciesLoaded extends CurrencyState {
  final Map<String, String> currencies;

  const CurrenciesLoaded(this.currencies);

  @override
  List<Object> get props => [currencies];
}

final class CurrencyError extends CurrencyState {
  final String message;

  const CurrencyError(this.message);

  @override
  List<Object> get props => [message];
}

final class CurrencyConverted extends CurrencyState {
  final CurrencyConvertingModel currencyConvertingModel;

  const CurrencyConverted(this.currencyConvertingModel);

  @override
  List<Object> get props => [currencyConvertingModel];
}
