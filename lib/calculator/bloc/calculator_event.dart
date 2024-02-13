part of 'calculator_bloc.dart';

sealed class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

// event for calculate expression
final class CalculatorCalculate extends CalculatorEvent {
  final String expression;

  const CalculatorCalculate(this.expression);

  @override
  List<Object> get props => [expression];
}

// event for view history of calculations
final class CalculatorViewHistory extends CalculatorEvent {}

// event for clear history of calculations
final class CalculatorClearHistory extends CalculatorEvent {}
