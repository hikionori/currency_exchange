part of 'global_app_bloc.dart';

sealed class GlobalAppState extends Equatable {
  const GlobalAppState();

  @override
  List<Object> get props => [];
}

final class GlobalAppInitial extends GlobalAppState {
  final bool isSplited = false;
  final bool notesIsVisible = false;
  final bool calculatorIsVisible = false;

  final CalculatorModuleState calculatorModuleState =
      CalculatorModuleState.hidden;
  final NotesModuleState notesModuleState = NotesModuleState.hidden;
}

final class GlobalAppNotesOpened extends GlobalAppState {
  final bool isSplited = true;
  final bool notesIsVisible = true;
  final bool calculatorIsVisible = false;

  final CalculatorModuleState calculatorModuleState =
      CalculatorModuleState.hidden;
  final NotesModuleState notesModuleState = NotesModuleState.full;
}

final class GlobalAppCalculatorOpened extends GlobalAppState {
  final bool isSplited = true;
  final bool notesIsVisible = false;
  final bool calculatorIsVisible = true;

  final CalculatorModuleState calculatorModuleState =
      CalculatorModuleState.full;
  final NotesModuleState notesModuleState = NotesModuleState.hidden;
}

final class GlobalAppBothOpened extends GlobalAppState {
  final bool isSplited = true;
  final bool notesIsVisible = true;
  final bool calculatorIsVisible = true;

  final CalculatorModuleState calculatorModuleState = CalculatorModuleState.mid;
  final NotesModuleState notesModuleState = NotesModuleState.mid;
}

final class GlobalAppHistoryOpened extends GlobalAppState {
  final bool isSplited = true;
  final bool notesIsVisible = false;
  final bool calculatorIsVisible = true;

  final CalculatorModuleState calculatorModuleState =
      CalculatorModuleState.historyFull;
  final NotesModuleState notesModuleState = NotesModuleState.hidden;
}

final class GlobalAppHistoryWithNotesOpened extends GlobalAppState {
  final bool isSplited = true;
  final bool notesIsVisible = true;
  final bool calculatorIsVisible = true;

  final CalculatorModuleState calculatorModuleState =
      CalculatorModuleState.historyWithNotes;
  final NotesModuleState notesModuleState = NotesModuleState.folded;
}

enum CalculatorModuleState { hidden, mid, full, historyFull, historyWithNotes }

enum NotesModuleState { hidden, full, mid, folded }
