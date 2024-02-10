import 'package:bloc/bloc.dart';
import 'package:currency_exchange/app/constants.dart';
import 'package:currency_exchange/currency_converter/models/currency_converting_model.dart';
import 'package:currency_exchange/currency_converter/services/currency_converting_service.dart';
import 'package:equatable/equatable.dart';

part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyConvertingService currencyConvertingService =
      getIt.get<CurrencyConvertingService>();

  CurrencyBloc() : super(CurrencyInitial()) {
    on<CurrencyEvent>((event, emit) {
      switch (event.runtimeType) {
        case FetchCurrencies:
          _handleFetchCurrencies(event as FetchCurrencies, emit);
          break;
        case ConvertCurrency:
          _handleCurrencyConversion(event as ConvertCurrency, emit);
          break;
        case RefreshCurrencies:
          _handleFetchCurrencies(FetchCurrencies(), emit);
          break;
      }
    });
  }

  void _handleFetchCurrencies(
      FetchCurrencies event, Emitter<CurrencyState> emit) async {
    try {
      emit(CurrencyLoading());
      final currencies = await currencyConvertingService.getCurrencyList();
      emit(CurrenciesLoaded(currencies));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }

  void _handleCurrencyConversion(
      ConvertCurrency event, Emitter<CurrencyState> emit) async {
    try {
      emit(CurrencyLoading());
      final currencyConvertingModel = await currencyConvertingService
          .convertCurrency(event.amount, event.from, event.to);
      emit(CurrencyConverted(currencyConvertingModel));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }
}
