import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_app_layout_event.dart';
part 'global_app_layout_state.dart';

class GlobalAppLayoutBloc extends Bloc<GlobalAppLayoutEvent, GlobalAppLayoutState> {
  GlobalAppLayoutBloc() : super(GlobalAppInitial()) {
    on<GlobalAppLayoutEvent>((event, emit) {
      switch (event.runtimeType) {
        case OpenNotes:
          emit(GlobalAppNotesOpened());
          break;
        case OpenCalculator:
          emit(GlobalAppCalculatorOpened());
          break;
        case OpenCalculatorHistory:
          emit(GlobalAppHistoryOpened());
          break;
      }
    });
  }
}
