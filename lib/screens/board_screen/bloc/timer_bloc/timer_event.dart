import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object?> get props => [];
}

class LoadTimer extends TimerEvent {
  const LoadTimer();
}

class TimerStart extends TimerEvent {
  const TimerStart();
}

class TimerUpdated extends TimerEvent {
  const TimerUpdated({
    required this.timeRemaining,
  });

  final int timeRemaining;
}
