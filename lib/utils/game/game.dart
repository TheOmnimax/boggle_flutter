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

  void updateTimer() {
    if (_timerRunning) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      _timePassed = _savedTimePassed + (currentTime - _epochStart);
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
