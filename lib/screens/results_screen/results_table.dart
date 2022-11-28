part of 'results_screen.dart';

class ResultsTable extends StatelessWidget {
  const ResultsTable({
    required this.boggleResults,
    Key? key,
  }) : super(key: key);

  final BoggleResults boggleResults;

  @override
  Widget build(BuildContext context) {
    final resultData = <String, String>{};
    for (final player in boggleResults.bogglePlayerResults) {
      final scoreList = <String>[];
      player.scoreList.forEach((key, value) {
        scoreList.add('$key: $value');
      });
      resultData['${player.name}: ${player.score}'] = scoreList.join('\n');
    }
    return StandardTable(columnData: resultData);
  }
}
