part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class SoloGame extends HomeEvent {
  const SoloGame();
}

class HostGame extends HomeEvent {
  const HostGame();
}

class ShowPopup extends HomeEvent {
  const ShowPopup({
    required this.alert,
  });

  final Alert alert;

  @override
  List<Object?> get props => [alert];
}

class JoinGame extends HomeEvent {
  const JoinGame({
    required this.roomCode,
    required this.name,
  });

  final String roomCode;
  final String name;

  @override
  List<Object?> get props => [roomCode, name];
}

class CloseError extends HomeEvent {
  const CloseError();
}
