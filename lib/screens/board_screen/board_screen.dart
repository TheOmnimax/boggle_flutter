import 'package:boggle_flutter/bloc/bloc.dart';
import 'package:boggle_flutter/screens/board_screen/bloc/board_bloc/bloc.dart';
import 'package:boggle_flutter/screens/board_screen/bloc/timer_bloc/bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
import 'package:boggle_flutter/shared_widgets/show_popup.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerComponent extends StatelessWidget {
  const TimerComponent({
    Key? key,
    // required this.boardBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final BoardBloc boardBlocRead = context.read<BoardBloc>();

    final boardBlocWatch = context.watch<BoardBloc>();
    return BlocProvider(
      create: (context) => TimerBloc(
        boardBloc: boardBlocWatch,
        startTime: 5,
      )..add(const LoadTimer()),
      child: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if ((!state.running) && (boardBlocWatch.state is Playing)) {
            context.read<TimerBloc>().add(const TimerStart());
          } else {}
          return Text(state.time.toString());
        },
      ),
    );
  }
}

class BoardScreen extends StatelessWidget {
  const BoardScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BoardBloc(
        appBloc: context.read<AppBloc>(),
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

    return BlocListener<BoardBloc, BoardState>(
      listener: (context, state) {
        final mqData = MediaQuery.of(context);

        final topHeight = mqData.viewPadding.top;
        OverlayEntry? completeOverlay;
        completeOverlay = overlayPopup(
          screenWidth: mqData.size.width,
          top: topHeight,
          child: Column(
            children: [
              Text('Time\'s up!'),
              TextButton(
                onPressed: () {
                  completeOverlay?.remove();

                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => BoardScreen(),
                    ),
                  );
                },
                child: Text('See results'),
              ),
            ],
          ),
        );
        if (state is Complete) {
          Overlay.of(context)?.insert(completeOverlay);
        }
      },
      child: BlocBuilder<BoardBloc, BoardState>(
        builder: (context, state) {
          if (state is Loading) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  bigLoading,
                  Text(
                    'Loading game...',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return GameArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          const Text('Room code:'),
                          Text(context.read<AppBloc>().state.roomCode),
                        ],
                      ),
                      Row(
                        children: const [
                          TimerComponent(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const Text('Accepted'),
                              Text(state.player.getApprovedWords().join('\n')),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                child: const Text('Send'),
                              ),
                            ],
                          );
                        } else if (state is Ready) {
                          return TextButton(
                            onPressed: () {
                              context.read<BoardBloc>().add(const StartGame());
                            },
                            child: const Text('Start'),
                          );
                        } else if (state is Complete) {
                          return const Text('Done!');
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
      ),
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
