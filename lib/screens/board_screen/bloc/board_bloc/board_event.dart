part of 'board_bloc.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();

  @override
  List<Object?> get props => [];
}

class LoadGame extends BoardEvent {
  const LoadGame();
}

class StartGame extends BoardEvent {
  const StartGame();
}

class GameStarted extends BoardEvent {
  const GameStarted();
}

class EnteredText extends BoardEvent {
  const EnteredText({
    required this.text,
  });

  final String text;

  @override
  List<Object?> get props => [text];
}

class AddWord extends BoardEvent {
  const AddWord({
    required this.word,
  });

  final String word;

  @override
  List<Object?> get props => [word];
}

class EndGame extends BoardEvent {
  const EndGame();
}

class ResultsReady extends BoardEvent {
  const ResultsReady();
}

class ViewResults extends BoardEvent {
  const ViewResults();
}
