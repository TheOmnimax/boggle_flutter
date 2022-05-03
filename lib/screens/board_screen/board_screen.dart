import 'package:boggle_flutter/screens/board_screen/bloc/bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class TimerBloc {}
//
// class TimerComponent extends StatelessWidget {
//   const TimerComponent({
//     Key? key,
//     required this.boardBloc,
//   }) : super(key: key);
//
//   final BoardBloc boardBloc;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => TimerBloc(boardBloc: boardBloc),
//       child: Container(),
//     );
//   }
// }

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    Key? key,
    required this.gameCode,
    required this.playerCode,
  }) : super(key: key);

  final String gameCode;
  final String playerCode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardBloc(
        roomCode: gameCode,
      )..add(const LoadGame()),
      child: const BoardScreenMain(),
    );
  }
}

class BoardScreenMain extends StatelessWidget {
  const BoardScreenMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boardBloc = context.read<BoardBloc>();

    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, state) {
        print('On board screen...');
        print('Game code: ${boardBloc.roomCode}');
        // print('Player code: ${boardBloc.playerCode}');
        if (state is Loading) {
          return Text('Loading...');
        } else {
          return GameArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('${state.timeRemaining}'),
                  ],
                ),
                BoggleTable(
                  rows: state.boggleBoard.tableRows,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            const Text('Accepted'),
                            Text(state.player.getApprovedWords().join('\n')),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Rejected'),
                            Text(state.player.getRejectedString()),
                          ],
                        ),
                      ],
                    ),
                    Builder(builder: (context) {
                      if (state is Playing) {
                        return const WordEntry();
                      } else if (state is Ready) {
                        return TextButton(
                          onPressed: () {},
                          child: Text('Start'),
                        );
                      } else if (state is Complete) {
                        return Text('Done!');
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class WordEntry extends StatelessWidget {
  const WordEntry({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Enter word:'),
        SizedBox(
          width: 50,
          child: TextFormField(
            onChanged: (value) {
              print('Entered: $value');
            },
          ),
        ),
      ],
    );
  }
}
