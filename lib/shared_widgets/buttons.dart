import 'package:flutter/material.dart';
import 'package:boggle_flutter/constants/theme_data.dart';

class StartButton extends StatelessWidget {
  const StartButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        color: themeColor,
        child: Text(text),
      ),
    );
  }
}
