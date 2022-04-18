import 'dart:convert';
import 'package:flutter/material.dart';

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
    return Text(letter);
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
    return Table(
      children: rows,
    );
  }
}
