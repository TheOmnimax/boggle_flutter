import 'package:equatable/equatable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

abstract class CreateGameState extends Equatable {
  const CreateGameState({
    this.alert,
    this.playerName = '',
    this.gameTime = 90,
  });

  final Alert? alert;
  final String playerName;
  final int? gameTime;

  @override
  List<Object?> get props => [
        alert,
        playerName,
        gameTime,
      ];

  CreateGameState copyWith({
    Alert? alert,
    String? playerName,
    int? gameTime,
  });
}

class MainState extends CreateGameState {
  const MainState({
    Alert? alert,
    String playerName = '',
    int? gameTime,
  }) : super(
          alert: alert,
          playerName: playerName,
          gameTime: gameTime,
        );

  @override
  MainState copyWith({
    Alert? alert,
    String? playerName,
    int? gameTime,
  }) {
    return MainState(
      alert: alert,
      playerName: playerName ?? this.playerName,
      gameTime: gameTime ?? this.gameTime,
    );
  }
}

class LoadingGame extends CreateGameState {
  const LoadingGame({
    Alert? alert,
    String playerName = '',
    int? gameTime,
  }) : super(
          alert: alert,
          playerName: playerName,
          gameTime: gameTime,
        );

  @override
  LoadingGame copyWith({
    Alert? alert,
    String? playerName,
    int? gameTime,
  }) {
    return LoadingGame(
      alert: alert,
      playerName: playerName ?? this.playerName,
      gameTime: gameTime ?? this.gameTime,
    );
  }
}

class Joining extends CreateGameState {
  const Joining({
    required this.gameCode,
    required this.playerCode,
    Alert? alert,
    String playerName = '',
    int? gameTime,
  }) : super(
          alert: alert,
          playerName: playerName,
          gameTime: gameTime,
        );

  final String gameCode;
  final String playerCode;

  @override
  List<Object?> get props => [
        gameCode,
        playerCode,
        alert,
        playerName,
        gameTime,
      ];

  @override
  Joining copyWith({
    String? gameCode,
    String? playerCode,
    Alert? alert,
    String? playerName,
    int? gameTime,
  }) {
    return Joining(
      gameCode: gameCode ?? this.gameCode,
      playerCode: playerCode ?? this.playerCode,
      alert: alert,
      playerName: playerName ?? this.playerName,
      gameTime: gameTime ?? this.gameTime,
    );
  }
}
