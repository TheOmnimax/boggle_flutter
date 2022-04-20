import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc() : super(const MainState()) {
    on<Create>(_create);
  }

  Future<String> _createRoom() async {
    final uri = Uri.parse(baseUrl + 'create-room');
    print('URI: $uri');

    final response = await http.post(
      uri,
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

  Future<http.Response> _createBoard({
    required String gameCode,
    required int width,
    required int height,
  }) async {
    final uri = Uri.parse(baseUrl + 'create-board');
    print(uri);

    final headers = {
      'room_code': gameCode,
      'width': width.toString(),
      'height': height.toString(),
    };

    final response = await http.post(
      uri,
      headers: headers,
    );

    print(response.body);

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    return response;
  }

  Future _create(Create event, Emitter<CreateGameState> emit) async {
    print('Starting to create game...');
    final gameCode = await _createRoom();
    print('Created room!');
    final response = await _createBoard(
      gameCode: gameCode,
      width: event.width,
      height: event.height,
    );
    print('Created board!');

    final statusCode = response.statusCode;
    final responseBody = json.decode(response.body) as Map<String, dynamic>;

    final playerCode = responseBody['player_id'] as String;

    emit(Joining(
      gameCode: gameCode,
      playerCode: playerCode,
    ));
  }
}
