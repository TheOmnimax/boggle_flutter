import 'package:flutter/material.dart';

class WordEntry extends StatelessWidget {
  const WordEntry({
    required this.onChanged,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Function(String) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    final tc = TextEditingController();
    tc.text = text;

    tc
      ..text = text
      ..selection =
          TextSelection(baseOffset: text.length, extentOffset: text.length);
    return Column(
      children: [
        const Text('Enter word:'),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: tc,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
