import 'package:bloc/bloc.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutState.initial);

  void toggleCalculator() {
    switch (state) {
      case LayoutState.initial:
        emit(LayoutState.calculator);
        break;
      case LayoutState.calculator:
        emit(LayoutState.initial);
        break;
      case LayoutState.notes:
        emit(LayoutState.both);
        break;
      case LayoutState.both:
        emit(LayoutState.notes);
        break;
      case LayoutState.calculatorWithHistory:
        emit(LayoutState.notes);
        break;
      case LayoutState.bothWithHistory:
        emit(LayoutState.notes);
        break;
    }
  }

  void toggleNotes() {
    switch (state) {
      case LayoutState.initial:
        emit(LayoutState.notes);
        break;
      case LayoutState.notes:
        emit(LayoutState.initial);
        break;
      case LayoutState.calculator:
        emit(LayoutState.both);
        break;
      case LayoutState.both:
        emit(LayoutState.calculator);
        break;
      case LayoutState.bothWithHistory:
        emit(LayoutState.calculatorWithHistory);
        break;
      case LayoutState.calculatorWithHistory:
        emit(LayoutState.bothWithHistory);
        break;
    }
  }

  void toggleCalculatorHistory() {
    switch (state) {
      case LayoutState.initial:
        emit(LayoutState.calculatorWithHistory);
        break;
      case LayoutState.calculator:
        emit(LayoutState.calculatorWithHistory);
        break;
      case LayoutState.both:
        emit(LayoutState.bothWithHistory);
        break;
      case LayoutState.notes:
        emit(LayoutState.bothWithHistory);
        break;
      case LayoutState.bothWithHistory:
        emit(LayoutState.both);
        break;
      case LayoutState.calculatorWithHistory:
        emit(LayoutState.calculator);
        break;
    }
  }
}
