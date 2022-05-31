import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Name: '),
        SizedBox(
          child: TextField(
            onChanged: onChanged,
          ),
          width: 200,
        ),
      ],
    );
  }
}
