part of 'calculator_bloc.dart';

sealed class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object> get props => [];
}

final class CalculatorInitial extends CalculatorState {}

// state for calculate expression
final class CalculatorCalculating extends CalculatorState {}

// state for success calculate expression
final class CalculatorCalculated extends CalculatorState {
  final String expression;
  final double result;

  const CalculatorCalculated(this.expression, this.result);

  @override
  List<Object> get props => [expression, result];
}

// state for error in calculate expression
final class CalculatorError extends CalculatorState {
  final String message;

  const CalculatorError(this.message);

  @override
  List<Object> get props => [message];
}

// state for view history of calculations
final class CalculatorHistory extends CalculatorState {
  final List<Calculation> calculations;

  const CalculatorHistory(this.calculations);

  @override
  List<Object> get props => [calculations];
}

// state for clear history of calculations
final class CalculatorHistoryCleared extends CalculatorState {}
