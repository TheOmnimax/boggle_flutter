import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'package:http/http.dart' as http;
import 'package:boggle_flutter/utils/game/boggle.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'dart:convert';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  BoardBloc({
    required this.gameCode,
    required this.playerCode,
  }) : super(const Loading()) {
    on<LoadGame>(_loadGame);
    on<StartGame>(_startGame);
    on<AddWord>(_addWord);
    on<EndGame>(_endGame);
    on<ViewResults>(_viewResults);
  }

  // TODO: QUESTION: Should I define the Boggle board here, or should it be passed around the states?
  final String gameCode;
  final String playerCode;
  final List<String> approvedWords = [];
  final List<String> rejectedWords = [];

  Future _loadGame(LoadGame event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'join-game');

    final headers = {
      'room_code': gameCode,
    };

    final response = await http.post(
      uri,
      headers: headers,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    print(responseBody['board']);
    final boardRaw = responseBody['board'] as List<dynamic>;
    final boggleBoard = BoggleBoard.fromDynamic(boardRaw);
    emit(Ready(boggleBoard: boggleBoard));
  }

  Future _startGame(StartGame event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'start-game');

    final headers = {
      'room_code': gameCode,
    };

    final response = await http.post(
      uri,
      headers: headers,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    emit(Playing(boggleBoard: state.boggleBoard));
  }

  Future _addWord(AddWord event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'add-word');

    final headers = {
      'room_code': gameCode,
    };

    final response = await http.post(
      uri,
      headers: headers,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    emit(Playing(boggleBoard: state.boggleBoard));
  }

  Future _endGame(EndGame event, Emitter<BoardState> emit) async {}

  Future _viewResults(ViewResults event, Emitter<BoardState> emit) async {
    final uri = Uri.parse(baseUrl + 'get-results');

    final headers = {
      'room_code': gameCode,
    };

    final response = await http.post(
      uri,
      headers: headers,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
  }
}
