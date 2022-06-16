import 'dart:async';
import 'dart:convert';

import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:boggle_flutter/utils/http.dart';
import 'package:boggle_flutter/utils/timing.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc({
    required this.appBloc,
  }) : super(const Loading()) {
    on<LoadGame>(_loadGame);
    on<StartGame>(_startGame);
    on<GameStarted>(_gameStarted);
    on<EnteredText>(_enteredText);
    on<AddWord>(_addWord);
    on<EndGame>(_endGame);
    on<ViewResults>(_viewResults);
    on<ResultsReady>(_resultsReady);
  }

  final AppBloc appBloc;

  // TODO: QUESTION: Should I store this in the bloc, or the state?
  GameStatus gameStatus = GameStatus.pre;

  Future checkStarted() async {
    if (gameStatus == GameStatus.pre) {
      final responseBody = await httpPost(
        uri: baseUrl + 'is-started',
        body: {
          'room_code': appBloc.state.roomCode,
        },
      );
      final gameRunning = responseBody['running'] as bool;
      if (gameRunning) {
        if (gameStatus == GameStatus.pre) {
          add(const GameStarted());
        }
      } else {}
    } else {
      final responseBody = await httpPost(
        uri: baseUrl + 'check-in',
        body: {
          'room_code': appBloc.state.roomCode,
          'player_id': appBloc.state.playerId,
          'timestamp': getEpochTime(),
        },
      );
      final gameEnded = responseBody['ended'] as bool;
      if (gameEnded) {
        add(const ResultsReady());
      }
    }
  }

  // TODO: Find how to stop when game is over or exited
  void _serverQuery() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (Timer t) async => await checkStarted());
  }

  Future _loadGame(LoadGame event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'join-game');

    final body = json.encode({
      'room_code': appBloc.state.roomCode,
      'player_id': appBloc.state.playerId,
    });

    final response = await http.post(
      uri,
      headers: sendHeaders,
      body: body,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    final height = responseBody['height'] as int;
    final width = responseBody['width'] as int;
    final gameTime = responseBody['time'] as int;
    final playerId = responseBody['player_id'] as String;
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
      timeRemaining: gameTime,
    ));
    _serverQuery();
  }

  Future _startGame(StartGame event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'start-game');

    final body = json.encode({
      'room_code': appBloc.state.roomCode,
      'player_id': appBloc.state.playerId,
    });

    final response = await http.post(
      uri,
      headers: sendHeaders,
      body: body,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    final gameStarted = responseBody['started'] as bool;
  }

  Future _gameStarted(GameStarted event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'get-game-data');

    final body = json.encode({
      'room_code': appBloc.state.roomCode,
    });

    final response = await http.post(
      uri,
      headers: sendHeaders,
      body: body,
    );

    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    final running = responseBody['running'] as bool;
    if (running) {
      final boggleBoard = BoggleBoard.fromDynamic(responseBody['board']);
      gameStatus = GameStatus.during;
      emit(Playing(
        boggleBoard: boggleBoard,
        player: state.player,
        timeRemaining: state.timeRemaining,
        enteredWord: state.enteredText,
      ));

      // player-start
      final playerStartResponse = httpPost(
        uri: baseUrl + 'player-start',
        body: {
          'room_code': appBloc.state.roomCode,
          'player_id': appBloc.state.playerId,
          'timestamp': getEpochTime(),
        },
      );
    }
  }

  void _enteredText(EnteredText event, Emitter<BoardState> emit) {
    emit(state.copyWith(
      enteredWord: event.text,
    ));
  }

  Future _addWord(AddWord event, Emitter<BoardState> emit) async {
    final word = event.word;
    final uri = Uri.parse(baseUrl + 'add-word');

    final body = json.encode({
      'room_code': appBloc.state.roomCode,
      'player_id': state.player.id,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'word': event.word,
    });

    final response = await http.post(
      uri,
      headers: sendHeaders,
      body: body,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    final reasonString = responseBody['reason'] as String;
    final player =
        state.player.copyWith(); // Create new player to detect state change

    // Is the best way to update the lists to create new BogglePlayer objects?
    if (reasonString == 'ACCEPTED') {
      emit(
        state.copyWith(
          player: player.addApproved(word), // To update with new word info
          enteredWord: '',
        ),
      );
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

      emit(
        state.copyWith(
          player: player.addRejected(
            word: word,
            reason: reason,
          ),
          enteredWord: '',
        ),
      );
    }
  }

  Future _endGame(EndGame event, Emitter<BoardState> emit) async {
    emit(Complete(
      boggleBoard: state.boggleBoard,
      player: state.player,
      enteredWord: state.enteredText,
    ));
    gameStatus = GameStatus.post;
  }

  void _resultsReady(ResultsReady event, Emitter<BoardState> emit) {
    emit(ReadyForResults(
      boggleBoard: state.boggleBoard,
      player: state.player,
      enteredWord: state.enteredText,
    ));
  }

  Future _viewResults(ViewResults event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'get-results');

    final body = json.encode({
      'room_code': appBloc.state.roomCode,
    });

    final response = await http.post(
      uri,
      headers: sendHeaders,
      body: body,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
  }
}
