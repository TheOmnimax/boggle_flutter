import 'dart:async';
import 'dart:convert';

import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc({
    required this.roomCode,
    this.hostId = '',
  }) : super(const Loading()) {
    on<LoadGame>(_loadGame);
    on<StartGame>(_startGame);
    on<AddWord>(_addWord);
    on<EndGame>(_endGame);
    on<ViewResults>(_viewResults);
  }

  final String roomCode;
  final String hostId;

  Future checkStarted() async {
    final uri = Uri.parse(baseUrl + 'is-started');

    final headers = {
      'Access-Control-Allow-Origin': '*',
    };

    final body = json.encode({
      'room_code': roomCode,
    });

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    final gameRunning = responseBody['running'] as bool;
    if (gameRunning) {
      print('Playing!');
      add(const StartGame());
    } else {
      print('Get ready...');
    }
  }

  // TODO: Find how to stop when game is over or exited
  void _timer() {
    print('Starting timer');
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (Timer t) async => await checkStarted());
  }

  Future _loadGame(LoadGame event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'join-game');

    final headers = {
      'Access-Control-Allow-Origin': '*',
    };

    final body = json.encode({
      'room_code': roomCode,
      'host_id': hostId,
    });

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    final statusCode = response.statusCode;
    print(response.body);
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    print('Joined game');
    print(responseBody);
    final height = responseBody['height'] as int;
    final width = responseBody['width'] as int;
    final gameTime = responseBody['time'] as int;
    final playerId = responseBody['player_id'] as String;
    print(responseBody['board']);
    // final boardRaw = responseBody['board'] as List<dynamic>;
    final boggleBoard = BoggleBoard.createHiddenBoard(
      width: width,
      height: height,
    );

    // TODO: Update with host info
    final bogglePlayer = BogglePlayer(
      id: playerId,
      isHost: true,
    );

    // TODO: Update player and time remaining with values from server
    emit(Ready(
      boggleBoard: boggleBoard,
      player: bogglePlayer,
      timeRemaining: 90,
    ));
    _timer();
  }

  Future _startGame(StartGame event, Emitter<BoardState> emit) async {
    print('Starting game!');
    final uri = Uri.parse(baseUrl + 'start-game');

    final headers = {
      'Access-Control-Allow-Origin': '*',
    };

    final body = json.encode({
      'room_code': roomCode,
      'player_id': state.player.id,
    });

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    final statusCode = response.statusCode;
    print(statusCode);
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    print(responseBody);

    final gameStarted = responseBody['started'] as bool;

    if (gameStarted) {
      final boggleBoard = BoggleBoard.fromDynamic(responseBody['board']);

      emit(Playing(
        boggleBoard: boggleBoard,
        player: state.player,
        timeRemaining: state.timeRemaining,
        enteredWord: state.enteredWord,
      ));
    }
  }

  Future _addWord(AddWord event, Emitter<BoardState> emit) async {
    final word = event.word;
    final uri = Uri.parse(baseUrl + 'add-word');

    final headers = {
      'Access-Control-Allow-Origin': '*',
    };

    final body = json.encode({
      'room_code': roomCode,
    });

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    final reasonString = responseBody['reason'] as String;
    final player = state.player;

    if (reasonString == 'ACCEPTED') {
      player.addApproved(word);
    } else {
      final WordReason reason;
      switch (reasonString) {
        case 'TOO_SHORT':
          {
            reason = WordReason.tooShort;
            break;
          }
        case 'NOT_FOUND':
          {
            reason = WordReason.notFound;
            break;
          }
        case 'NOT_A_WORD':
          {
            reason = WordReason.notAWord;
            break;
          }
        case 'SHARED_WORD':
          {
            reason = WordReason.sharedWord;
            break;
          }
        case 'NO_TIME':
          {
            reason = WordReason.noTime;
            break;
          }
        case 'ALREADY_ADDED':
          {
            reason = WordReason.alreadyAdded;
            break;
          }
        default:
          {
            reason = WordReason.unknown;
          }
      }
      player.addRejected(
        word: word,
        reason: reason,
      );
    }

    emit(state.copyWith(
      player: player,
    ));
  }

  Future _endGame(EndGame event, Emitter<BoardState> emit) async {}

  Future _viewResults(ViewResults event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'get-results');

    final headers = {
      'Access-Control-Allow-Origin': '*',
    };

    final body = json.encode({
      'room_code': roomCode,
    });

    final response = await http.post(
      uri,
      headers: headers,
      body: body,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
  }
}
