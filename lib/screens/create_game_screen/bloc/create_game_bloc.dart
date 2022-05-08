import 'dart:convert';

import 'package:boggle_flutter/constants/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc() : super(const MainState()) {
    on<Create>(_create);
  }

  Future<String> _createRoom() async {
    final uri = Uri.parse(baseUrl + 'create-room');

    final headers = {
      'Access-Control-Allow-Origin': '*',
    };

    print('URI: $uri');

    final response = await http.post(
      uri,
      headers: headers,
    );
    print('Got response!');

    final statusCode = response.statusCode;
    print('Response body:');
    print(response.body);
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    print('Got response body!');
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
    print(uri);

    final headers = {
      'Access-Control-Allow-Origin': '*',
    };

    final body = json.encode({
      'room_code': roomCode,
      'width': width.toString(),
      'height': height.toString(),
      'time': time.toString(),
    });

    print('Headers:');
    print(headers);

    final response = await http.post(
      uri,
      body: body,
      headers: headers,
    );

    print(response.body);

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    return response;
  }

  Future _create(Create event, Emitter<CreateGameState> emit) async {
    print('Starting to create utils.game.game...');
    final gameCode = await _createRoom();
    print('Created room!');
    // TODO: Update with more customized time
    final response = await _createGame(
      roomCode: gameCode,
      width: event.width,
      height: event.height,
      time: 90,
    );
    print('Created board!');

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    print(responseBody);

    final playerCode = responseBody['player_id'] as String;

    emit(Joining(
      gameCode: gameCode,
      playerCode: playerCode,
    ));
  }
}
