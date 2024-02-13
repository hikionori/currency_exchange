import 'package:currency_exchange/app/cubit/layout_cubit.dart';

double getNotesWidth(LayoutState state) {
  switch (state) {
    case LayoutState.initial:
    case LayoutState.calculator:
    case LayoutState.calculatorWithHistory:
      return 0;

    case LayoutState.notes:
      return 310;

    case LayoutState.both:
      return 310;

    case LayoutState.bothWithHistory:
      return 310;

    default:
      return 310; // Default value
  }
}

double getNotesHeight(LayoutState state) {
  switch (state) {
    case LayoutState.initial:
    case LayoutState.calculator:
    case LayoutState.calculatorWithHistory:
      return 0;

    case LayoutState.notes:
      return 440;

    case LayoutState.both:
      return 279;

    case LayoutState.bothWithHistory:
      return 50;

    default:
      return 50; // Default value
  }
}

double getCalculatorWidth(LayoutState state) {
  if (state == LayoutState.initial || state == LayoutState.notes) {
    return 0;
  } else if (state == LayoutState.calculator ||
      state == LayoutState.both ||
      state == LayoutState.bothWithHistory) {
    return 310;
  } else {
    return 310; // Default value
  }
}

double getCalculatorHeight(LayoutState state) {
  if (state == LayoutState.initial || state == LayoutState.notes) {
    return 0;
  } else if (state == LayoutState.calculator) {
    return 440;
  } else if (state == LayoutState.both) {
    return 151;
  } else if (state == LayoutState.bothWithHistory) {
    return 375;
  } else {
    return 440; // Default value
  }
}
