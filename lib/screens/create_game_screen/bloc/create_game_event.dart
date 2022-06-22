import 'package:equatable/equatable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

abstract class CreateGameEvent extends Equatable {
  const CreateGameEvent();
}

class Create extends CreateGameEvent {
  const Create({
    required this.time,
    required this.width,
    required this.height,
    required this.name,
  });

  final int time;
  final int width;
  final int height;
  final String name;

  @override
  List<Object?> get props => [
        time,
        width,
        height,
        name,
      ];
}

class SetName extends CreateGameEvent {
  const SetName({required this.playerName});

  final String playerName;

  @override
  List<Object?> get props => [playerName];
}

class SetTime extends CreateGameEvent {
  const SetTime({this.gameTime});

  final int? gameTime;

  @override
  List<Object?> get props => [gameTime];
}

class NewAlert extends CreateGameEvent {
  const NewAlert({
    required this.alert,
  });

  final Alert alert;
  @override
  List<Object?> get props => [alert];
}
