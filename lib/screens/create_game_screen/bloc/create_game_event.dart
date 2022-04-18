import 'package:equatable/equatable.dart';

abstract class CreateGameEvent extends Equatable {
  const CreateGameEvent();
}

class Create extends CreateGameEvent {
  const Create({
    required this.time,
    required this.width,
    required this.height,
  });

  final int time;
  final int width;
  final int height;

  @override
  List<Object?> get props => [time, width, height];
}
