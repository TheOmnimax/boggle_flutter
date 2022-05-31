import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/screens/results_screen/bloc/bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/utils/game/boggle_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsBloc(
        appBloc: context.read<AppBloc>(),
      )..add(const Loading()),
      child: const ResultsScreenMain(),
    );
  }
}

class ResultsScreenMain extends StatelessWidget {
  const ResultsScreenMain({Key? key}) : super(key: key);

  List<Widget> getPlayerCols({
    required List<BogglePlayerResults> bogglePlayerResults,
  }) {
    final playerCols = <Widget>[];
    for (final player in bogglePlayerResults) {
      playerCols.add(PlayerResultWidget(
        bogglePlayerResults: player,
      ));
    }
    return playerCols;
  }

  @override
  Widget build(BuildContext context) {
    return GameArea(
      child: BlocBuilder<ResultsBloc, ResultsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Text('Loading...');
          } else if (state is MainState) {
            final cols = getPlayerCols(
                bogglePlayerResults: state.boggleResults.bogglePlayerResults);
            cols.insert(
                0,
                Column(
                  children: [
                    Text(
                        'Winner: ${state.boggleResults.winnerNames.toString()}'),
                    Text('Score: ${state.boggleResults.winningScore}')
                  ],
                ));
            return Row(
              children: cols,
            );
          } else {
            return Text('Invalid state: $state');
          }
        },
      ),
    );
  }
}

class PlayerResultWidget extends StatelessWidget {
  const PlayerResultWidget({
    required this.bogglePlayerResults,
    Key? key,
  }) : super(key: key);

  final BogglePlayerResults bogglePlayerResults;

  List<Widget> getWordRows({required Map<String, int> scoreList}) {
    final wordRows = <Widget>[];
    for (final word in scoreList.keys) {
      wordRows.add(WordRow(
        word: word,
        score: scoreList[word] as int,
      ));
    }
    return wordRows;
  }

  @override
  Widget build(BuildContext context) {
    final rows = getWordRows(scoreList: bogglePlayerResults.scoreList);
    rows.insert(
        0, Text('${bogglePlayerResults.name}: ${bogglePlayerResults.score}'));
    return Column(
      children: rows,
    );
  }
}

class WordRow extends StatelessWidget {
  const WordRow({
    required this.word,
    required this.score,
    Key? key,
  }) : super(key: key);

  final String word;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Text('$word: $score');
  }
}
