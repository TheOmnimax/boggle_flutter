import 'dart:convert';

import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/http.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'create_game_event.dart';
part 'create_game_state.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc({
    required this.appBloc,
  }) : super(const MainState()) {
    on<Create>(_create);
  }

  final AppBloc appBloc;

  Future<String> _createRoom() async {
    final response = await Http.post(
      uri: baseUrl + 'create-room',
      body: {},
    );
    final responseBody = Http.jsonDecode(response.body);
    final gameCode = responseBody['room_code'] as String;
    return gameCode;
  }

  Future<http.Response> _createGame({
    required String roomCode,
    required int width,
    required int height,
    required int time,
    required String name,
  }) async {
    final uri = Uri.parse(baseUrl + 'create-game');

    final body = json.encode({
      'room_code': roomCode,
      'width': width,
      'height': height,
      'time': time,
      'name': name,
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
    emit(const LoadingGame());
    // try {
    final gameCode = await _createRoom();
    final response = await _createGame(
      roomCode: gameCode,
      width: event.width,
      height: event.height,
      time: event.time ??
          90, // TIME SENT TO SERVER. The game time should never actually be null.
      name: event.name,
    );

    final statusCode = response.statusCode;

    if (statusCode >= 400) {
      emit(JoinError(errorMessage: '$statusCode ${response.reasonPhrase}'));
    } else {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      final playerCode = responseBody['player_id'] as String;

      appBloc.add(AddGameInfo(
        roomCode: gameCode,
        playerId: playerCode,
        playerName: event.name,
        isHost: true,
      ));
      emit(Joining(
        gameCode: gameCode,
        playerCode: playerCode,
      ));
    }
    // } catch (e) {
    //   emit(JoinError(errorMessage: e.toString()));
    //   return;
    // }
  }
}
