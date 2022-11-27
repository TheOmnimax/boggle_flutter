import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/screens/results_screen/bloc/results_bloc.dart';
import 'package:boggle_flutter/shared_widgets/general.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:boggle_flutter/utils/game/boggle_results.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:boggle_flutter/shared_widgets/table_widgets.dart';

part 'results_table.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    required this.boggleBoard,
    Key? key,
  }) : super(key: key);

  final BoggleBoard boggleBoard;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResultsBloc(
        appBloc: context.read<AppBloc>(),
      )..add(const Loading()),
      child: ResultsScreenMain(
        boggleBoard: boggleBoard,
      ),
    );
  }
}

class ResultsScreenMain extends StatelessWidget {
  const ResultsScreenMain({
    required this.boggleBoard,
    Key? key,
  }) : super(key: key);

  final BoggleBoard boggleBoard;

  @override
  Widget build(BuildContext context) {
    return GameArea(
      child: BlocBuilder<ResultsBloc, ResultsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Text('Loading...');
          } else if (state is MainState) {
            return ResultsView(
              boggleResults: state.boggleResults,
              boggleBoard: boggleBoard,
            );
          } else {
            return Text('Invalid state: $state');
          }
        },
      ),
    );
  }
}

class ResultsView extends StatelessWidget {
  const ResultsView({
    required this.boggleResults,
    required this.boggleBoard,
    Key? key,
  }) : super(key: key);

  final BoggleResults boggleResults;
  final BoggleBoard boggleBoard;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WinnerWidget(boggleResults: boggleResults),
          const SizedBox(height: 10),
          ResultsTable(boggleResults: boggleResults),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SharedWords(
                sharedWords: boggleResults.sharedWords,
              ),
              const SizedBox(
                width: 5,
              ),
              BoggleTable(
                rows: boggleBoard.tableRows,
              ),
              const SizedBox(
                width: 5,
              ),
              MissedWords(missedWords: boggleResults.missedWords),
            ],
          )
        ],
      ),
    );
  }
}

class WinnerWidget extends StatelessWidget {
  const WinnerWidget({
    required this.boggleResults,
    Key? key,
  }) : super(key: key);

  final BoggleResults boggleResults;

  @override
  Widget build(BuildContext context) {
    final winners = boggleResults.winnerNames;
    if (winners.isEmpty) {
      return Text('Everyone got 0 points. There were no winners!');
    } else if (winners.length == 1) {
      return Text(
          'Winner: ${winners[0]} (${boggleResults.winningScore} points)');
    } else {
      return Text(
          'Winners (tied): ${winners.join((', '))} (${boggleResults.winningScore} points)');
    }
  }
}

class SharedWords extends StatelessWidget {
  const SharedWords({
    required this.sharedWords,
    Key? key,
  }) : super(key: key);

  final Map<String, List<String>> sharedWords;

  @override
  Widget build(BuildContext context) {
    final sharedList = <String>[];
    sharedWords.forEach((key, value) {
      sharedList.add('$key: ${value.join(', ')}');
    });
    return StandardTable(columnData: {'Shared words': sharedList.join('\n')});
  }
}

class MissedWords extends StatelessWidget {
  const MissedWords({
    required this.missedWords,
    Key? key,
  }) : super(key: key);

  final List<String> missedWords;

  @override
  Widget build(BuildContext context) {
    return StandardTable(columnData: {'Missed words': missedWords.join('\n')});
  }
}
