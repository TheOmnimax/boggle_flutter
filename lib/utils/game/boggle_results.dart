class BogglePlayerResults {
  const BogglePlayerResults({
    required this.name,
    required this.scoreList,
    required this.score,
  });

  final String name;
  final Map<String, int> scoreList; // TODO: Update to an ordered map
  final int score;

  static BogglePlayerResults fromJson(Map<String, dynamic> data) {
    final scoreList = <String, int>{};
    final scoreListRaw = data['score_list'];
    for (final pairingRaw in scoreListRaw) {
      final pairing = pairingRaw as List<dynamic>;
      final word = pairing[0] as String;
      final score = pairing[1] as int;
      scoreList[word] = score;
    }

    return BogglePlayerResults(
      name: data['name'] as String,
      scoreList: scoreList,
      score: data['score'] as int,
    );
  }
}

class BoggleResults {
  const BoggleResults({
    required this.sharedWords,
    required this.bogglePlayerResults,
    required this.winningScore,
    required this.winnerNames,
    required this.missedWords,
  });

  final Map<String, List<String>> sharedWords;
  final List<BogglePlayerResults> bogglePlayerResults;
  final int winningScore;
  final List<String> winnerNames;
  final List<String> missedWords;

  static BoggleResults fromJson(Map<String, dynamic> data) {
    // Shared words
    final rawShared = data['shared_words'] as Map<String, dynamic>;
    final sharedWords = <String, List<String>>{};
    for (final key in rawShared.keys) {
      final mapVal = rawShared[key] as List;
      final playerList = <String>[];
      for (final item in mapVal) {
        playerList.add(item);
      }
      sharedWords[key] = playerList;
    }

    // Scores
    final playerDataRaw = data['player_data'] as List<dynamic>;
    final allPlayerData = <BogglePlayerResults>[];
    for (final item in playerDataRaw) {
      final playerData =
          BogglePlayerResults.fromJson(item as Map<String, dynamic>);
      allPlayerData.add(playerData);
    }

    // Winner names
    final winnerNames = <String>[];
    final winnerNamesRaw = data['winner_names'] as List<dynamic>;
    for (final item in winnerNamesRaw) {
      winnerNames.add(item as String);
    }

    final missedWords = List<String>.from(data['missed_words'] as List);

    return BoggleResults(
      sharedWords: sharedWords,
      bogglePlayerResults: allPlayerData,
      winningScore: data['winning_score'] as int,
      winnerNames: winnerNames,
      missedWords: missedWords,
    );
  }
}
