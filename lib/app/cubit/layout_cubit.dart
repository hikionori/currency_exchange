import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    }
  }
}
