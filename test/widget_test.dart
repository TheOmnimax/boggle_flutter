import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:boggle_flutter/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

// WordListDispay(
// acceptedWords: ['Word1', 'Word2'],
// rejectedString: 'One\nTwo')

// const boggleResults = BoggleResults(
//     sharedWords: {
//       'word': ['p1']
//     },
//     bogglePlayerResults: [
//       BogglePlayerResults(
//           name: 'p1',
//           scoreList: {
//             'one': 1,
//             'three': 3,
//           },
//           score: 4),
//       BogglePlayerResults(name: 'p2', scoreList: {'two': 1}, score: 1),
//     ],
//     winnerNames: ['p1'],
//     winningScore: 1,
//     missedWords: ['Five', 'Six', '7', '8', '9', '10', '11', '12']);
