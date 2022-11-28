part of 'results_bloc.dart';

abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object?> get props => [];
}

class Loading extends ResultsEvent {
  const Loading();
}

class ResultsReady extends ResultsEvent {
  const ResultsReady();
}

class NewGame extends ResultsEvent {
  const NewGame();
}
