import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:equatable/equatable.dart';

abstract class BoardState extends Equatable {
  const BoardState({
    required this.boggleBoard,
    required this.player,
    required this.timeRemaining,
    required this.enteredWord,
  });

  final BoggleBoard boggleBoard;
  final BogglePlayer player;
  final int timeRemaining;
  final String enteredWord;

  @override
  List<Object?> get props => [
        boggleBoard,
        player,
        timeRemaining,
        enteredWord,
      ];

  BoardState copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String enteredWord,
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
          enteredWord: '',
        );

  @override
  Loading copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredWord,
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
          enteredWord: '',
        );

  @override
  Ready copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredWord,
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
          enteredWord: enteredWord,
        );

  @override
  Playing copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredWord,
  }) {
    return Playing(
      boggleBoard: boggleBoard ?? this.boggleBoard,
      player: player ?? this.player,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      enteredWord: enteredWord ?? this.enteredWord,
    );
  }
}

class Complete extends BoardState {
  const Complete({
    required BoggleBoard boggleBoard,
    required BogglePlayer player,
    required int timeRemaining,
    required String enteredWord,
  }) : super(
          boggleBoard: boggleBoard,
          player: player,
          timeRemaining: timeRemaining,
          enteredWord: enteredWord,
        );

  @override
  Complete copyWith({
    BoggleBoard? boggleBoard,
    BogglePlayer? player,
    int? timeRemaining,
    String? enteredWord,
  }) {
    return Complete(
      boggleBoard: boggleBoard ?? this.boggleBoard,
      player: player ?? this.player,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      enteredWord: enteredWord ?? this.enteredWord,
    );
  }
}
