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

class DismissPopup extends HomeEvent {
  const DismissPopup();
}

class JoinGame extends HomeEvent {
  const JoinGame({
    required this.gameCode,
    required this.name,
  });

  final String gameCode;
  final String name;

  @override
  List<Object?> get props => [gameCode, name];
}

class CloseError extends HomeEvent {
  const CloseError();
}
