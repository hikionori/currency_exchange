part of 'global_app_bloc.dart';

sealed class GlobalAppState extends Equatable {
  const GlobalAppState();
  
  @override
  List<Object> get props => [];
}

final class GlobalAppInitial extends GlobalAppState {}
