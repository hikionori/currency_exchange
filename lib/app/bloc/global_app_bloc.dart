import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_app_event.dart';
part 'global_app_state.dart';

class GlobalAppBloc extends Bloc<GlobalAppEvent, GlobalAppState> {
  GlobalAppBloc() : super(GlobalAppInitial()) {
    on<GlobalAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
