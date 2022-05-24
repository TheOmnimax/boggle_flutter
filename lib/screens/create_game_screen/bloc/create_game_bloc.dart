import 'dart:convert';

import 'package:boggle_flutter/bloc/bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc({
    required this.appBloc,
  }) : super(const MainState()) {
    on<Create>(_create);
  }

  final AppBloc appBloc;

  Future<String> _createRoom() async {
    final uri = Uri.parse(baseUrl + 'create-room');

    final response = await http.post(
      uri,
      headers: sendHeaders,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    final gameCode = responseBody['room_code'] as String;
    return gameCode;
  }

  Future<http.Response> _createGame({
    required String roomCode,
    required int width,
    required int height,
    required int time,
  }) async {
    final uri = Uri.parse(baseUrl + 'create-game');

    final body = json.encode({
      'room_code': roomCode,
      'width': width,
      'height': height,
      'time': time,
    });

    final response = await http.post(
      uri,
      body: body,
      headers: sendHeaders,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    return response;
  }

  Future _create(Create event, Emitter<CreateGameState> emit) async {
    final gameCode = await _createRoom();
    // TODO: Update with more customized time
    final response = await _createGame(
      roomCode: gameCode,
      width: event.width,
      height: event.height,
      time: 5,
    );

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    final playerCode = responseBody['player_id'] as String;

    appBloc.add(
        AddGameInfo(roomCode: gameCode, playerId: playerCode, isHost: true));
    emit(Joining(
      gameCode: gameCode,
      playerCode: playerCode,
    ));
  }
}
