import 'dart:convert';

import 'package:boggle_flutter/bloc/app_bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';
import 'package:boggle_flutter/utils/error_handling/server_error_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.appBloc,
  }) : super(const MainState()) {
    on<SoloGame>(_soloGame);
    on<HostGame>(_hostGame);
    on<JoinGame>(_addPlayer);
    on<CloseError>(_closeError);
  }

  final AppBloc appBloc;

  Future _soloGame(SoloGame event, Emitter<HomeState> emit) async {}
  Future _hostGame(HostGame event, Emitter<HomeState> emit) async {}
  Future _addPlayer(JoinGame event, Emitter<HomeState> emit) async {
    final uri = Uri.parse(baseUrl + 'add-player');
    print('Adding player');
    final response = await http.post(
      uri,
      headers: sendHeaders,
      body: {
        'room_code': event.gameCode,
        'name': event.name,
      },
    );

    final statusCode = response.statusCode;
    if (statusCode >= 400) {
      final errorMessage = ServerErrorHandler.getErrorMessage(response);
      emit(JoinError(
        errorMessage: errorMessage,
      ));
    } else {
      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final playerId = responseBody['player_id'];
      appBloc.add(AddPlayerId(playerId: playerId));
      emit(Joining());
    }
  }

  void _closeError(CloseError event, Emitter<HomeState> emit) {
    emit(const MainState());
  }
}
