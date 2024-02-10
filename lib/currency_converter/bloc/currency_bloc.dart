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
    on<CurrencyEvent>((event, emit) async {
      switch (event.runtimeType) {
        case FetchCurrencies:
          await _handleFetchCurrencies(event as FetchCurrencies, emit);
          break;
        case ConvertCurrency:
          await _handleCurrencyConversion(event as ConvertCurrency, emit);
          break;
        case RefreshCurrencies:
          await _handleFetchCurrencies(FetchCurrencies(), emit);
          break;
      }
    });
  }

  Future _handleFetchCurrencies(
      FetchCurrencies event, Emitter<CurrencyState> emit) async {
    try {
      emit(CurrencyLoading());
      final currencies = await currencyConvertingService.getCurrencyList();
      emit(CurrenciesLoaded(currencies));
    } catch (e) {
      emit(CurrencyError(e.toString()));
    }
  }

  Future _handleCurrencyConversion(
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
