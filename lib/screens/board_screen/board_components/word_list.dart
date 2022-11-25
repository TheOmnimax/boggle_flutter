part of 'package:boggle_flutter/screens/board_screen/board_screen.dart';

class _WordListCell extends StatelessWidget {
  const _WordListCell({
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

class WordListDispay extends StatelessWidget {
  const WordListDispay({
    required this.acceptedWords,
    required this.rejectedString,
    Key? key,
  }) : super(key: key);

  final List<String> acceptedWords;
  final String rejectedString;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FixedColumnWidth(200),
        1: FixedColumnWidth(250),
      },
      children: [
        TableRow(
          children: [
            _WordListCell(
              child: Row(
                children: [
                  Text('Accepted'),
                  Icon(
                    Icons.done,
                  )
                ],
              ),
            ),
            _WordListCell(
                child: Row(
              children: [
                Text('Rejected'),
                Icon(
                  Icons.close,
                )
              ],
            )),
          ],
        ),
        TableRow(children: [
          _WordListCell(child: Text(acceptedWords.join('\n'))),
          _WordListCell(child: Text(rejectedString)),
        ]),
      ],
    );
  }
}
