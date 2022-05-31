import 'package:boggle_flutter/utils/game/boggle_results.dart';
import 'package:equatable/equatable.dart';

abstract class ResultsState extends Equatable {
  const ResultsState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends ResultsState {
  const LoadingState();
}

class MainState extends ResultsState {
  const MainState({
    required this.boggleResults,
  });

  final BoggleResults boggleResults;

  @override
  List<Object?> get props => [boggleResults];
}
