part of 'global_app_bloc.dart';

sealed class GlobalAppEvent extends Equatable {
  const GlobalAppEvent();

  @override
  List<Object> get props => [];
}

final class OpenNotes extends GlobalAppEvent {}

final class OpenCalculator extends GlobalAppEvent {}

final class OpenCalculatorHistory extends GlobalAppEvent {}
