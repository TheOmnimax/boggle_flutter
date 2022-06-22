import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class SoloGame extends HomeEvent {
  const SoloGame();

  @override
  List<Object?> get props => [];
}

class HostGame extends HomeEvent {
  const HostGame();

  @override
  List<Object?> get props => [];
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

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
