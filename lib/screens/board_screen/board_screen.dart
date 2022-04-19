import 'package:flutter/material.dart';
import 'package:boggle_flutter/screens/board_screen/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';

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
        gameCode: gameCode,
        playerCode: playerCode,
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
        print('Game code: ${boardBloc.gameCode}');
        print('Player code: ${boardBloc.playerCode}');
        if (state is Loading) {
          return Text('Loading...');
        } else {
          return GameArea(
            child: Row(
              children: [
                Container(),
                BoggleTable(
                  rows: state.boggleBoard.tableRows,
                ),
                Container(),
              ],
            ),
          );
        }
      },
    );
  }
}

class WordEntry extends StatelessWidget {
  const WordEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [],
        )
      ],
    );
  }
}
