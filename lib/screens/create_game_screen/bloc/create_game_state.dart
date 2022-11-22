part of 'create_game_bloc.dart';

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
    return MainState();
  }
}

class LoadingGame extends CreateGameState {
  const LoadingGame() : super();

  @override
  LoadingGame copyWith() {
    return LoadingGame();
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
  List<Object?> get props => [
        gameCode,
        playerCode,
      ];

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

class JoinError extends CreateGameState {
  const JoinError({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  CreateGameState copyWith({
    String? errorMessage,
  }) {
    return JoinError(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
