part of 'popup_bloc.dart';

abstract class PopupEvent extends Equatable {
  const PopupEvent();

  @override
  List<Object?> get props => [];
}

class UpdateName extends PopupEvent {
  const UpdateName({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [name];
}

class UpdateCode extends PopupEvent {
  const UpdateCode({
    required this.roomCode,
  });

  final String roomCode;

  @override
  List<Object?> get props => [roomCode];
}

class UpdateError extends PopupEvent {
  const UpdateError({
    required this.errorMessage,
  });
  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
