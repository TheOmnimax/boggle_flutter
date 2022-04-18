import 'package:boggle_flutter/screens/home_screen/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState({this.gameCode = ''});

  final String gameCode;

  @override
  List<Object?> get props => [gameCode];

  HomeState copyWith({
    String? gameCode,
  });
}

class MainState extends HomeState {
  const MainState({
    String gameCode = '',
  }) : super(
          gameCode: gameCode,
        );

  @override
  MainState copyWith({
    String? gameCode,
  }) {
    return MainState(
      gameCode: gameCode ?? this.gameCode,
    );
  }
}

class JoinError extends HomeState {
  const JoinError({
    this.results,
    String gameCode = '',
  }) : super(
          gameCode: gameCode,
        );

  final String? results;

  @override
  List<Object?> get props => [results];

  @override
  JoinError copyWith({
    String? gameCode,
    String? results,
  }) {
    return JoinError(
      gameCode: gameCode ?? this.gameCode,
      results: results,
    );
  }
}

class Joining extends HomeState {
  const Joining({
    required String gameCode,
    required this.playerCode,
  }) : super(
          gameCode: gameCode,
        );

  final String playerCode;

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
