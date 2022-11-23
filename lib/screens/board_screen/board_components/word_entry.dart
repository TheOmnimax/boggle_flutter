import 'package:flutter/material.dart';

class WordEntry extends StatelessWidget {
  const WordEntry({
    required this.focusNode,
    required this.onEnter,
    required this.onChanged,
    required this.text,
    Key? key,
  }) : super(key: key);

  final FocusNode focusNode;
  final Function(String) onEnter;
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
          width: 250,
          child: TextFormField(
            autofocus: true,
            controller: tc,
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: const Color.fromARGB(100, 237, 237, 237),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.blueAccent,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            focusNode: focusNode,
            onChanged: onChanged,
            onFieldSubmitted: onEnter,
          ),
        ),
      ],
    );
  }
}
