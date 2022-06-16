part of 'timer_bloc.dart';

class TimerState extends Equatable {
  const TimerState({
    required this.time,
    this.running = false,
  });

  final int time;
  final bool running;

  @override
  List<Object?> get props => [time, running];

  TimerState copyWith({
    int? time,
    bool? running,
  }) {
    return TimerState(
      time: time ?? this.time,
      running: running ?? this.running,
    );
  }
}
