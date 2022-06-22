import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    required this.onChanged,
    required this.tc,
    Key? key,
  }) : super(key: key);

  final Function(String) onChanged;
  final TextEditingController tc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Name: '),
        SizedBox(
          child: TextFormField(
            onChanged: onChanged,
            controller: tc,
          ),
          width: 200,
        ),
      ],
    );
  }
}
