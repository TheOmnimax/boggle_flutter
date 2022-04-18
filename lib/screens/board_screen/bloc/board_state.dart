import 'package:boggle_flutter/screens/board_screen/bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';

abstract class BoardState extends Equatable {
  const BoardState({
    required this.boggleBoard,
  });

  final BoggleBoard boggleBoard;

  @override
  List<Object?> get props => [boggleBoard];

  BoardState copyWith(BoggleBoard? boggleBoard);
}

class Loading extends BoardState {
  const Loading()
      : super(
          boggleBoard: const BoggleBoard(
            spaces: <List<String>>[],
            tableRows: [],
          ),
        );

  @override
  Loading copyWith(BoggleBoard? boggleBoard) {
    return const Loading();
  }
}

class Ready extends BoardState {
  const Ready({
    required BoggleBoard boggleBoard,
  }) : super(
          boggleBoard: boggleBoard,
        );

  @override
  List<Object?> get props => [boggleBoard];

  @override
  Ready copyWith(BoggleBoard? boggleBoard) {
    return Ready(
      boggleBoard: boggleBoard ?? this.boggleBoard,
    );
  }
}

class Playing extends BoardState {
  const Playing({
    required BoggleBoard boggleBoard,
  }) : super(
          boggleBoard: boggleBoard,
        );

  @override
  Playing copyWith(BoggleBoard? boggleBoard) {
    return Playing(
      boggleBoard: boggleBoard ?? this.boggleBoard,
    );
  }
}

class Complete extends BoardState {
  const Complete({
    required BoggleBoard boggleBoard,
  }) : super(
          boggleBoard: boggleBoard,
        );

  @override
  Complete copyWith(BoggleBoard? boggleBoard) {
    return Complete(
      boggleBoard: boggleBoard ?? this.boggleBoard,
    );
  }
}
