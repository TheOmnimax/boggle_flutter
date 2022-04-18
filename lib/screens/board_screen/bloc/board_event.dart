import 'package:boggle_flutter/screens/board_screen/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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

class ViewResults extends BoardEvent {
  const ViewResults();
}
