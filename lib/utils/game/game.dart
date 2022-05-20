import 'dart:async';

class GameTimer {
  GameTimer({
    required this.msStart,
  });

  final int msStart;
  bool _timerRunning = false;
  int _epochStart = 0;
  int _timePassed = 0;
  int _savedTimePassed = 0;
  bool _ended = false;

  void updateTimer() {
    if (_timerRunning) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      _timePassed = _savedTimePassed + (currentTime - _epochStart);
      if (msStart <= _timePassed) {
        _ended = true;
      }
    }
  }

  void startTimer() {
    _savedTimePassed =
        _timePassed; // Just in case running this function without pausing first
    _epochStart = DateTime.now().millisecondsSinceEpoch;
    _timerRunning = true;
    Timer(
      const Duration(milliseconds: 5),
      updateTimer,
    );
  }

  void pauseTimer() {
    _timerRunning = false;
    _savedTimePassed = _timePassed;
  }

  int getTime() {
    return msStart - _timePassed;
  }

  int getTimeNoNeg() {
    final timeRemaining = getTime();
    if (timeRemaining < 0) {
      return 0;
    } else {
      return timeRemaining;
    }
  }

  bool timerEnded() {
    return _ended;
  }
}

class Player {
  const Player({
    required this.id,
    this.name = '',
    this.score = 0,
    this.isHost = false,
  });

  final String id;
  final String name;
  final int score;
  final bool isHost;
}

class Game {
  const Game({
    required this.players,
  });

  final List<Player> players;
}

class GameRoom {
  const GameRoom();
}
