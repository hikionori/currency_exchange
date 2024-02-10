part of 'global_app_layout_bloc.dart';

sealed class GlobalAppLayoutEvent extends Equatable {
  const GlobalAppLayoutEvent();

  @override
  List<Object> get props => [];
}

final class OpenNotes extends GlobalAppLayoutEvent {}

final class OpenCalculator extends GlobalAppLayoutEvent {}

final class OpenCalculatorHistory extends GlobalAppLayoutEvent {}
