import 'package:boggle_flutter/screens/board_screen/bloc/board_bloc/bloc.dart';
import 'package:boggle_flutter/screens/board_screen/bloc/timer_bloc/bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerComponent extends StatelessWidget {
  const TimerComponent({
    Key? key,
    required this.boardBloc,
  }) : super(key: key);

  final BoardBloc boardBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TimerBloc(
        boardBloc: boardBloc,
        startTime: 90,
      ),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          return Text(state.time.toString());
        },
      ),
    );
  }
}

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
        hostId: playerCode,
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
        if (state is Loading) {
          return Text('Loading...');
        } else {
          return GameArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text('Room code:'),
                        Text(context.read<BoardBloc>().roomCode),
                      ],
                    ),
                    Row(
                      children: [
                        TimerComponent(
                          boardBloc: context.read<BoardBloc>(),
                        ),
                      ],
                    ),
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
                        return Column(
                          children: [
                            WordEntry(
                              onChanged: (String word) {
                                if (word.contains('\n')) {
                                  word.replaceAll('\n', '');
                                  print('Entered: $word');
                                  context
                                      .read<BoardBloc>()
                                      .add(AddWord(word: word));
                                } else {
                                  context
                                      .read<BoardBloc>()
                                      .add(EnteredText(text: word));
                                }
                              },
                              text: state.enteredText,
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<BoardBloc>().add(AddWord(
                                      word: state.enteredText,
                                    ));
                              },
                              child: Text('Send'),
                            ),
                          ],
                        );
                      } else if (state is Ready) {
                        return TextButton(
                          onPressed: () {
                            context.read<BoardBloc>().add(const StartGame());
                          },
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
    required this.onChanged,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Function(String) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    print('Text: $text');
    final tc = TextEditingController();
    tc.text = text;

    tc
      ..text = text
      ..selection =
          TextSelection(baseOffset: text.length, extentOffset: text.length);
    return Column(
      children: [
        const Text('Enter word:'),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: tc,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
