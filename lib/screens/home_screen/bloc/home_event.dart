import 'package:boggle_flutter/screens/home_screen/bloc/bloc.dart';
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
  });

  final String gameCode;

  @override
  List<Object?> get props => [gameCode];
}
