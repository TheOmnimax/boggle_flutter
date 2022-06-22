import 'dart:convert';

import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';

class CreateGameBloc extends Bloc<CreateGameEvent, CreateGameState> {
  CreateGameBloc({
    required this.appBloc,
  }) : super(const MainState()) {
    on<Create>(_create);
    on<SetName>(_setName);
    on<SetTime>(_setTime);
    on<NewAlert>(_newAlert);
  }

  final AppBloc appBloc;

  Future<String> _createRoom() async {
    print('Creating room...');

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
    final gameCode = await _createRoom();
    // TODO: Update with more customized time
    final response = await _createGame(
      roomCode: gameCode,
      width: event.width,
      height: event.height,
      time: state.gameTime ??
          90, // TIME SENT TO SERVER. The game time should never actually be null.
      name: event.name,
    );

    final statusCode = response.statusCode;
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

  void _setName(SetName event, Emitter<CreateGameState> emit) {
    print('Setting name to ${event.playerName}');
    emit(state.copyWith(playerName: event.playerName));
  }

  void _setTime(SetTime event, Emitter<CreateGameState> emit) {
    emit(state.copyWith(gameTime: event.gameTime ?? 0));
  }

  void _newAlert(NewAlert event, Emitter<CreateGameState> emit) {
    state.alert?.dismiss();
    emit(state.copyWith(alert: event.alert));
    state.alert?.show();
  }
}
