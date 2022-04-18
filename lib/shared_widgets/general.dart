import 'package:flutter/material.dart';

class GameArea extends StatelessWidget {
  const GameArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
    );
  }
}
