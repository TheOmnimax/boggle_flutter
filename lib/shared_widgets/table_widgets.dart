import 'package:flutter/material.dart';

class StyledTableCell extends StatelessWidget {
  const StyledTableCell({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}

class StandardTable extends StatelessWidget {
  const StandardTable({
    required this.columnData,
    this.columnWidth = const FixedColumnWidth(200),
    Key? key,
  }) : super(key: key);

  final Map<String, String> columnData;
  final TableColumnWidth columnWidth;

  @override
  Widget build(BuildContext context) {
    final headerWidgets = <StyledTableCell>[];
    final dataWidgets = <StyledTableCell>[];
    for (final header in columnData.keys) {
      headerWidgets.add(
        StyledTableCell(
          child: Text(
            header,
          ),
        ),
      );
      dataWidgets.add(
        StyledTableCell(
          child: Text(
            columnData[header]!,
          ),
        ),
      );
    }

    return Table(
      border: TableBorder.all(),
      defaultColumnWidth: columnWidth,
      children: [
        TableRow(children: headerWidgets),
        TableRow(children: dataWidgets),
      ],
    );
  }
}
