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

class ScreenButton extends StatelessWidget {
  const ScreenButton({
    required this.onPressed,
    required this.label,
    Key? key,
  }) : super(key: key);

  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 45,
        width: 90,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color.fromARGB(100, 158, 208, 240),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lexend Deca',
            ),
          ),
        ),
      ),
    );
  }
}
