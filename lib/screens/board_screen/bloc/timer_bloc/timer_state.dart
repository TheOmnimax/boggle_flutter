import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  const TimerState({
    required this.time,
  });

  final int time;

  @override
  List<Object?> get props => [time];

  TimerState copyWith({
    int? time,
  }) {
    return TimerState(time: time ?? this.time);
  }
}
