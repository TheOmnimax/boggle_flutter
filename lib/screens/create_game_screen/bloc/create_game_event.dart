import 'package:equatable/equatable.dart';

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
