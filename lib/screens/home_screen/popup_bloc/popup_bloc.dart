import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popup_event.dart';
part 'popup_state.dart';

class PopupBloc extends Bloc<PopupEvent, PopupState> {
  PopupBloc()
      : super(const PopupState(name: '', roomCode: '', errorMessage: '')) {
    on<UpdateName>(_updateName);
    on<UpdateCode>(_updateCode);
    on<UpdateError>(_updateError);
  }

  void _updateName(UpdateName event, Emitter<PopupState> emit) {
    emit(state.copyWith(
      name: event.name,
    ));
  }

  void _updateCode(UpdateCode event, Emitter<PopupState> emit) {
    emit(state.copyWith(
      name: event.roomCode,
    ));
  }

  void _updateError(UpdateError event, Emitter<PopupState> emit) {
    print('Updated error message:');
    print(event.errorMessage);
    emit(state.copyWith(
      errorMessage: event.errorMessage,
    ));
  }
}
