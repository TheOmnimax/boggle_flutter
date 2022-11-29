part of 'board_bloc.dart';

abstract class BoardState extends Equatable {
  const BoardState({
    required this.boggleBoard,
    required this.player,
    required this.timeRemaining,
    required this.enteredText,
  });

  final BoggleBoard boggleBoard;
  final BogglePlayer player;
  final int timeRemaining;
  final String enteredText;

  @override
  List<Object?> get props => [
        boggleBoard,
        player,
        timeRemaining,
        enteredText,
      ];

  BoardState copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String enteredText,
  });
}

class Loading extends BoardState {
  const Loading()
      : super(
          boggleBoard: const BoggleBoard(
            spaces: <List<String>>[],
            tableRows: [],
          ),
          player: const BogglePlayer(
            id: '',
            name: '',
          ),
          timeRemaining: 0,
          enteredText: '',
        );

  @override
  Loading copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredText,
  }) {
    return const Loading();
  }
}

class Ready extends BoardState {
  const Ready({
    required BoggleBoard boggleBoard,
    required BogglePlayer player,
    required int timeRemaining,
  }) : super(
          boggleBoard: boggleBoard,
          player: player,
          timeRemaining: timeRemaining,
          enteredText: '',
        );

  @override
  Ready copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredText,
  }) {
    return Ready(
      boggleBoard: boggleBoard ?? this.boggleBoard,
      player: player ?? this.player,
      timeRemaining: timeRemaining ?? this.timeRemaining,
    );
  }
}

class Playing extends BoardState {
  const Playing({
    required BoggleBoard boggleBoard,
    required BogglePlayer player,
    required int timeRemaining,
    required String enteredWord,
  }) : super(
          boggleBoard: boggleBoard,
          player: player,
          timeRemaining: timeRemaining,
          enteredText: enteredWord,
        );

  @override
  Playing copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredText,
  }) {
    return Playing(
      boggleBoard: boggleBoard ?? this.boggleBoard,
      player: player ?? this.player,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      enteredWord: enteredText ?? this.enteredText,
    );
  }
}

class Complete extends BoardState {
  const Complete({
    required BoggleBoard boggleBoard,
    required BogglePlayer player,
    required String enteredWord,
  }) : super(
          boggleBoard: boggleBoard,
          player: player,
          timeRemaining: 0,
          enteredText: enteredWord,
        );

  @override
  Complete copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredText,
  }) {
    return Complete(
      boggleBoard: boggleBoard ?? this.boggleBoard,
      player: player ?? this.player,
      enteredWord: enteredText ?? this.enteredText,
    );
  }
}

class ReadyForResults extends BoardState {
  const ReadyForResults({
    required BoggleBoard boggleBoard,
    required BogglePlayer player,
    required String enteredWord,
  }) : super(
          boggleBoard: boggleBoard,
          player: player,
          timeRemaining: 0,
          enteredText: enteredWord,
        );

  @override
  ReadyForResults copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredText,
  }) {
    return ReadyForResults(
      boggleBoard: boggleBoard ?? this.boggleBoard,
      player: player ?? this.player,
      enteredWord: enteredText ?? this.enteredText,
    );
  }
}
