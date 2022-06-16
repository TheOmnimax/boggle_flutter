part of 'timer_bloc.dart';

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

class TimeChange extends TimerEvent {
  const TimeChange({
    required this.timeRemaining,
  });

  final int timeRemaining;
}
