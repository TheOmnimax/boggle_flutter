import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/screens/results_screen/results_screen.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/shared_widgets/loading.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:boggle_flutter/screens/board_screen/bloc/timer_bloc/timer_bloc.dart';

import 'package:boggle_flutter/shared_widgets/buttons.dart';
import 'package:boggle_flutter/shared_widgets/table_widgets.dart';
import 'bloc/board_bloc/board_bloc.dart';

part 'board_components/timer_component.dart';
part 'board_components/word_entry.dart';
part 'board_components/word_list.dart';

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

class BoardScreenMain extends StatefulWidget {
  const BoardScreenMain({Key? key}) : super(key: key);

  @override
  State<BoardScreenMain> createState() => _BoardScreenMainState();
}

class _BoardScreenMainState extends State<BoardScreenMain> {
  Alert? popup;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BoardBloc, BoardState>(
      listener: (context, state) {
        if (state is Complete) {
          popup = Alert(
            context: context,
            title: "Time's up!",
            desc: 'Please wait for the results to be calculated...',
            buttons: [],
            style: popupStyle,
          );
          popup?.show();
        } else if (state is ReadyForResults) {
          popup?.dismiss();
          popup = Alert(
            context: context,
            title: 'Results ready',
            desc: 'Results are ready! Click the button below to view them.',
            buttons: [
              DialogButton(
                child: const Text(
                  'See results',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => ResultsScreen(
                        boggleBoard: state.boggleBoard,
                      ),
                    ),
                  );
                },
              )
            ],
            style: popupStyle,
          );
          popup?.show();
        } else {}
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
                          SelectableText(
                              context.read<AppBloc>().state.roomCode),
                        ],
                      ),
                      Row(
                        children: const [
                          TimerComponent(),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      BoggleTable(
                        rows: state.boggleBoard.tableRows,
                      ),
                      Builder(
                        builder: (context) {
                          final focusNode = FocusNode();
                          if (state is Playing) {
                            return Column(
                              children: [
                                WordEntry(
                                  focusNode: focusNode,
                                  onEnter: (String word) {
                                    context
                                        .read<BoardBloc>()
                                        .add(AddWord(word: word));
                                    focusNode.requestFocus();
                                  },
                                  onChanged: (String word) {
                                    context
                                        .read<BoardBloc>()
                                        .add(EnteredText(text: word));
                                  },
                                  text: state.enteredText,
                                ),
                                ScreenButton(
                                  label: 'Send',
                                  onPressed: () {
                                    context.read<BoardBloc>().add(AddWord(
                                          word: state.enteredText,
                                        ));
                                  },
                                ),
                              ],
                            );
                          } else if (state is Ready) {
                            if (state.player.isHost) {
                              return ScreenButton(
                                label: 'Start',
                                onPressed: () {
                                  context
                                      .read<BoardBloc>()
                                      .add(const StartGame());
                                },
                              );
                            } else {
                              return const Text(
                                'Please wait for the\nhost to start the game',
                                textAlign: TextAlign.center,
                              );
                            }
                          } else if (state is Complete) {
                            return const Text('Done!');
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  ),
                  WordListDispay(
                      acceptedWords: state.player.getApprovedWords(),
                      rejectedString: state.player.getRejectedString()),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
