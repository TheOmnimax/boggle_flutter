import 'dart:math';

import 'package:boggle_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

import 'game.dart';

const kDiceBoxSize = 50.0;

class BoggleBoard {
  const BoggleBoard({
    required this.spaces,
    required this.tableRows,
  });

  final List<List<String>> spaces;
  final List<TableRow> tableRows;

  // static const _blank = [
  //   ['⬤']
  // ]

  static List<List<String>> getHiddenBoard({
    required int width,
    required int height,
  }) {
    final spaces = <List<String>>[];
    for (var r = 0; r < width; r++) {
      final row = <String>[];
      for (var c = 0; c < height; c++) {
        row.add('⬤');
      }
      spaces.add(row);
    }

    return spaces;
  }

  static BoggleBoard fromDynamic(List<dynamic> data) {
    print('About to process board...');
    final spaces = <List<String>>[];
    for (final row in data) {
      print('In row...');
      final spaceRow = <String>[];
      for (final letter in row) {
        print('Processing item');
        spaceRow.add(letter);
      }
      spaces.add(spaceRow);
    }

    return BoggleBoard(
      spaces: spaces,
      tableRows: _getRows(spaces: spaces),
    );
  }

  static BoggleBoard createHiddenBoard({
    required int width,
    required int height,
  }) {
    final hiddenSpaces = getHiddenBoard(width: width, height: height);
    return fromDynamic(hiddenSpaces);
  }

  static List<TableRow> _getRows({
    required List<List<String>> spaces,
  }) {
    final tableRows = <TableRow>[];
    for (final row in spaces) {
      final tableCells = <BoggleCell>[];
      for (final letter in row) {
        tableCells.add(BoggleCell(letter: letter));
      }
      tableRows.add(TableRow(children: tableCells));
    }

    return tableRows;
  }
}

class BoggleCell extends StatelessWidget {
  const BoggleCell({
    required this.letter,
    Key? key,
  }) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kDiceBoxSize,
      height: kDiceBoxSize,
      decoration: BoxDecoration(
        color: Colors.blue,
        // border: Border.all(
        //   color: Colors.blueGrey,
        // ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: Text(letter),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFF0),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class BoggleTable extends StatelessWidget {
  const BoggleTable({
    required this.rows,
    Key? key,
  }) : super(key: key);

  final List<TableRow> rows;

  @override
  Widget build(BuildContext context) {
    var numCols = 0;

    for (final row in rows) {
      numCols = max(row.children?.length ?? 0, numCols);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          constraints: BoxConstraints(maxWidth: numCols * kDiceBoxSize),
          child: Table(
            children: rows,
            defaultColumnWidth: FractionColumnWidth(1 / numCols),
          ),
        ),
      ),
    );
  }
}

class BogglePlayer extends Player {
  const BogglePlayer({
    required String id,
    String name = '',
    bool isHost = false,
  }) : super(
          id: id,
          name: name,
          isHost: isHost,
        );

  final List<String> _approvedWords = const [];
  final Map<String, WordReason> _rejectedWords = const <String, WordReason>{};

  void addApproved(String word) {
    _approvedWords.add(word);
  }

  void addRejected({
    required String word,
    required WordReason reason,
  }) {
    _rejectedWords[word] = reason;
  }

  List<String> getApprovedWords() {
    return _approvedWords;
  }

  Map<String, WordReason> getRejectedWords() {
    return _rejectedWords;
  }

  String getRejectedString() {
    final rejectedList = <String>[];

    for (final key in _rejectedWords.keys) {
      rejectedList.add('$key: ${_rejectedWords[key]}');
    }

    return rejectedList.join('\n');
  }
}

// class BoggleGame extends Game {
//   const BoggleGame({
//     required this.boggleBoard,
//     // required this.timer,
//     required this.roomCode,
//     required List<Player> players,
//   }) : super(players: players);
//
//   final BoggleBoard boggleBoard;
//   // final GameTimer timer;
//   final String roomCode;
//
//   static BoggleGame loadingBoard() {
//     return const BoggleGame(
//       boggleBoard: const BoggleBoard(
//         spaces: <List<String>>[],
//         tableRows: [],
//
//       ),
//       // timer: GameTimer(msStart: 0),
//       roomCode: '',
//       players: [],
//     );
//   }
// }
