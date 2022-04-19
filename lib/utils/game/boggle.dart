import 'dart:convert';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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

  static List<List<String>> getHiddenBoard() {
    final spaces = <List<String>>[];
    // for

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
