import 'dart:async';

import 'package:boggle_flutter/screens/board_screen/bloc/board_bloc/bloc.dart';
import 'package:boggle_flutter/utils/game/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'timer_event.dart';
import 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({
    required this.startTime,
    required this.boardBloc,
  }) : super(TimerState(time: startTime)) {
    on<LoadTimer>(_loadTimer);
    on<TimerStart>(_timerStart);
    on<TimeChange>(_timeChange);
  }

  final BoardBloc boardBloc;
  final int startTime;
  GameTimer? gameTimer;
  bool gameEnded = false;

  void _loadTimer(LoadTimer event, Emitter<TimerState> emit) {
    gameTimer = GameTimer(msStart: startTime * 1000);
    emit(TimerState(time: startTime));
  }

  void _timerCountdown() {
    const duration = Duration(milliseconds: 10);
    Timer.periodic(duration, (Timer t) {
      if (gameTimer == null) {
        print('Error: No game timer found');
      } else {
        gameTimer?.updateTimer();
        final timeRemaining = gameTimer?.getTimeNoNeg() ?? 0;
        if (timeRemaining != state.time) {
          add(TimeChange(timeRemaining: (timeRemaining / 1000).ceil()));
        }

        if (!gameEnded && (timeRemaining == 0)) {
          gameEnded = true;
          boardBloc.add(const EndGame());
        }
      }
    });
  }

  void _timerStart(TimerStart event, Emitter<TimerState> emit) {
    gameTimer?.startTimer();
    _timerCountdown();
    emit(state.copyWith(
      running: true,
    ));
  }

  void _timeChange(TimeChange event, Emitter<TimerState> emit) {
    emit(state.copyWith(time: event.timeRemaining));
  }
}
