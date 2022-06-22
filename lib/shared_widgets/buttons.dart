import 'package:boggle_flutter/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

class PopupCloseButton extends DialogButton {
  PopupCloseButton({
    required this.context,
    Key? key,
  }) : super(
          child: const Text(
            'Close',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          key: key,
        );

  final BuildContext context;
}
