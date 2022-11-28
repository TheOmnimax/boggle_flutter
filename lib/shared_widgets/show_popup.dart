import 'package:flutter/material.dart';

class WarningButton extends StatelessWidget {
  const WarningButton({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class WarningPopup extends StatelessWidget {
  const WarningPopup({
    required this.context,
    required this.title,
    required this.message,
    required this.buttons,
    Key? key,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String message;
  final List<WarningButton> buttons;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        Text(message),
        Row(
          children: buttons,
        )
      ],
    );
  }
}

Future<void> showPopup({
  required BuildContext context,
  required String title,
  required List<Widget> buttons,
  required Widget body,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: body,
        ),
        actions: buttons,
      );
    },
  );
}

OverlayEntry overlayPopup({
  required double screenWidth,
  double top = 0,
  double width = 200,
  Widget child = const Text(
    'No options available!',
    style: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
  ),
}) {
  final left = (screenWidth - width) / 2;

  return OverlayEntry(
    builder: (BuildContext context) {
      return Positioned(
        left: left,
        top: top,
        width: width,
        child: Material(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            ),
          ),
        ),
      );
    },
  );
}

// class AlertWithBloc extends Alert {
//   AlertWithBloc({Key? key}) : super();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
