import 'package:bloc/bloc.dart';
import 'package:currency_exchange/app/constants.dart';
import 'package:currency_exchange/calculator/models/calculation_model.dart';
import 'package:currency_exchange/calculator/services/calculator_service.dart';
import 'package:equatable/equatable.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculatorService _currencyConvertingService =
      getIt.get<CalculatorService>();

  CalculatorBloc() : super(CalculatorInitial()) {
    on<CalculatorEvent>((event, emit) async {
      switch (event.runtimeType) {
        case CalculatorCalculate:
          await _handleCalculate(event as CalculatorCalculate, emit);
          break;
        case CalculatorViewHistory:
          await _handleViewHistory(event as CalculatorViewHistory, emit);
          break;
        case CalculatorClearHistory:
          await _handleClearHistory(event as CalculatorClearHistory, emit);
          break;
      }
    });
  }

  _handleCalculate(
      CalculatorCalculate event, Emitter<CalculatorState> emit) async {
    emit(CalculatorCalculating());
    try {
      final result =
          await _currencyConvertingService.calculate(event.expression);
      emit(CalculatorCalculated(event.expression, result));
    } catch (e) {
      emit(const CalculatorError("Error"));
    }
  }

  _handleViewHistory(
      CalculatorViewHistory event, Emitter<CalculatorState> emit) async {
    try {
      final calculations = await _currencyConvertingService.getCalculations();
      emit(CalculatorHistory(calculations));
    } catch (e) {
      emit(const CalculatorError("Error"));
    }
  }

  _handleClearHistory(
      CalculatorClearHistory event, Emitter<CalculatorState> emit) async {
    try {
      await _currencyConvertingService.clearHistory();
      emit(CalculatorHistoryCleared());
    } catch (e) {
      emit(const CalculatorError("Error"));
    }
  }
}
