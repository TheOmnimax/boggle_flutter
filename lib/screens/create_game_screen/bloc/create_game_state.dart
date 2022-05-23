import 'package:equatable/equatable.dart';

abstract class CreateGameState extends Equatable {
  const CreateGameState();

  @override
  List<Object?> get props => [];

  CreateGameState copyWith();
}

class MainState extends CreateGameState {
  const MainState();

  @override
  MainState copyWith() {
    return const MainState();
  }
}

class LoadingGame extends CreateGameState {
  const LoadingGame();

  @override
  LoadingGame copyWith() {
    return const LoadingGame();
  }
}

class Joining extends CreateGameState {
  const Joining({
    required this.gameCode,
    required this.playerCode,
  });

  final String gameCode;
  final String playerCode;

  @override
  List<Object?> get props => [gameCode, playerCode];

  @override
  Joining copyWith({
    String? gameCode,
    String? playerCode,
  }) {
    return Joining(
      gameCode: gameCode ?? this.gameCode,
      playerCode: playerCode ?? this.playerCode,
    );
  }
}
